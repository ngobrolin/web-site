defmodule NgobrolinWeb.ErrorHTMLTest do
  use NgobrolinWeb.ConnCase, async: true

  # Bring render_to_string/4 for testing custom views
  import Phoenix.Template

  test "renders 404.html" do
    html = render_to_string(NgobrolinWeb.ErrorHTML, "404", "html", [])
    assert html =~ "HALAMAN TIDAK DITEMUKAN"
    assert html =~ "404"
  end

  test "renders 500.html" do
    html = render_to_string(NgobrolinWeb.ErrorHTML, "500", "html", [])
    assert html =~ "SERVER ERROR"
  end
end
