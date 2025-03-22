defmodule Ngobrolin.YouTube.FetcherTest do
  use ExUnit.Case, async: true

  alias Ngobrolin.YouTube.Fetcher
  alias Ngobrolin.Youtube.Fetcher

  describe "Fetcher" do
    test "parse_response/1" do
      response = %{
        "items" => [
          %{
            "snippet" => %{
              "title" => "Video Title",
              "description" => "Video Description",
              "thumbnails" => %{"default" => %{"url" => "http://example.com/thumbnail.jpg"}},
              "resourceId" => %{"videoId" => "12345"}
            }
          }
        ]
      }

      expected = [
        %{
          title: "Video Title",
          description: "Video Description",
          thumbnail: "http://example.com/thumbnail.jpg",
          video_id: "12345"
        }
      ]

      assert Fetcher.parse_response(response) == expected
    end

    test "get_videos/1" do
      playlist_id = "PL1234567890"

      mock_http_client = fn _url, _headers ->
        mock_response = %{
          "items" => [
            %{
              "snippet" => %{
                "title" => "Test Video",
                "description" => "Test Description",
                "thumbnails" => %{"default" => %{"url" => "http://example.com/thumbnail.jpg"}},
                "resourceId" => %{"videoId" => "test123"}
              }
            }
          ]
        }

        {:ok, %{status: 200, body: Jason.encode!(mock_response)}}
      end

      result =
        Fetcher.fetch_videos(playlist_id, http_client: mock_http_client, api_key: "fake_key")

      # Assert the result
      assert result == [
               %{
                 title: "Test Video",
                 description: "Test Description",
                 thumbnail: "http://example.com/thumbnail.jpg",
                 video_id: "test123"
               }
             ]
    end
  end
end
