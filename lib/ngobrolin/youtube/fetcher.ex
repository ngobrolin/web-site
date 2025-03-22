defmodule Ngobrolin.Youtube.Fetcher do
  @moduledoc """
    Fetches YouTube video data from playlist id with YouTube API v3.
  """

  def fetch_videos(playlist_id) do
    api_key = Application.get_env(:ngobrolin, :youtube_api_key)
    url = "https://www.googleapis.com/youtube/v3/playlistItems"
    dbg(api_key)

    params =
      URI.encode_query(%{
        part: "snippet",
        maxResults: 150,
        playlistId: playlist_id,
        key: api_key
      })

    full_url = "#{url}?#{params}"

    case Finch.build(:get, full_url, []) |> Finch.request(Ngobrolin.Finch) do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        parse_response(Jason.decode!(body))

      {:error, reason} ->
        {:error, reason}
    end
  end

  def parse_response(%{"items" => items}) do
    Enum.map(items, fn item ->
      %{
        title: item["snippet"]["title"],
        description: item["snippet"]["description"],
        thumbnail: item["snippet"]["thumbnails"]["default"]["url"],
        video_id: item["snippet"]["resourceId"]["videoId"]
      }
    end)
  end
end
