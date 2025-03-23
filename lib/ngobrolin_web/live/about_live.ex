defmodule NgobrolinWeb.AboutLive do
  use NgobrolinWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Tentang Ngobrolin")}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-zinc-900 min-h-screen">
      <div class="container mx-auto px-4 py-12">
        <h1 class="text-4xl font-black text-center text-white uppercase tracking-tighter mb-12 transform -rotate-1">
          TENTANG NGOBROLIN WEB
        </h1>

        <section class="mb-16">
          <div class="bg-zinc-800 border-4 border-white shadow-lg rounded-none p-8 transform rotate-1">
            <h2 class="text-3xl font-black text-white uppercase tracking-tighter mb-6">MISI KAMI</h2>
            <p class="text-white leading-relaxed">
              Ngobrolin adalah platform video podcast yang bertujuan untuk menyampaikan konten teknologi
              yang menarik, mendidik, dan menghubungkan komunitas kami. Kami membahas topik kompleks
              dengan cara yang mudah dipahami tanpa mengurangi kedalaman teknisnya.
            </p>
            <p class="text-white leading-relaxed mt-4">
              Tujuan kami adalah menciptakan ruang di mana penggemar teknologi, profesional, dan pelajar
              dapat menemukan wawasan berharga dan tetap terupdate dengan tren dan praktik terbaik.
            </p>
          </div>
        </section>

        <section class="mb-16">
          <h2 class="text-3xl font-black text-white uppercase tracking-tighter mb-8 text-center transform -rotate-1">
            TIM KAMI
          </h2>
          <div class="grid md:grid-cols-3 gap-8">
            <div class="bg-zinc-800 border-4 border-white shadow-lg rounded-none p-6 text-center transform -rotate-1 hover:bg-white hover:text-zinc-900 transition-all duration-300 hover:scale-105">
              <img
                src="/images/host-photo-1.jpg"
                alt="Jane Doe"
                class="w-32 h-32 rounded-none border-4 border-white mx-auto mb-4 object-cover"
              />
              <h3 class="text-2xl font-black text-white uppercase mb-2 group-hover:text-zinc-900">
                JANE DOE
              </h3>
              <p class="text-zinc-300 mb-4 uppercase font-bold">HOST & PEMIMPIN TEKNIS</p>
              <p class="text-white leading-relaxed">
                Jane memiliki pengalaman lebih dari 10 tahun di pengembangan perangkat lunak. Dia
                mengkhususkan diri dalam sistem terdistribusi dan telah bekerja di beberapa perusahaan
                teknologi besar. Jane mendirikan Ngobrolin pada tahun 2021 untuk berbagi pengetahuan
                dan wawasan praktis.
              </p>
            </div>
            <div class="bg-zinc-800 border-4 border-white shadow-lg rounded-none p-6 text-center transform rotate-1 hover:bg-white hover:text-zinc-900 transition-all duration-300 hover:scale-105">
              <img
                src="/images/host-photo-2.jpg"
                alt="John Smith"
                class="w-32 h-32 rounded-none border-4 border-white mx-auto mb-4 object-cover"
              />
              <h3 class="text-2xl font-black text-white uppercase mb-2 group-hover:text-zinc-900">
                JOHN SMITH
              </h3>
              <p class="text-zinc-300 mb-4 uppercase font-bold">CO-HOST & PRODUSER KONTEN</p>
              <p class="text-white leading-relaxed">
                John membawa perspektif unik dari latar belakangnya di desain UX dan manajemen produk.
                Dengan pengalaman di startup dan perusahaan besar, ia fokus pada aspek manusia dari
                teknologi dan membuat topik kompleks lebih mudah diakses.
              </p>
            </div>
            <div class="bg-zinc-800 border-4 border-white shadow-lg rounded-none p-6 text-center transform -rotate-2 hover:bg-white hover:text-zinc-900 transition-all duration-300 hover:scale-105">
              <img
                src="/images/host-photo-3.jpg"
                alt="Maya Putri"
                class="w-32 h-32 rounded-none border-4 border-white mx-auto mb-4 object-cover"
              />
              <h3 class="text-2xl font-black text-white uppercase mb-2 group-hover:text-zinc-900">
                MAYA PUTRI
              </h3>
              <p class="text-zinc-300 mb-4 uppercase font-bold">EDITOR & SOCIAL MEDIA</p>
              <p class="text-white leading-relaxed">
                Maya adalah ahli media sosial dan editor video dengan bakat khusus dalam storytelling visual.
                Dengan pengalaman di bidang jurnalisme digital, Maya memastikan setiap episode Ngobrolin
                tampil dengan kualitas terbaik dan menjangkau audiens yang tepat melalui strategi
                media sosial yang efektif.
              </p>
            </div>
          </div>
        </section>

        <section>
          <h2 class="text-3xl font-black text-white uppercase tracking-tighter mb-8 text-center transform -rotate-1">
            HUBUNGI KAMI
          </h2>
          <div class="flex flex-wrap justify-center gap-6">
            <a
              href="https://twitter.com/ngobrolin"
              class="flex items-center gap-2 px-6 py-3 bg-zinc-800 text-white font-bold uppercase border-4 border-white rounded-none hover:bg-white hover:text-zinc-900 transform transition-transform hover:scale-105"
            >
              <svg
                class="w-6 h-6"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z" />
              </svg>
              Twitter
            </a>
            <a
              href="https://youtube.com/ngobrolin"
              class="flex items-center gap-2 px-6 py-3 bg-zinc-800 text-white font-bold uppercase border-4 border-white rounded-none hover:bg-white hover:text-zinc-900 transform transition-transform hover:scale-105"
            >
              <svg
                class="w-6 h-6"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M22.54 6.42a2.78 2.78 0 0 0-1.94-2C18.88 4 12 4 12 4s-6.88 0-8.6.46a2.78 2.78 0 0 0-1.94 2A29 29 0 0 0 1 11.75a29 29 0 0 0 .46 5.33A2.78 2.78 0 0 0 3.4 19c1.72.46 8.6.46 8.6.46s6.88 0 8.6-.46a2.78 2.78 0 0 0 1.94-2 29 29 0 0 0 .46-5.25 29 29 0 0 0-.46-5.33z" />
                <polygon points="9.75 15.02 15.5 11.75 9.75 8.48 9.75 15.02" />
              </svg>
              YouTube
            </a>
            <a
              href="mailto:rizafahmi@gmail.com"
              class="flex items-center gap-2 px-6 py-3 bg-zinc-800 text-white font-bold uppercase border-4 border-white rounded-none hover:bg-white hover:text-zinc-900 transform transition-transform hover:scale-105"
            >
              <svg
                class="w-6 h-6"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" />
                <polyline points="22,6 12,13 2,6" />
              </svg>
              Email
            </a>
            <a
              href="https://github.com/ngobrolin"
              class="flex items-center gap-2 px-6 py-3 bg-zinc-800 text-white font-bold uppercase border-4 border-white rounded-none hover:bg-white hover:text-zinc-900 transform transition-transform hover:scale-105"
            >
              <svg
                class="w-6 h-6"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22" />
              </svg>
              GitHub
            </a>
          </div>
        </section>
      </div>
    </div>
    """
  end
end
