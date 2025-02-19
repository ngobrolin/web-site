defmodule NgobrolinWeb.HomeLiveTest do
  use NgobrolinWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "HomeLive" do
    test "displays homepage content", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      # Test page title using element
      assert has_element?(view, "h1", "NGOBROLIN\nWEB.")

      # Test description presence
      assert has_element?(
               view,
               "p.max-w-2xl",
               "Diskusi dan ngobrol ngalor-ngidul tentang dunia web"
             )

      # Test search components
      assert has_element?(view, "input[placeholder='Cari episode...']")
      assert has_element?(view, "button", "CARI")
    end

    test "search input is present and interactive", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      assert view
             |> element("input[type='text'][placeholder='Cari episode...']")
             |> has_element?()
    end

    test "episodes grid displays correctly", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      assert view
             |> element("div.grid")
             |> has_element?()

      assert view
             |> element("article")
             |> has_element?()
    end

    test "shows 'SEMUA EPISODE' button", %{conn: conn} do
      {:ok, _view, html} = live(conn, ~p"/")
      assert html =~ "SEMUA EPISODE"
    end
  end
end
