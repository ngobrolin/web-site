defmodule NgobrolinWeb.PageHTMLTest do
  use ExUnit.Case

  test "truncate text" do
    text = "This text is too long. Need to be truncated."
    assert NgobrolinWeb.PageHTML.truncate(text, 10) == "This text "
  end
end 