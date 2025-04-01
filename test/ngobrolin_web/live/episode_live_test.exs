defmodule NgobrolinWeb.EpisodeLiveTest do
  use NgobrolinWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ngobrolin.ContentFixtures

  defp create_episode(_) do
    episode = episode_fixture()
    %{episode: episode}
  end

  describe "Index" do
    setup [:create_episode]

    test "lists all episodes", %{conn: conn, episode: episode} do
      {:ok, _index_live, html} = live(conn, ~p"/episodes")

      assert html =~ "SEMUA EPISODE" # Updated title
      assert html =~ episode.title
    end

    test "navigates to episode page", %{conn: conn, episode: episode} do
      {:ok, index_live, _html} = live(conn, ~p"/episodes")

      {:ok, _index_live_after_click, html_after_click} =
        index_live
        |> element(~s|a[href="/episodes/#{episode.episode_number}"]|) # Use episode_number in selector
        |> render_click()

      assert html_after_click =~ episode.title # Assert on the HTML rendered after the navigation click
    end
  end

  describe "Show" do
    setup [:create_episode]

    test "displays episode", %{conn: conn, episode: episode} do
      {:ok, _show_live, html} = live(conn, ~p"/episodes/#{episode.episode_number}") # Use episode_number

      assert html =~ episode.title
      assert html =~ episode.description # Ensure description is checked
    end
  end
end
