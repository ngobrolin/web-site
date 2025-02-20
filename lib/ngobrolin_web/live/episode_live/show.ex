defmodule NgobrolinWeb.EpisodeLive.Show do
  use NgobrolinWeb, :live_view

  alias Ngobrolin.Content

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      {:ok, attach_hook(socket, :track_view, :handle_params, &track_episode_view/3)}
    else
      {:ok, socket}
    end
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    episode = Content.get_episode!(id)

    {:noreply,
     socket
     |> assign(:page_title, "Episode #{episode.episode_number} - #{episode.title}")
     |> assign(:episode, episode)}
  end

  defp track_episode_view(params, _url, socket) do
    if Map.has_key?(params, "id") and connected?(socket) do
      # TODO
      # Content.increment_view_count(params["id"])
    end

    {:cont, socket}
  end
end
