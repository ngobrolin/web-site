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

      assert html =~ "Listing Episodes"
      assert html =~ episode.title
    end

    test "navigates to episode page", %{conn: conn, episode: episode} do
      {:ok, index_live, _html} = live(conn, ~p"/episodes")

      {:ok, _show_live, html} =
        index_live
        |> element("a[href='/episodes/#{episode.id}']")
        |> render_click()
        |> follow_redirect(conn)

      assert html =~ episode.title
    end
  end

  describe "Show" do
    setup [:create_episode]

    test "displays episode", %{conn: conn, episode: episode} do
      {:ok, _show_live, html} = live(conn, ~p"/episodes/#{episode}")

      assert html =~ episode.title
      assert html =~ episode.description
    end
  end
end
