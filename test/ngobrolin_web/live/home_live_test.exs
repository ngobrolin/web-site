defmodule NgobrolinWeb.HomeLiveTest do
  use NgobrolinWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ngobrolin.ContentFixtures

  describe "HomeLive" do
    test "displays page title", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")
      assert html =~ "NGOBROLIN"
      assert html =~ "WEB"
    end

    test "episodes grid displays correctly", %{conn: conn} do
      episode =
        episode_fixture(%{
          title: "Test Episode",
          description: "Test Description",
          thumbnail_url: "https://example.com/thumb.jpg",
          duration: 1800,
          published_at: ~N[2024-02-19 03:16:00],
          status: "published",
          youtube_id: "test123",
          episode_number: 1
        })

      {:ok, view, _html} = live(conn, ~p"/")

      assert view |> has_element?("article")
      assert view |> has_element?("img[src='#{episode.thumbnail_url}']")
      assert view |> has_element?("h2", episode.title)
      assert view |> has_element?("p", ~r/EP #{episode.episode_number}/)
      assert view |> has_element?("div", "30 menit")
    end

    test "search input is present", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")
      assert view |> has_element?("input[placeholder='Cari episode...']")
      assert view |> has_element?("button", "CARI")
    end
  end
end
