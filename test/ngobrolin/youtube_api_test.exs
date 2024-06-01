defmodule Ngobrolin.YoutubeMockApi do
  def request_videos_from_playlist(_playlist_id) do
    Jason.encode!(%{
      kind: "youtube#playlistItemListResponse",
      etag: "J9J7JlR2zvcYaVAdR8WeNb5EEAI",
      nextPageToken: "EAAajQFQVDpDRElpRUVJd1JEWXlPVGsxTnpjME5rVkZRMEVvQVVqanZhN1Zocm1HQTFBQldrUWlRMmxLVVZSR1VscE5iVFZZVGtkd00yUkZZelJWTTJkNVVXNWpNbFZXVG05UmVra3pUVlpDTmxkRVRYaFJNMUpWUldkelNUUnllbkJ6WjFsUmRVdFlaRVozSWc",
      items: [
        %{
          kind: "youtube#playlistItem",
          etag: "THKvJKXioTsGnWNCuLZ0rUjut2k",
          id: "UExUWTJuVzRqd3RHOFN4MkJ3NlFTaEMyNzFQelgzMUN0VC40NzE2MTY1QTM3RUI3QkU3",
          snippet: %{
            publishedAt: "2024-05-27T03:10:30Z",
            channelId: "UCHhAlFGFCGgIusQkQIqJLYw",
            title: "Mengintip Masa Depan Web AI: Apa yang Disiapkan Google?",
            description: "Mengintip Masa Depan Web AI: Apa yang Disiapkan Google? -\n\nPada episode ini, kita akan membahas tentang masa depan web AI dan apa yang disiapkan Google untuknya."
          }
        },
        %{
          kind: "youtube#playlistItem", 
          etag: "TQKvJKXioTsGnWNCuLZ0rUjut2k",
          id: "UCxUWTJuVzRqd3RHOFN4MkJ3NlFTaEMyNzFQelgzMUN0VC40NzE2MTY1QTM3RUI3QkU3",
          snippet: %{
            publishedAt: "2024-04-27T03:10:30Z",
            channelId: "UCHhAlFGFCGgIusQkQIqJLYw",
            title: "Title 2",
            description: "Description 2"
          }
        }
      ]
    })
  end
end
defmodule Ngobrolin.YoutubeApiTest do
  use ExUnit.Case

  @playlist_id "PLTY2nW4jwtG8Sx2Bw6QShC271PzX31CtT"
  
  test "smoke test" do
    assert true
  end

  test "Get videos from playlist" do
    videos = Ngobrolin.YoutubeMockApi.request_videos_from_playlist(@playlist_id) |> Ngobrolin.YoutubeApi.parse_body()
    assert Enum.count(videos) > 1
  end

end