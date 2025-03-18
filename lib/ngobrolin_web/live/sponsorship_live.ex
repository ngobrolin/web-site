defmodule NgobrolinWeb.SponsorshipLive do
  use NgobrolinWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Sponsor Ngobrolin")}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto">
      <h1 class="text-4xl font-black uppercase tracking-tighter mb-8 transform -rotate-1 bg-white text-zinc-800 inline-block px-6 py-3 border-4 border-white">
        Sponsor Ngobrolin
      </h1>

      <section class="mb-12">
        <div class="border-4 border-white p-6 transform rotate-0.5 bg-zinc-900 mb-10">
          <h2 class="text-3xl font-extrabold uppercase mb-6 transform -rotate-0.5">
            Mengapa Sponsor Kami?
          </h2>
          <p class="text-xl mb-4">
            Hubungkan dengan audiens kami yang terdiri dari profesional teknologi, penggemar, dan pengambil keputusan.
          </p>
          <p class="text-xl">
            Pemirsa kami aktif mencari pengetahuan dan solusi di bidang teknologi, menjadikan mereka audiens ideal
            untuk produk dan layanan yang relevan.
          </p>
        </div>
      </section>

      <section class="mb-12">
        <div class="border-4 border-white p-6 transform -rotate-0.5 bg-zinc-900">
          <h2 class="text-3xl font-extrabold uppercase mb-6 transform rotate-0.5">
            Paket Sponsorship
          </h2>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="p-5 border-4 border-white bg-white text-zinc-800 transform rotate-0.5 hover:scale-105 transition-transform">
              <h3 class="text-2xl font-black mb-3 uppercase">Basic</h3>
              <p class="text-2xl font-bold mb-3">Rp7.500.000</p>
              <p>per episode</p>
            </div>

            <div class="p-5 border-4 border-white bg-white text-zinc-800 transform -rotate-0.5 hover:scale-105 transition-transform">
              <h3 class="text-2xl font-black mb-3 uppercase">Premium</h3>
              <p class="text-2xl font-bold mb-3">Rp15.000.000</p>
              <p>per episode</p>
            </div>

            <div class="p-5 border-4 border-white bg-white text-zinc-800 transform rotate-0.5 hover:scale-105 transition-transform">
              <h3 class="text-2xl font-black mb-3 uppercase">Enterprise</h3>
              <p class="text-xl font-bold mb-3">Custom Price</p>
              <p>Hubungi kami</p>
            </div>
          </div>
        </div>
      </section>

      <section class="mb-12">
        <div class="border-4 border-white p-6 transform rotate-0.5 bg-zinc-900">
          <h2 class="text-3xl font-extrabold uppercase mb-6 transform -rotate-1">Media Kit</h2>
          <p class="text-xl mb-6">
            Unduh media kit kami untuk informasi lebih lanjut tentang audiens, statistik, dan peluang sponsor.
          </p>
          <a
            href="/downloads/ngobrolin_media_kit.pdf"
            class="inline-block px-8 py-4 bg-white text-zinc-800 text-xl font-black uppercase border-4 border-white hover:bg-zinc-800 hover:text-white transform hover:scale-105 hover:-rotate-1 transition-all"
          >
            Unduh Media Kit
          </a>
        </div>
      </section>

      <section class="mb-12">
        <div class="border-4 border-white p-6 transform -rotate-0.5 bg-zinc-900">
          <h2 class="text-3xl font-extrabold uppercase mb-6 transform rotate-0.5">Hubungi Kami</h2>
          <form class="space-y-6">
            <div>
              <label class="block text-xl font-bold mb-2 uppercase" for="name">Nama</label>
              <input
                type="text"
                id="name"
                class="w-full border-4 border-white bg-zinc-800 p-3 text-white"
              />
            </div>
            <div>
              <label class="block text-xl font-bold mb-2 uppercase" for="email">Email</label>
              <input
                type="email"
                id="email"
                class="w-full border-4 border-white bg-zinc-800 p-3 text-white"
              />
            </div>
            <div>
              <label class="block text-xl font-bold mb-2 uppercase" for="message">Pesan</label>
              <textarea
                id="message"
                rows="4"
                class="w-full border-4 border-white bg-zinc-800 p-3 text-white"
              ></textarea>
            </div>
            <button
              type="submit"
              class="px-8 py-4 bg-white text-zinc-800 text-xl font-black uppercase border-4 border-white hover:bg-zinc-800 hover:text-white transform hover:scale-105 transition-all"
            >
              Kirim Pesan
            </button>
          </form>
        </div>
      </section>
    </div>

    <style>
      .text-shadow-neo {
        text-shadow: 4px 4px 0 white;
        color: #1a203b;
      }
    </style>
    """
  end
end
