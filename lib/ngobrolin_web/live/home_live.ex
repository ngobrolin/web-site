defmodule NgobrolinWeb.HomeLive do
  use NgobrolinWeb, :live_view
  alias Ngobrolin.Content
  import NgobrolinWeb.ViewHelpers, only: [format_duration: 1, format_date: 1]

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Indeks",
       episodes: Content.list_episodes() |> Enum.sort_by(& &1.episode_number, :desc)
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="container px-4 py-8 mx-auto">
      <!-- Hero Section -->
      <section class="relative h-[50vh] mb-12 overflow-hidden">
        <div class="absolute inset-0 bg-zinc-800 border-4 border-white transform -rotate-1"></div>
        <div class="absolute inset-0 flex flex-col items-start justify-center px-12">
          <h1 class="mb-4 text-6xl font-black tracking-tighter transform rotate-1 shadow-[4px_4px_0px_0px_#ffffff]">
            NGOBROLIN<br />WEB.
          </h1>
          <p class="max-w-2xl text-xl font-bold bg-white text-zinc-900 px-4 py-2 transform -rotate-1">
            Diskusi dan ngobrol ngalor-ngidul tentang dunia web.
          </p>
        </div>
      </section>
      
    <!-- Search Bar 
      <div class="flex items-center gap-4 mb-12">
        <div class="relative flex-1">
          <input
            type="text"
            placeholder="Cari episode..."
            class="w-full pl-4 text-lg border-4 border-white bg-zinc-800 placeholder:text-zinc-500 py-3 transition-all focus:bg-white focus:text-zinc-900 focus:outline-none focus:border-white hover:bg-white hover:text-zinc-900 hover:placeholder:text-zinc-700"
          />
        </div>
        <button class="px-8 py-3 text-lg font-bold border-4 hover:bg-white hover:text-zinc-900 border-white bg-transparent transform transition-transform hover:scale-105">
          CARI
        </button>
      </div>
     -->
    <!-- Episodes Grid -->
      <h2 class="text-3xl font-black mb-8 inline-block transform -rotate-1 border-b-4 border-white pb-2">
        EPISODE TERBARU
      </h2>
      <div class="grid gap-8 md:grid-cols-2 lg:grid-cols-2">
        <%= for episode <- @episodes do %>
          <.link
            href={~p"/episodes/#{episode.id}"}
            class="block overflow-hidden transition-transform border-4 border-white hover:scale-[1.02]"
          >
            <article class="bg-zinc-800 h-full">
              <div class="relative aspect-video">
                <img
                  src={episode.thumbnail_url}
                  alt={episode.title}
                  class="object-cover w-full h-full"
                />
                <div class="absolute bottom-0 right-0 px-3 py-1 m-2 text-sm font-bold bg-white text-zinc-900">
                  {format_duration(episode.duration)}
                </div>
              </div>
              <div class="p-4">
                <p class="mb-2 text-sm font-bold text-zinc-300">
                  EP {episode.episode_number} • {format_date(episode.published_at)}
                </p>
                <h2 class="mb-2 text-xl font-bold">{episode.title}</h2>
                <p class="text-sm text-zinc-300">{episode.description}</p>
              </div>
            </article>
          </.link>
        <% end %>
      </div>

      <div class="flex justify-center mt-12">
        <.link
          href={~p"/episodes"}
          class="px-8 py-3 text-lg font-bold border-4 hover:bg-white hover:text-zinc-900 border-white transform transition-transform hover:scale-105"
        >
          SEMUA EPISODE
        </.link>
      </div>
    </div>
    """
  end
end
