defmodule NgobrolinWeb.PageHTML do
  use NgobrolinWeb, :html

  embed_templates "page_html/*"

  def truncate(text, maxlength) do
    text |> String.split_at(maxlength) |> elem(0)
  end
end
