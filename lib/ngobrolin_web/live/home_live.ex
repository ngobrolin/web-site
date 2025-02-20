defmodule NgobrolinWeb.HomeLive do
  use NgobrolinWeb, :live_view
  alias Ngobrolin.Content

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
      <section class="mb-12">
        <h1 class="mb-4 text-6xl font-black tracking-tighter">
          NGOBROLIN<br />WEB.
        </h1>
        <p class="max-w-2xl text-xl text-[#a76ab7]">
          Diskusi dan ngobrol ngalor-ngidul tentang dunia web. Agar pengetahuan kita tetap terbarukan dengan teknologi web terkini.
        </p>
      </section>

      <div class="flex items-center gap-4 mb-8">
        <div class="relative flex-1">
          <svg
            class="absolute w-5 h-5 transform -translate-y-1/2 left-3 top-1/2 text-[#6587ff]"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
          >
            <circle cx="11" cy="11" r="8" />
            <path d="m21 21-4.3-4.3" />
          </svg>
          <input
            type="text"
            placeholder="Cari episode..."
            class="w-full pl-10 text-lg border-4 border-[#6587ff] bg-[#1a203b] placeholder:text-gray-500 rounded-md"
          />
        </div>
        <button class="px-8 py-6 text-lg font-bold border-4 hover:bg-[#6587ff] border-[#6587ff] bg-transparent rounded-md">
          CARI
        </button>
      </div>

      <div class="grid gap-8 md:grid-cols-2 lg:grid-cols-2">
        <%= for episode <- @episodes do %>
          <.link
            href={~p"/episodes/#{episode.id}"}
            class="block overflow-hidden transition-transform border-4 border-[#6587ff] hover:scale-[1.02]"
          >
            <article>
              <div class="relative aspect-video bg-[#a76ab7]">
                <img
                  src={episode.thumbnail_url}
                  alt={episode.title}
                  class="object-cover w-full h-full"
                />
                <div class="absolute bottom-0 right-0 px-3 py-1 m-2 text-sm font-bold bg-[#6587ff]">
                  {format_duration(episode.duration)}
                </div>
              </div>
              <div class="p-4">
                <p className="mb-2 text-sm font-bold text-[#a76ab7]">
                  EP {episode.episode_number} • {format_date(episode.published_at)}
                </p>
                <h2 class="mb-2 text-xl font-bold">{episode.title}</h2>
                <p class="text-sm text-gray-300">{episode.description}</p>
              </div>
            </article>
          </.link>
        <% end %>
      </div>

      <div class="flex justify-center mt-8">
        <.link
          href={~p"/episodes"}
          class="px-8 py-6 text-lg font-bold border-4 hover:bg-[#6587ff] border-[#6587ff] bg-transparent rounded-md"
        >
          SEMUA EPISODE
        </.link>
      </div>
    </div>
    """
  end

  defp format_duration(seconds) do
    minutes = div(seconds, 60)
    "#{minutes} menit"
  end

  defp format_date(naive_datetime) do
    Calendar.strftime(naive_datetime, "%d %b %Y")
  end
end
