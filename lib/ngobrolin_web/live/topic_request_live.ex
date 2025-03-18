defmodule NgobrolinWeb.TopicRequestLive do
  use NgobrolinWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="container mx-auto p-4">
      <h1 class="text-4xl font-black uppercase tracking-tighter mb-8 transform -rotate-1 bg-white text-zinc-800 inline-block px-6 py-3 border-4 border-white">
        Ajukan Topik
      </h1>

      <div class="max-w-3xl mx-auto bg-zinc-800 border-4 border-white p-8 transform rotate-1 mb-12">
        <p class="text-white text-lg mb-6">
          Punya topik yang ingin dibahas di podcast? Isi formulir di bawah ini,
          dan kami akan mempertimbangkan saran Anda untuk episode mendatang.
        </p>
      </div>

      <div class="max-w-3xl mx-auto bg-zinc-800 border-4 border-white p-8 transform -rotate-[0.5deg]">
        <form phx-submit="submit-request" class="space-y-6">
          <div class="form-group">
            <label for="topic" class="block text-white text-xl font-bold mb-2 uppercase">
              Saran Topik
            </label>
            <input
              type="text"
              id="topic"
              name="topic"
              placeholder="Topik apa yang ingin Anda diskusikan?"
              class="w-full p-3 bg-white border-4 border-white text-zinc-800 font-bold placeholder-zinc-500 transform hover:scale-[1.02] transition-transform"
              required
            />
          </div>

          <div class="form-group">
            <label for="reason" class="block text-white text-xl font-bold mb-2 uppercase">
              Alasan/Konteks
            </label>
            <textarea
              id="reason"
              name="reason"
              rows="4"
              placeholder="Mengapa topik ini menarik atau penting?"
              class="w-full p-3 bg-white border-4 border-white text-zinc-800 font-bold placeholder-zinc-500 transform hover:scale-[1.02] transition-transform"
              required
            ></textarea>
          </div>

          <div class="form-group">
            <label for="format" class="block text-white text-xl font-bold mb-2 uppercase">
              Format Pilihan
            </label>
            <select
              id="format"
              name="format"
              class="w-full p-3 bg-white border-4 border-white text-zinc-800 font-bold transform hover:scale-[1.02] transition-transform"
              required
            >
              <option value="">Pilih format</option>
              <option value="interview">Wawancara dengan ahli</option>
              <option value="discussion">Diskusi panel</option>
              <option value="tutorial">Tutorial/Cara-cara</option>
              <option value="debate">Debat</option>
              <option value="other">Lainnya</option>
            </select>
          </div>

          <div class="form-group">
            <label for="contact" class="block text-white text-xl font-bold mb-2 uppercase">
              Informasi Kontak (opsional)
            </label>
            <input
              type="email"
              id="contact"
              name="contact"
              placeholder="Alamat email Anda"
              class="w-full p-3 bg-white border-4 border-white text-zinc-800 font-bold placeholder-zinc-500 transform hover:scale-[1.02] transition-transform"
            />
            <p class="text-white text-sm mt-2">
              Kami akan memberi tahu Anda jika kami memilih topik Anda!
            </p>
          </div>

          <div class="form-group">
            <button
              type="submit"
              class="px-8 py-4 bg-white text-zinc-800 border-4 border-white font-black uppercase tracking-tight text-xl transform rotate-[0.5deg] hover:scale-105 hover:bg-zinc-800 hover:text-white transition-all"
            >
              Kirim Permintaan
            </button>
          </div>
        </form>
      </div>

      <div class="max-w-3xl mx-auto mt-12 bg-zinc-800 border-4 border-white p-8 transform rotate-[0.8deg]">
        <h2 class="text-2xl font-black uppercase tracking-tighter mb-4 text-white">
          Apa yang terjadi selanjutnya?
        </h2>
        <ul class="text-white space-y-4">
          <li class="flex items-start">
            <span class="font-bold mr-2">1.</span>
            <span>Kami meninjau semua permintaan topik setiap minggu.</span>
          </li>
          <li class="flex items-start">
            <span class="font-bold mr-2">2.</span>
            <span>Jika dipilih, kami akan meneliti topik dan menjadwalkannya untuk produksi.</span>
          </li>
          <li class="flex items-start">
            <span class="font-bold mr-2">3.</span>
            <span>
              Kami akan memberi tahu Anda melalui email (jika disediakan) ketika topik Anda dijadwalkan.
            </span>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("submit-request", _params, socket) do
    # In a future implementation, this would process the form data
    # For now, we'll just acknowledge the submission
    {:noreply, socket}
  end
end
