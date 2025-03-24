defmodule Ngobrolin.YouTubeTest do
  use Ngobrolin.DataCase

  alias Ngobrolin.Youtube

  import Ngobrolin.ContentFixtures

  describe "Fetcher" do
    test "parse_response/1" do
      response = %{
        "items" => [
          %{
            "snippet" => %{
              "title" => "Video Title",
              "description" => "Video Description",
              "thumbnails" => %{"standard" => %{"url" => "http://example.com/thumbnail.jpg"}},
              "resourceId" => %{"videoId" => "12345"}
            },
            "contentDetails" => %{
              "videoPublishedAt" => "2021-01-01T00:00:00Z"
            }
          }
        ]
      }

      expected = [
        %{
          title: "Video Title",
          description: "Video Description",
          thumbnail: "http://example.com/thumbnail.jpg",
          video_id: "12345",
          published_at: ~N[2021-01-01 00:00:00]
        }
      ]

      assert Youtube.parse_response(response) == expected
    end

    test "fetch_videos/1" do
      playlist_id = "PL1234567890"

      mock_http_client = fn _url, _headers ->
        mock_response = %{
          "items" => [
            %{
              "snippet" => %{
                "title" => "Test Video",
                "description" => "Test Description",
                "thumbnails" => %{"standard" => %{"url" => "http://example.com/thumbnail.jpg"}},
                "resourceId" => %{"videoId" => "test123"}
              },
              "contentDetails" => %{
                "videoPublishedAt" => "2021-01-01T00:00:00Z"
              }
            }
          ]
        }

        {:ok, %{status: 200, body: Jason.encode!(mock_response)}}
      end

      result =
        Youtube.fetch_videos(playlist_id, http_client: mock_http_client, api_key: "fake_key")

      # Assert the result
      assert result == [
               %{
                 title: "Test Video",
                 description: "Test Description",
                 thumbnail: "http://example.com/thumbnail.jpg",
                 video_id: "test123",
                 published_at: ~N[2021-01-01 00:00:00]
               }
             ]
    end

    test "youtube_urls/0" do
      episode_fixture()
      youtube_urls = Youtube.youtube_urls()

      # Assert that the list is not empty
      assert length(youtube_urls) > 0

      # Assert that each URL is a valid YouTube URL
      Enum.each(youtube_urls, fn {_episode, url} ->
        assert String.starts_with?(url, "https://www.youtube.com/watch?v=")
      end)
    end
  end
end
