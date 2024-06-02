defmodule NgobrolinWeb.EpisodeControllerTest do
  use NgobrolinWeb.ConnCase

  import Ngobrolin.ContentFixtures

  @create_attrs %{
    artwork: "some artwork",
    description: "some description",
    title: "some title",
    youtubeid: "some youtubeid"
  }
  @update_attrs %{
    artwork: "some updated artwork",
    description: "some updated description",
    title: "some updated title",
    youtubeid: "some updated youtubeid"
  }
  @invalid_attrs %{artwork: nil, description: nil, title: nil, youtubeid: nil}

  describe "index" do
    test "lists all episodes", %{conn: conn} do
      conn = get(conn, ~p"/episodes")
      assert html_response(conn, 200) =~ "Listing Episodes"
    end
  end

  describe "new episode" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/episodes/new")
      assert html_response(conn, 200) =~ "New Episode"
    end
  end

  describe "create episode" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/episodes", episode: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/episodes/#{id}"

      conn = get(conn, ~p"/episodes/#{id}")
      assert html_response(conn, 200) =~ "Episode #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/episodes", episode: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Episode"
    end
  end

  describe "edit episode" do
    setup [:create_episode]

    test "renders form for editing chosen episode", %{conn: conn, episode: episode} do
      conn = get(conn, ~p"/episodes/#{episode}/edit")
      assert html_response(conn, 200) =~ "Edit Episode"
    end
  end

  describe "update episode" do
    setup [:create_episode]

    test "redirects when data is valid", %{conn: conn, episode: episode} do
      conn = put(conn, ~p"/episodes/#{episode}", episode: @update_attrs)
      assert redirected_to(conn) == ~p"/episodes/#{episode}"

      conn = get(conn, ~p"/episodes/#{episode}")
      assert html_response(conn, 200) =~ "some updated artwork"
    end

    test "renders errors when data is invalid", %{conn: conn, episode: episode} do
      conn = put(conn, ~p"/episodes/#{episode}", episode: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Episode"
    end
  end

  describe "delete episode" do
    setup [:create_episode]

    test "deletes chosen episode", %{conn: conn, episode: episode} do
      conn = delete(conn, ~p"/episodes/#{episode}")
      assert redirected_to(conn) == ~p"/episodes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/episodes/#{episode}")
      end
    end
  end

  defp create_episode(_) do
    episode = episode_fixture()
    %{episode: episode}
  end
end
