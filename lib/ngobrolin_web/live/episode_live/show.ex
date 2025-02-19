defmodule NgobrolinWeb.EpisodeLive.Show do
  use NgobrolinWeb, :live_view

  alias Ngobrolin.Content

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Show Episode")
     |> assign(:episode, Content.get_episode!(id))}
  end
end
