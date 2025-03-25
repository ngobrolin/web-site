defmodule Ngobrolin.Youtube do
  @moduledoc """
    Fetches YouTube video data from playlist id with YouTube API v3.
  """

  import Ecto.Query
  alias Ngobrolin.Content.Episode
  alias Ngobrolin.Content

  def fetch_videos(playlist_id, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, Application.get_env(:ngobrolin, :youtube_api_key))
    http_client = Keyword.get(opts, :http_client, &default_http_client/2)
    do_fetch_videos(playlist_id, api_key, http_client)
  end

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

  def sync(playlist_id) do
    # Collect all video_ids from the playlist
    videos = fetch_videos(playlist_id)
    video_ids = Enum.map(videos, & &1.video_id)
    # Check if the video_ids are already in the database
    existing_video_ids = Ngobrolin.Repo.all(from e in Episode, select: e.youtube_id)
    # Fetch durations for the videos
    api_key = System.get_env("YOUTUBE_API_KEY")
    http_client = &default_http_client/2
    durations_map = fetch_video_durations(video_ids, api_key, http_client)
    # Filter out the video_ids that are already in the database
    new_video_ids = video_ids -- existing_video_ids
    # Insert new videos into the database
    Enum.each(new_video_ids, fn video_id ->
      video = Enum.find(videos, fn v -> v.video_id == video_id end)

      Ngobrolin.Repo.insert!(%Episode{
        youtube_id: video.video_id,
        title: video.title,
        description: video.description,
        thumbnail_url: video.thumbnail,
        published_at: video.published_at,
        status: "",
        duration: Map.get(durations_map, video.video_id)
      })
    end)

    # Return the list of new video_ids
    new_video_ids
  end

  def youtube_urls() do
    episodes = Content.list_new_episodes()

    Enum.map(episodes, fn episode ->
      {episode, "https://www.youtube.com/watch?v=#{episode.youtube_id}"}
    end)
  end

  def download_new_episodes() do
    episodes = youtube_urls()

    Enum.each(episodes, fn {episode, url} ->
      download_episode({episode, url})
    end)
  end

  # Upload audio to S3
  def upload_audio() do
    episodes = Content.list_new_audio()
    # Upload each audio file to S3
    Enum.each(episodes, fn episode ->
      # Upload to S3

      body = File.read!("./priv/static/audio/#{episode.youtube_id}.mp3")

      IO.puts("Uploading #{episode.youtube_id}...")

      ExAws.S3.put_object("ngweb-assets", "#{episode.youtube_id}.mp3", body, acl: :public_read)
      |> ExAws.request!()

      # Update the episode status to "uploaded"
      Content.update_episode(episode, %{status: "uploaded"})
    end)
  end

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

  defp fetch_video_durations(video_ids, api_key, http_client) do
    # Batch video IDs in chunks of 50 (YouTube API limit)
    video_ids
    |> chunk_video_ids(50)
    |> Enum.reduce(%{}, fn batch, acc ->
      batch_result = fetch_video_durations_batch(batch, api_key, http_client)
      Map.merge(acc, batch_result)
    end)
  end

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

  defp chunk_video_ids(video_ids, chunk_size) do
    video_ids
    |> Enum.chunk_every(chunk_size)
  end

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
