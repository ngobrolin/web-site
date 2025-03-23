defmodule Ngobrolin.Youtube do
  @moduledoc """
    Fetches YouTube video data from playlist id with YouTube API v3.
  """

  def fetch_videos(playlist_id, opts \\ []) do
    api_key = Keyword.get(opts, :api_key, Application.get_env(:ngobrolin, :youtube_api_key))
    http_client = Keyword.get(opts, :http_client, &default_http_client/2)
    url = "https://www.googleapis.com/youtube/v3/playlistItems"

    params =
      URI.encode_query(%{
        part: "snippet",
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
      %{
        title: item["snippet"]["title"],
        description: item["snippet"]["description"],
        thumbnail: item["snippet"]["thumbnails"]["default"]["url"],
        video_id: item["snippet"]["resourceId"]["videoId"]
      }
    end)
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
