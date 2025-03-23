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
            <h2 class="text-3xl font-black text-white uppercase tracking-tighter mb-6">
              VISI & MISI
            </h2>
            <p class="text-white leading-relaxed">
              Menjadi platform diskusi terdepan yang menghubungkan para pengembang web di Indonesia untuk tetap mengikuti perkembangan teknologi web yang pesat, dengan berbagi pengetahuan, pengalaman, dan wawasan dalam suasana yang santai namun informatif.
            </p>
            <p class="text-white leading-relaxed mt-4">
              Tujuan Ngobrolin WEB
              <ol class="list-decimal">
                <li>
                  Menyediakan ruang diskusi yang santai namun fokus tentang berbagai topik seputar teknologi web.
                </li>
                <li>
                  Mengulas perkembangan terkini di dunia web tanpa terbatas pada framework atau browser tertentu.
                </li>
                <li>
                  Berbagi insight dan pengalaman dari praktisi web berpengalaman termasuk Google Developer Expert dan profesional di bidang web.
                </li>
                <li>
                  Menjembatani kesenjangan pengetahuan bagi mereka yang merasa tertinggal dengan teknologi web yang berkembang pesat.
                </li>
                <li>
                  Melibatkan komunitas dengan mengundang masukan, berita, dan koreksi dari penonton melalui kolom komentar.
                </li>
                <li>
                  Memperluas wawasan tentang teknologi web melalui diskusi teknis, komparasi, dan topik-topik terkait web lainnya.
                </li>
              </ol>
            </p>
            <p class="text-white leading-relaxed mt-4">
              Ngobrolin WEB adalah inisiatif untuk menciptakan wadah diskusi santai namun bermanfaat bagi para pengembang dan penggemar teknologi web di Indonesia, dengan tujuan utama membantu semua pihak untuk tetap mengikuti perkembangan teknologi web yang dinamis.
            </p>
          </div>
        </section>

        <section class="mb-16">
          <h2 class="text-3xl font-black text-white uppercase tracking-tighter mb-8 text-center transform -rotate-1">
            PANELIS TETAP
          </h2>
          <div class="grid md:grid-cols-3 gap-8">
            <div class="bg-zinc-800 border-4 border-white shadow-lg rounded-none p-6 text-center transform -rotate-1 hover:bg-zinc-600 hover:text-zinc-900 transition-all duration-300 hover:scale-105">
              <img
                src="/images/eka.jpg"
                alt="Eka"
                class="w-32 h-32 rounded-none border-4 border-white mx-auto mb-4 object-cover"
              />
              <h3 class="text-2xl font-black text-white uppercase mb-2 group-hover:text-zinc-900">
                Eka
              </h3>

              <p class="text-white leading-relaxed">
                Eka adalah pengembang web yang beralih karir dari bidang bahasa dan administrasi dengan latar belakang Sastra. Dia tertarik pada web karena aksesibilitasnya yang tinggi dan ekosistemnya yang dinamis. Menulis dan berbicara di depan umum adalah caranya memperkuat pembelajaran dan terhubung dengan sesama pengembang. Di luar coding, Eka menyukai musik, sastra, dan seni, pernah aktif di skena musik lokal, dan terlibat dalam proyek seni media yang meraih penghargaan. Saat ini bekerja di NGO Atma Connect dan merupakan Google Developer Expert bidang teknologi web.
              </p>
            </div>
            <div class="bg-zinc-800 border-4 border-white shadow-lg rounded-none p-6 text-center transform rotate-1 hover:bg-zinc-600 hover:text-zinc-900 transition-all duration-300 hover:scale-105">
              <img
                src="/images/ivan.jpg"
                alt="Ivan"
                class="w-32 h-32 rounded-none border-4 border-white mx-auto mb-4 object-cover"
              />
              <h3 class="text-2xl font-black text-white uppercase mb-2 group-hover:text-zinc-900">
                Ivan
              </h3>

              <p class="text-white leading-relaxed">
                Ivan adalah Senior Web Engineer di Human Made, agensi teknologi global yang melayani klien enterprise dari berbagai industri. Fokus utamanya adalah platform penerbitan konten. Aktif di komunitas Web dan Teknologi Indonesia baik sebagai pembicara maupun penyelenggara acara. Sebagian besar karirnya dihabiskan bekerja di agensi digital. Ivan gemar mengeksplorasi teknologi web baru dan fokus pada peningkatan performa situs. Dia telah menjadi kontributor utama untuk beberapa plugin WordPress. Dengan pengalamannya dari industri dan akademis, Ivan memiliki minat yang kuat dalam membantu klien bisnis internasional, terutama di industri platform penerbitan konten.
              </p>
            </div>
            <div class="bg-zinc-800 border-4 border-white shadow-lg rounded-none p-6 text-center transform -rotate-2 hover:bg-zinc-600 hover:text-zinc-900 transition-all duration-300 hover:scale-105">
              <img
                src="/images/riza.jpg"
                alt="Maya Putri"
                class="w-32 h-32 rounded-none border-4 border-white mx-auto mb-4 object-cover"
              />
              <h3 class="text-2xl font-black text-white uppercase mb-2 group-hover:text-zinc-900">
                RIZA
              </h3>
              <p class="text-white leading-relaxed">
                Riza senang mempelajari teknologi terbaru dan berbagi dengan sesama developer yang membutuhkan bimbingan untuk meningkatkan keterampilan mereka. Merintis Hacktiv8 untuk mengatasi kelangkaan developer berkualitas yang menghambat pertumbuhan startup teknologi di Indonesia.
                Senang berbagi pengetahuan dan tergabung dalam berbagai komunitas dan juga menjadi pembicara di berbagai acara komunitas.
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
              href="https://x.com/search?q=%23ngobrolinweb"
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
              href="https://www.youtube.com/playlist?list=PLTY2nW4jwtG8Sx2Bw6QShC271PzX31CtT"
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
              href="https://github.com/orgs/ngobrolin/discussions"
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
