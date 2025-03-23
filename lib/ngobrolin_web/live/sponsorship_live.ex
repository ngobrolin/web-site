defmodule NgobrolinWeb.SponsorshipLive do
  use NgobrolinWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Sponsor Ngobrolin")}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto">
      <h1 class="text-4xl font-black uppercase tracking-tighter mb-8 transform -rotate-1 bg-white text-zinc-800 inline-block px-6 py-3 border-4 border-white">
        Dukungan Untuk Ngobrolin WEB
      </h1>

      <section class="mb-12">
        <div class="border-4 border-white p-6 transform rotate-0.5 bg-zinc-900 mb-10">
          <h2 class="text-3xl font-extrabold uppercase mb-6 transform -rotate-0.5">
            Kecil nan Akrab
          </h2>
          <p class="text-xl mb-4">
            Komunitas Ngobrolin WEB, meski tergolong kecil namun sangat akrab. Mendengarkan podcast sembari berkendara sepulang kerja atau saat bersantai dirumah adalah cara penonton dalam menikmati acara ini.
          </p>
          <p class="text-xl">
            Kami ingin menyebarkan lebih banyak informasi dan produk yang berhubungan erat dengan dunai web yang dikembangkan oleh para pengembang lokal. Dengan dukungan kamu, kami bisa menjangkau lebih banyak pendengar dan memberikan informasi yang lebih bermanfaat.
          </p>
        </div>
      </section>
      <section>
        <h2 class="text-3xl font-black text-white uppercase tracking-tighter mb-8 text-center transform -rotate-1">
          DUKUNG KAMI
        </h2>
        <div class="flex flex-wrap justify-center gap-6">
          <a
            href="https://saweria.co/rizafahmi"
            class="flex items-center gap-2 px-6 py-3 bg-zinc-800 text-white font-bold uppercase border-4 border-white rounded-none hover:bg-white hover:text-zinc-900 transform transition-transform hover:scale-105"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="size-6"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M20.25 6.375c0 2.278-3.694 4.125-8.25 4.125S3.75 8.653 3.75 6.375m16.5 0c0-2.278-3.694-4.125-8.25-4.125S3.75 4.097 3.75 6.375m16.5 0v11.25c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125V6.375m16.5 0v3.75m-16.5-3.75v3.75m16.5 0v3.75C20.25 16.153 16.556 18 12 18s-8.25-1.847-8.25-4.125v-3.75m16.5 0c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125"
              />
            </svg>
            Donasi
          </a>
          <a
            href="mailto:rizafahmi@gmail.com"
            class="flex items-center gap-2 px-6 py-3 bg-zinc-800 text-white font-bold uppercase border-4 border-white rounded-none hover:bg-white hover:text-zinc-900 transform transition-transform hover:scale-105"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="size-6"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75"
              />
            </svg>
            Bentuk Dukungan Lain
          </a>
        </div>
      </section>
      
    <!--
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
      -->
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
