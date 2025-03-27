defmodule Ngobrolin.Youtube do
  @moduledoc """
    Fetches YouTube video data from playlist id with YouTube API v3.
  """

  import Ecto.Query
  alias Ngobrolin.Content.Episode
  alias Ngobrolin.Content

  @doc """
  Fetches videos from a YouTube playlist using the YouTube API.

  ## Parameters
    - playlist_id: The ID of the YouTube playlist to fetch videos from
    - opts: Optional parameters, including :http_client for testing
    
  ## Returns
    List of video data structures or {:error, reason}
  """
  def fetch_videos(playlist_id, opts \\ []) do
    api_key = System.get_env("YOUTUBE_API_KEY")
    http_client = Keyword.get(opts, :http_client, &default_http_client/2)
    do_fetch_videos(playlist_id, api_key, http_client)
  end

  @doc """
  Parses the response from the YouTube API.

  ## Parameters
    - items: The "items" field from the YouTube API response
    
  ## Returns
    List of maps containing video details
  """
  def parse_response(%{"items" => items}) do
    Enum.map(items, fn item ->
      published_at =
        item["contentDetails"]["videoPublishedAt"]
        |> NaiveDateTime.from_iso8601!()

      %{
        title: item["snippet"]["title"],
        description: item["snippet"]["description"],
        thumbnail: item["snippet"]["thumbnails"]["standard"]["url"],
        video_id: item["snippet"]["resourceId"]["videoId"],
        published_at: published_at,
        episode_number: (item["snippet"]["position"] || 0) + 1
      }
    end)
  end

  @doc """
  Synchronizes videos from a YouTube playlist to the database.

  ## Parameters
    - playlist_id: The ID of the YouTube playlist to sync
    
  ## Returns
    List of video IDs that were newly added to the database
  """
  def sync(playlist_id) do
    # Collect all video_ids from the playlist
    videos = fetch_videos(playlist_id)
    video_ids = extract_video_ids(videos)

    # Get existing videos and find new ones
    existing_video_ids = get_existing_video_ids()
    new_video_ids = filter_new_video_ids(video_ids, existing_video_ids)

    # Fetch durations and insert new episodes
    durations_map = fetch_all_video_durations(video_ids)
    insert_new_episodes(videos, new_video_ids, durations_map)

    # Return the list of new video_ids
    new_video_ids
  end

  @doc """
  Gets YouTube URLs for new episodes.

  ## Returns
    List of tuples containing {episode, youtube_url}
  """
  def youtube_urls() do
    episodes = Content.list_new_episodes()

    Enum.map(episodes, fn episode ->
      {episode, "https://www.youtube.com/watch?v=#{episode.youtube_id}"}
    end)
  end

  @doc """
  Downloads all new episodes that need to be downloaded.

  ## Side effects
    Initiates download tasks for new episodes
  """
  def download_new_episodes() do
    youtube_urls()
    |> Enum.each(&schedule_episode_download/1)
  end

  @doc """
  Uploads all downloaded audio files to S3.

  ## Side effects
    Uploads files to S3 and updates episode status
  """
  def upload_audio() do
    Content.list_new_audio()
    |> Enum.each(&upload_single_audio/1)
  end

  # New functions for better single responsibility

  @doc """
  Extracts video IDs from a list of video data.

  ## Parameters
    - videos: List of video data structures
    
  ## Returns
    List of video IDs
  """
  def extract_video_ids(videos) do
    Enum.map(videos, & &1.video_id)
  end

  @doc """
  Gets a list of existing video IDs from the database.

  ## Returns
    List of YouTube video IDs that are already in the database
  """
  def get_existing_video_ids() do
    Ngobrolin.Repo.all(from e in Episode, select: e.youtube_id)
  end

  @doc """
  Filters out video IDs that already exist in the database.

  ## Parameters
    - video_ids: List of all video IDs
    - existing_video_ids: List of existing video IDs
    
  ## Returns
    List of new video IDs not yet in the database
  """
  def filter_new_video_ids(video_ids, existing_video_ids) do
    video_ids -- existing_video_ids
  end

  @doc """
  Fetches durations for all videos in a list.

  ## Parameters
    - video_ids: List of video IDs to fetch durations for
    
  ## Returns
    Map of video_id to duration in seconds
  """
  def fetch_all_video_durations(video_ids) do
    api_key = System.get_env("YOUTUBE_API_KEY")
    http_client = &default_http_client/2
    fetch_video_durations(video_ids, api_key, http_client)
  end

  @doc """
  Inserts new episodes into the database.

  ## Parameters
    - videos: List of video data structures
    - new_video_ids: List of video IDs to insert
    - durations_map: Map of video_id to duration in seconds
    
  ## Side effects
    Inserts records into the database
  """
  def insert_new_episodes(videos, new_video_ids, durations_map) do
    Enum.each(new_video_ids, fn video_id ->
      video = Enum.find(videos, fn v -> v.video_id == video_id end)
      insert_episode(video, durations_map)
    end)
  end

  @doc """
  Inserts a single episode into the database.

  ## Parameters
    - video: Video data structure
    - durations_map: Map of video_id to duration in seconds
    
  ## Returns
    The inserted Episode struct
    
  ## Side effects
    Inserts a record into the database
  """
  def insert_episode(video, durations_map) do
    Ngobrolin.Repo.insert!(%Episode{
      youtube_id: video.video_id,
      title: video.title,
      description: video.description,
      thumbnail_url: video.thumbnail,
      published_at: video.published_at,
      status: "",
      duration: Map.get(durations_map, video.video_id)
    })
  end

  @doc """
  Schedules an episode for download.

  ## Parameters
    - {episode, url}: Tuple of episode and YouTube URL
    
  ## Side effects
    Starts an asynchronous download task
  """
  def schedule_episode_download({episode, url}) do
    download_episode({episode, url})
  end

  @doc """
  Uploads a single audio file to S3.

  ## Parameters
    - episode: Episode struct with youtube_id
    
  ## Side effects
    Uploads file to S3 and updates episode status
  """
  def upload_single_audio(episode) do
    audio_path = "./priv/static/audio/#{episode.youtube_id}.mp3"
    body = File.read!(audio_path)

    IO.puts("Uploading #{episode.youtube_id}...")

    upload_to_s3(episode.youtube_id, body)
    update_episode_status(episode, "uploaded")
  end

  @doc """
  Uploads a file to S3.

  ## Parameters
    - youtube_id: YouTube ID to use as the filename
    - body: File content to upload
    
  ## Side effects
    Uploads file to S3
  """
  def upload_to_s3(youtube_id, body) do
    ExAws.S3.put_object("ngweb-assets", "#{youtube_id}.mp3", body, acl: :public_read)
    |> ExAws.request!()
  end

  @doc """
  Updates the status of an episode.

  ## Parameters
    - episode: Episode struct to update
    - status: New status string
    
  ## Returns
    Updated Episode struct
    
  ## Side effects
    Updates record in database
  """
  def update_episode_status(episode, status) do
    Content.update_episode(episode, %{status: status})
  end

  # Private functions below

  @doc false
  # Fetches videos from a YouTube playlist with pagination support
  #
  # Parameters:
  #   - playlist_id: The ID of the YouTube playlist to fetch videos from
  #   - api_key: YouTube API key
  #   - http_client: HTTP client function
  #   - page_token: Token for pagination (nil for first page)
  #   - acc: Accumulated results from previous pages
  #
  # Returns: List of video data structures or {:error, reason}
  defp do_fetch_videos(playlist_id, api_key, http_client, page_token \\ nil, acc \\ []) do
    url = "https://www.googleapis.com/youtube/v3/playlistItems"

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

        if next_token,
          do: do_fetch_videos(playlist_id, api_key, http_client, next_token, new_acc),
          else: new_acc

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc false
  # Downloads an episode from YouTube using yt-dlp
  # 
  # Parameters:
  #   - {episode, url}: Tuple of episode struct and YouTube URL
  defp download_episode({episode, url}) do
    Task.async(fn ->
      IO.puts("Downloading #{episode.youtube_id}: #{url}")
      # Download audio version using yt-dlp cli
      System.cmd("yt-dlp", [
        "-x",
        "--audio-format",
        "mp3",
        "-o",
        "./priv/static/audio/#{episode.youtube_id}.mp3",
        url
      ])

      Content.update_episode(episode, %{status: "downloaded"})
    end)
  end

  @doc false
  # Fetches video durations for a batch of videos
  #
  # Parameters:
  #   - video_ids: List of video IDs to get durations for
  #   - api_key: YouTube API key
  #   - http_client: HTTP client function
  #
  # Returns: Map of video_id to duration in seconds
  defp fetch_video_durations(video_ids, api_key, http_client) do
    # Batch video IDs in chunks of 50 (YouTube API limit)
    video_ids
    |> chunk_video_ids(50)
    |> Enum.reduce(%{}, fn batch, acc ->
      batch_result = fetch_video_durations_batch(batch, api_key, http_client)
      Map.merge(acc, batch_result)
    end)
  end

  @doc false
  # Fetches video durations for a single batch of videos (max 50 IDs)
  defp fetch_video_durations_batch(video_ids, api_key, http_client) do
    url = "https://www.googleapis.com/youtube/v3/videos"

    params =
      URI.encode_query(%{part: "contentDetails", id: Enum.join(video_ids, ","), key: api_key})

    full_url = "#{url}?#{params}"

    case http_client.(full_url, []) do
      {:ok, %{status: 200, body: body}} ->
        %{"items" => items} = Jason.decode!(body)

        Enum.into(items, %{}, fn item ->
          {item["id"], parse_duration(item["contentDetails"]["duration"])}
        end)

      {:ok, %{status: status, body: body}} ->
        IO.puts("YouTube API error (status #{status}): #{body}")
        %{}

      _error ->
        %{}
    end
  end

  @doc false
  # Splits video IDs into chunks of specified size
  defp chunk_video_ids(video_ids, chunk_size) do
    video_ids
    |> Enum.chunk_every(chunk_size)
  end

  @doc false
  # Parses ISO 8601 duration format to seconds
  defp parse_duration(nil), do: 0
  defp parse_duration(""), do: 0

  defp parse_duration(duration_string) do
    regex = ~r/^PT((?<hours>\d+)H)?((?<minutes>\d+)M)?((?<seconds>\d+)S)?$/

    case Regex.named_captures(regex, duration_string) do
      nil ->
        0

      %{"hours" => h, "minutes" => m, "seconds" => s} ->
        String.to_integer(if h == "", do: "0", else: h) * 3600 +
          String.to_integer(if m == "", do: "0", else: m) * 60 +
          String.to_integer(if s == "", do: "0", else: s)
    end
  end

  @doc false
  # Default HTTP client implementation using Finch
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
