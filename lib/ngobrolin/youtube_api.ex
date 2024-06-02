defmodule Ngobrolin.YoutubeApi do
  @moduledoc """
  Interface for Youtube API
  """

  @doc """
  Get videos from playlist
  """
  def request_episodes_from_playlist(playlist_id, page_token \\ nil) do
    url = 
      "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=#{playlist_id}&key=#{System.get_env("YOUTUBE_API_KEY")}"
      <> (if page_token, do: "&pageToken=#{page_token}", else: "")

    {:ok, %Finch.Response{status: 200, body: body}} =
      Finch.build(:get, url)
      |> Finch.request(Ngobrolin.Finch)

    # Parse the body and extract the nextPageToken
    # Then call this function recursively with the nextPageToken to get more results

    body
  end

  def parse_body(body) do
    body
    |> Jason.decode!()
    |> Map.get("items")
    |> Enum.map(fn item ->
      %{
        title: Map.get(item, "snippet")["title"],
        video_id: Map.get(item, "snippet")["resourceId"]["videoId"],
        description: Map.get(item, "snippet")["description"],
        artwork: Map.get(item, "snippet")["thumbnails"]["maxres"]["url"]
      }
    end)
  end
end
