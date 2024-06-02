defmodule Ngobrolin.YoutubeMockApi do

  def request_episodes_from_playlist(_playlist_id) do
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
            description: "Mengintip Masa Depan Web AI: Apa yang Disiapkan Google? -\n\nPada episode ini, kita akan membahas tentang masa depan web AI dan apa yang disiapkan Google untuknya.",
            thumbnails: %{
              maxres: %{
                url: "https://i.ytimg.com/vi/1.jpg"
              }
            }
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
            description: "Description 2",
            thumbnails: %{
              maxres: %{
                url: "https://i.ytimg.com/vi/2.jpg"
              }
            }
          }
        }
      ]
    })
  end
end

defmodule Ngobrolin.YoutubeApiTest do
  # use ExUnit.Case
  use Ngobrolin.DataCase
  alias Ngobrolin.Content

  @playlist_id "PLTY2nW4jwtG8Sx2Bw6QShC271PzX31CtT"
  
  test "smoke test" do
    assert true
  end

  test "Get episodes from playlist" do
    episodes = Ngobrolin.YoutubeMockApi.request_episodes_from_playlist(@playlist_id) |> Ngobrolin.YoutubeApi.parse_body()
    assert Enum.count(episodes) > 1
  end

  # using upsert?
  test "skip save episode if already exists" do 
    # insert episode
    {:ok, _episode} = Content.create_episode(%{
      title: "Mengintip Masa Depan Web AI: Apa yang Disiapkan Google?",
      description: "Mengintip Masa Depan Web AI: Apa yang Disiapkan Google? -\n\nPada episode ini, kita akan membahas tentang masa depan web AI dan apa yang disiapkan Google untuknya.",
      artwork: "test",
      youtubeid: "UCxUWTJuVzRqd3RHOFN4MkJ3NlFTaEMyNzFQelgzMUN0VC40NzE2MTY1QTM3RUI3QkU3",
    })

    # call request_episodes_from_playlist
    new_episodes = Ngobrolin.YoutubeMockApi.request_episodes_from_playlist(@playlist_id) |> Ngobrolin.YoutubeApi.parse_body()

    # insert episode from request
    Enum.each(new_episodes, fn episode ->
      Ngobrolin.Content.create_episode(%{
        title: episode.title,
        youtubeid: episode.video_id,
        description: episode.description,
        artwork: "test"
      })
    end)
    
    assert Content.list_episodes() |> Enum.count() == 2

    # check if episode already exists

    # make sure episode is not inserted
  end

end