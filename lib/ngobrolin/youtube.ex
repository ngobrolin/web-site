defmodule Ngobrolin.Youtube do
  @moduledoc """
    Fetches YouTube video data from playlist id with YouTube API v3.
  """

  import Ecto.Query
  alias Ngobrolin.Content.Episode

  def fetch_videos(playlist_id, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, Application.get_env(:ngobrolin, :youtube_api_key))
    http_client = Keyword.get(opts, :http_client, &default_http_client/2)
    url = "https://www.googleapis.com/youtube/v3/playlistItems"

    params =
      URI.encode_query(%{
        part: "snippet,contentDetails",
        maxResults: 150,
        playlistId: playlist_id,
        key: api_key
      })

    full_url = "#{url}?#{params}"

    case http_client.(full_url, []) do
      {:ok, %{status: 200, body: body}} ->
        parse_response(Jason.decode!(body))

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
        published_at: published_at
      }
    end)
  end

  def sync(playlist_id) do
    # Collect all video_ids from the playlist
    videos = fetch_videos(playlist_id)
    video_ids = Enum.map(videos, & &1.video_id)
    # Check if the video_ids are already in the database
    existing_video_ids = Ngobrolin.Repo.all(from e in Episode, select: e.youtube_id)
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
        published_at: video.published_at
      })
    end)

    # Return the list of new video_ids
    new_video_ids
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
