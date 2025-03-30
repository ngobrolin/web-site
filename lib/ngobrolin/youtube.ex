defmodule Ngobrolin.Youtube do
  @moduledoc """
  Fetches and processes YouTube video data using YouTube API v3.

  This module handles syncing YouTube videos to the database, downloading
  videos as audio files, and uploading them to S3.
  """

  import Ecto.Query
  alias Ngobrolin.Content.Episode
  alias Ngobrolin.Content
  alias Ngobrolin.Repo

  @youtube_api_base_url "https://www.googleapis.com/youtube/v3"
  @s3_bucket_name "ngweb-assets"
  @audio_dir "./priv/static/audio"

  # API Functions

  @doc """
  Synchronizes videos from a YouTube playlist to the database.

  ## Parameters
    - playlist_id: The ID of the YouTube playlist to sync
    - opts: Optional parameters
      - api_key: YouTube API key (defaults to environment variable)
      - http_client: HTTP client function (defaults to Finch)
      - repo: Repository module (defaults to Ngobrolin.Repo)
      
  ## Returns
    - {:ok, new_video_ids} on success
    - {:error, reason} on failure
  """
  def sync(playlist_id, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, api_key_from_env())
    http_client = Keyword.get(opts, :http_client, &default_http_client/2)
    repo = Keyword.get(opts, :repo, Repo)

    with {:ok, videos} <- fetch_videos(playlist_id, api_key: api_key, http_client: http_client),
         video_ids = extract_video_ids(videos),
         existing_video_ids = get_existing_video_ids(repo),
         new_video_ids = filter_new_video_ids(video_ids, existing_video_ids),
         {:ok, durations_map} <-
           fetch_all_video_durations(video_ids, api_key: api_key, http_client: http_client),
         :ok <- insert_new_episodes(videos, new_video_ids, durations_map, repo: repo) do
      {:ok, new_video_ids}
    else
      {:error, reason} -> {:error, reason}
      error -> {:error, error}
    end
  end

  @doc """
  Fetches videos from a YouTube playlist.

  ## Parameters
    - playlist_id: The ID of the YouTube playlist to fetch videos from
    - opts: Optional parameters
      - api_key: YouTube API key (defaults to environment variable)
      - http_client: HTTP client function (defaults to Finch)
      
  ## Returns
    - {:ok, videos} on success where videos is a list of video data structures
    - {:error, reason} on failure
  """
  def fetch_videos(playlist_id, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, api_key_from_env())
    http_client = Keyword.get(opts, :http_client, &default_http_client/2)

    do_fetch_videos(playlist_id, api_key, http_client)
  end

  @doc """
  Parses the response from the YouTube API.

  ## Parameters
    - response: The response map from the YouTube API
    
  ## Returns
    - List of maps containing video details
  """
  def parse_response(%{"items" => items}) do
    Enum.map(items, fn item ->
      with {:ok, published_at} <- parse_published_at(item),
           title <- get_in(item, ["snippet", "title"]),
           description <- get_in(item, ["snippet", "description"]),
           thumbnail <- get_in(item, ["snippet", "thumbnails", "standard", "url"]),
           video_id <- get_in(item, ["snippet", "resourceId", "videoId"]),
           position <- get_in(item, ["snippet", "position"]) || 0 do
        %{
          title: title,
          description: description,
          thumbnail: thumbnail,
          video_id: video_id,
          published_at: published_at,
          episode_number: position + 1
        }
      else
        _error -> nil
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  def parse_response(_), do: []

  @doc """
  Gets YouTube URLs for new episodes.

  ## Parameters
    - opts: Optional parameters
      - content_api: Content API module (defaults to Ngobrolin.Content)
      
  ## Returns
    - List of tuples containing {episode, youtube_url}
  """
  def youtube_urls(opts \\ []) do
    content_api = Keyword.get(opts, :content_api, Content)

    content_api.list_new_episodes()
    |> Enum.map(fn episode ->
      {episode, youtube_url(episode.youtube_id)}
    end)
  end

  @doc """
  Downloads all new episodes that need to be downloaded.

  ## Parameters
    - opts: Optional parameters
      - content_api: Content API module (defaults to Ngobrolin.Content)
      - downloader: Download function (defaults to schedule_episode_download)
      
  ## Returns
    - {:ok, count} on success where count is the number of episodes scheduled for download
    - {:error, reason} on failure
  """
  def download_new_episodes(opts \\ []) do
    content_api = Keyword.get(opts, :content_api, Content)
    downloader = Keyword.get(opts, :downloader, &schedule_episode_download/1)

    episode_urls = youtube_urls(content_api: content_api)

    Enum.each(episode_urls, downloader)

    {:ok, length(episode_urls)}
  end

  @doc """
  Schedules an episode for download.

  ## Parameters
    - {episode, url}: Tuple of episode and YouTube URL
    - opts: Optional parameters
      - task_supervisor: Task supervisor module (defaults to Task)
      - download_fn: Download function (defaults to download_episode)
      
  ## Returns
    - Task reference
  """
  def schedule_episode_download({episode, url}, opts \\ []) do
    task_supervisor = Keyword.get(opts, :task_supervisor, Task)
    download_fn = Keyword.get(opts, :download_fn, &download_episode/1)

    task_supervisor.async(fn ->
      download_fn.({episode, url})
    end)
  end

  @doc """
  Uploads all downloaded audio files to S3.

  ## Parameters
    - opts: Optional parameters
      - content_api: Content API module (defaults to Ngobrolin.Content)
      - uploader: Upload function (defaults to upload_single_audio)
      
  ## Returns
    - {:ok, count} on success where count is the number of episodes uploaded
    - {:error, reason} on failure
  """
  def upload_audio(opts \\ []) do
    content_api = Keyword.get(opts, :content_api, Content)
    uploader = Keyword.get(opts, :uploader, &upload_single_audio/1)

    episodes = content_api.list_new_audio()

    Enum.each(episodes, uploader)

    {:ok, length(episodes)}
  end

  @doc """
  Uploads a single audio file to S3.

  ## Parameters
    - episode: Episode struct with youtube_id
    - opts: Optional parameters
      - file_reader: File reading function (defaults to File.read!)
      - s3_uploader: S3 upload function (defaults to upload_to_s3)
      - status_updater: Status update function (defaults to update_episode_status)
      
  ## Returns
    - {:ok, updated_episode} on success
    - {:error, reason} on failure
  """
  def upload_single_audio(episode, opts \\ []) do
    file_reader = Keyword.get(opts, :file_reader, &File.read!/1)
    s3_uploader = Keyword.get(opts, :s3_uploader, &upload_to_s3/2)
    status_updater = Keyword.get(opts, :status_updater, &update_episode_status/2)

    audio_path = "#{@audio_dir}/#{episode.youtube_id}.mp3"

    with {:ok, body} <- safe_read_file(audio_path, file_reader),
         :ok <- s3_uploader.(episode.youtube_id, body),
         {:ok, updated_episode} <- status_updater.(episode, "uploaded") do
      {:ok, updated_episode}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Uploads a file to S3.

  ## Parameters
    - youtube_id: YouTube ID to use as the filename
    - body: File content to upload
    - opts: Optional parameters
      - bucket: S3 bucket name (defaults to @s3_bucket_name)
      - s3_client: S3 client module (defaults to ExAws.S3)
      
  ## Returns
    - :ok on success
    - {:error, reason} on failure
  """
  def upload_to_s3(youtube_id, body, opts \\ []) do
    bucket = Keyword.get(opts, :bucket, @s3_bucket_name)
    s3_client = Keyword.get(opts, :s3_client, ExAws.S3)

    try do
      s3_client.put_object(bucket, "#{youtube_id}.mp3", body, acl: :public_read)
      |> ExAws.request!()

      :ok
    rescue
      e -> {:error, e}
    end
  end

  @doc """
  Updates the status of an episode.

  ## Parameters
    - episode: Episode struct to update
    - status: New status string
    - content_api: Content API module (defaults to Ngobrolin.Content)
    
  ## Returns
    - {:ok, updated_episode} on success
    - {:error, changeset} on failure
  """
  def update_episode_status(episode, status, content_api \\ Content) do
    content_api.update_episode(episode, %{status: status})
  end

  # Data Transformation Functions

  @doc """
  Extracts video IDs from a list of video data.

  ## Parameters
    - videos: List of video data structures
    
  ## Returns
    - List of video IDs
  """
  def extract_video_ids(videos) do
    Enum.map(videos, & &1.video_id)
  end

  @doc """
  Gets a list of existing video IDs from the database.

  ## Parameters
    - repo: Repository module (defaults to Ngobrolin.Repo)
    
  ## Returns
    - List of YouTube video IDs that are already in the database
  """
  def get_existing_video_ids(repo \\ Repo) do
    repo.all(from e in Episode, select: e.youtube_id)
  end

  @doc """
  Filters out video IDs that already exist in the database.

  ## Parameters
    - video_ids: List of all video IDs
    - existing_video_ids: List of existing video IDs
    
  ## Returns
    - List of new video IDs not yet in the database
  """
  def filter_new_video_ids(video_ids, existing_video_ids) do
    video_ids -- existing_video_ids
  end

  @doc """
  Fetches durations for all videos in a list.

  ## Parameters
    - video_ids: List of video IDs to fetch durations for
    - opts: Optional parameters
      - api_key: YouTube API key (defaults to environment variable)
      - http_client: HTTP client function (defaults to Finch)
      - chunk_size: Number of videos per request (defaults to 50)
      
  ## Returns
    - {:ok, durations_map} on success where durations_map maps video_id to duration in seconds
    - {:error, reason} on failure
  """
  def fetch_all_video_durations(video_ids, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, api_key_from_env())
    http_client = Keyword.get(opts, :http_client, &default_http_client/2)
    chunk_size = Keyword.get(opts, :chunk_size, 50)

    result =
      video_ids
      |> Enum.chunk_every(chunk_size)
      |> Enum.reduce_while({:ok, %{}}, fn batch, {:ok, acc} ->
        case fetch_video_durations_batch(batch, api_key, http_client) do
          {:ok, batch_result} -> {:cont, {:ok, Map.merge(acc, batch_result)}}
          {:error, reason} -> {:halt, {:error, reason}}
        end
      end)

    result
  end

  @doc """
  Inserts new episodes into the database.

  ## Parameters
    - videos: List of video data structures
    - new_video_ids: List of video IDs to insert
    - durations_map: Map of video_id to duration in seconds
    - opts: Optional parameters
      - repo: Repository module (defaults to Ngobrolin.Repo)
    
  ## Returns
    - :ok on success
  """
  def insert_new_episodes(videos, new_video_ids, durations_map, opts \\ []) do
    repo = Keyword.get(opts, :repo, Repo)

    Enum.each(new_video_ids, fn video_id ->
      with video when not is_nil(video) <- Enum.find(videos, fn v -> v.video_id == video_id end) do
        insert_episode(video, durations_map, repo)
      end
    end)

    :ok
  end

  @doc """
  Inserts a single episode into the database.

  ## Parameters
    - video: Video data structure
    - durations_map: Map of video_id to duration in seconds
    - repo: Repository module (defaults to Ngobrolin.Repo)
    
  ## Returns
    - The inserted Episode struct
  """
  def insert_episode(video, durations_map, repo \\ Repo) do
    %Episode{
      youtube_id: video.video_id,
      title: video.title,
      description: video.description,
      thumbnail_url: video.thumbnail,
      published_at: video.published_at,
      status: "",
      duration: Map.get(durations_map, video.video_id)
    }
    |> repo.insert!()
  end

  # Private helper functions

  defp api_key_from_env do
    System.get_env("YOUTUBE_API_KEY")
  end

  defp parse_published_at(item) do
    case get_in(item, ["contentDetails", "videoPublishedAt"]) do
      nil ->
        {:error, :no_published_at}

      datetime_string ->
        case NaiveDateTime.from_iso8601(datetime_string) do
          {:ok, datetime} -> {:ok, datetime}
          error -> error
        end
    end
  end

  defp youtube_url(video_id) do
    "https://www.youtube.com/watch?v=#{video_id}"
  end

  defp safe_read_file(path, file_reader) do
    try do
      {:ok, file_reader.(path)}
    rescue
      e in File.Error -> {:error, e.reason}
      e -> {:error, e}
    end
  end

  defp download_episode({episode, url}) do
    try do
      output_path = "#{@audio_dir}/#{episode.youtube_id}.mp3"

      result =
        System.cmd("yt-dlp", [
          "-x",
          "--audio-format",
          "mp3",
          "-o",
          output_path,
          url
        ])

      case result do
        {_output, 0} ->
          update_episode_status(episode, "downloaded")

        {error, code} ->
          {:error, "Download failed with code #{code}: #{error}"}
      end
    rescue
      e -> {:error, "Download error: #{inspect(e)}"}
    end
  end

  defp do_fetch_videos(playlist_id, api_key, http_client, page_token \\ nil, acc \\ []) do
    url = "#{@youtube_api_base_url}/playlistItems"

    params =
      URI.encode_query(%{
        part: "snippet,contentDetails",
        playlistId: playlist_id,
        maxResults: 50,
        key: api_key,
        pageToken: page_token
      })

    full_url = "#{url}?#{params}"

    case http_client.(full_url, []) do
      {:ok, %{status: 200, body: body}} ->
        data = Jason.decode!(body)
        items = parse_response(data)
        next_token = Map.get(data, "nextPageToken")
        new_acc = acc ++ items

        if next_token do
          do_fetch_videos(playlist_id, api_key, http_client, next_token, new_acc)
        else
          {:ok, new_acc}
        end

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp fetch_video_durations_batch(video_ids, api_key, http_client) do
    url = "#{@youtube_api_base_url}/videos"

    params =
      URI.encode_query(%{
        part: "contentDetails",
        id: Enum.join(video_ids, ","),
        key: api_key
      })

    full_url = "#{url}?#{params}"

    case http_client.(full_url, []) do
      {:ok, %{status: 200, body: body}} ->
        data = Jason.decode!(body)

        case Map.get(data, "items") do
          nil ->
            {:error, :missing_items}

          items ->
            durations =
              Enum.into(items, %{}, fn item ->
                {item["id"], parse_duration(get_in(item, ["contentDetails", "duration"]))}
              end)

            {:ok, durations}
        end

      {:ok, %{status: status, body: body}} ->
        {:error, {status, body}}

      error ->
        {:error, error}
    end
  end

  defp parse_duration(nil), do: 0
  defp parse_duration(""), do: 0

  defp parse_duration(duration_string) do
    regex = ~r/^PT((?<hours>\d+)H)?((?<minutes>\d+)M)?((?<seconds>\d+)S)?$/

    case Regex.named_captures(regex, duration_string) do
      nil ->
        0

      %{"hours" => h, "minutes" => m, "seconds" => s} ->
        hours = if h == "", do: 0, else: String.to_integer(h)
        minutes = if m == "", do: 0, else: String.to_integer(m)
        seconds = if s == "", do: 0, else: String.to_integer(s)

        hours * 3600 + minutes * 60 + seconds
    end
  end

  defp default_http_client(url, headers) do
    Finch.build(:get, url, headers)
    |> Finch.request(Ngobrolin.Finch)
    |> case do
      {:ok, %Finch.Response{status: status, body: body}} ->
        {:ok, %{status: status, body: body}}

      error ->
        error
    end
  end
end
