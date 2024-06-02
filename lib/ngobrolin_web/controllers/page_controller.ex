defmodule NgobrolinWeb.PageController do
  use NgobrolinWeb, :controller

  alias Ngobrolin.Content

  def home(conn, _params) do
    episodes = Content.list_episodes()
    render(conn, :home, episodes: episodes)
  end
end
