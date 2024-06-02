defmodule NgobrolinWeb.PageControllerTest do
  use NgobrolinWeb.ConnCase

  import Ngobrolin.ContentFixtures

  test "GET /", %{conn: conn} do
    episodes = episode_fixture()
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Ngobrolin WEB"

    assert html_response(conn, 200) =~ episodes.title
    assert html_response(conn, 200) =~ episodes.description
  end 
end
