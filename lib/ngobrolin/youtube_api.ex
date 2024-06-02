defmodule Ngobrolin.YoutubeApi do
  @moduledoc """
  Interface for Youtube API
  """

  @doc """
  Get videos from playlist
  """
  def request_episodes_from_playlist(playlist_id) do
    {:ok, %Finch.Response{status: 200, body: body}} = Finch.build(:get, "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=100&playlistId=#{playlist_id}&key=#{System.get_env("YOUTUBE_API_KEY")}") |> Finch.request(Ngobrolin.Finch)
    body
  end

  def parse_body(body) do
    body
    |> Jason.decode!()
    |> Map.get("items")
    |> Enum.map(fn item ->
      %{
        title: Map.get(item, "snippet")["title"],
        video_id: Map.get(item, "snippet")["resourceId"]["videoId"]
      }
    end)
  end
end