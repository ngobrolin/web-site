defmodule NgobrolinWeb.EpisodeLive.Show do
  use NgobrolinWeb, :live_view

  alias Ngobrolin.Content

  import NgobrolinWeb.ViewHelpers,
    only: [format_duration: 1, format_date_with_timezone: 1]

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      {:ok, attach_hook(socket, :track_view, :handle_params, &track_episode_view/3)}
    else
      {:ok, socket}
    end
  end

  @impl true
  def handle_params(%{"episode_number" => episode_number}, _, socket) do
    episode = Content.get_episode_by_episode_number!(episode_number)

    {:noreply,
     socket
     |> assign(:page_title, "Episode #{episode.episode_number} - #{episode.title}")
     |> assign(:episode, episode)}
  end

  defp track_episode_view(params, _url, socket) do
    if Map.has_key?(params, "episode_number") and connected?(socket) do
      # TODO
      # Content.increment_view_count(params["episode_number"]) # Or fetch episode and use ID/struct
    end

    {:cont, socket}
  end
end
