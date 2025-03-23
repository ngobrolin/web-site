defmodule NgobrolinWeb.EpisodeLive.Index do
  use NgobrolinWeb, :live_view

  alias Ngobrolin.Content
  import NgobrolinWeb.ViewHelpers, only: [truncate: 1, format_date: 1]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:search_term, "")
     |> stream(:episodes, Content.list_episodes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Episodes")
    |> assign(:episode, nil)
  end

  @impl true
  def handle_event("search", %{"search_term" => search_term}, socket) do
    filtered_episodes = filter_episodes(search_term)

    {:noreply,
     socket
     |> assign(:search_term, search_term)
     |> stream(:episodes, filtered_episodes, reset: true)}
  end

  @impl true
  def handle_event("search-input", %{"search_term" => search_term}, socket) do
    {:noreply, assign(socket, :search_term, search_term)}
  end

  defp filter_episodes(search_term) do
    search_term = search_term |> String.trim() |> String.downcase()

    if search_term == "" do
      Content.list_episodes()
    else
      Content.list_episodes()
      |> Enum.filter(fn episode ->
        title = String.downcase(episode.title || "")
        description = String.downcase(episode.description || "")

        String.contains?(title, search_term) ||
          String.contains?(description, search_term)
      end)
    end
  end
end
