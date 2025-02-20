# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ngobrolin.Repo.insert!(%Ngobrolin.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Ngobrolin.Repo
alias Ngobrolin.Content.Episode

# Clear existing episodes
Repo.delete_all(Episode)

episodes = [
  %{
    title: "Membangun Sistem Scalable dengan Elixir",
    description:
      "Di episode ini, kita akan membahas secara mendalam bagaimana Elixir dan BEAM VM memungkinkan pembangunan sistem yang highly concurrent dan fault-tolerant. Kita akan diskusi tentang pola OTP, supervisor, dan contoh implementasi di dunia nyata.",
    thumbnail_url: "https://i.ytimg.com/vi/example1/maxresdefault.jpg",
    # 1 jam dalam detik
    duration: 3600,
    published_at: ~N[2024-01-15 13:00:00],
    youtube_id: "example1",
    view_count: 1500,
    status: "published"
  },
  %{
    title: "Pengembangan Frontend Modern dengan Phoenix LiveView",
    description:
      "Eksplorasi bagaimana Phoenix LiveView mengubah cara kita membangun aplikasi web real-time. Kita akan membahas live updates, penanganan form, dan pembangunan UI interaktif tanpa framework JavaScript yang kompleks.",
    thumbnail_url: "https://i.ytimg.com/vi/example2/maxresdefault.jpg",
    # 45 menit dalam detik
    duration: 2700,
    published_at: ~N[2024-02-01 15:00:00],
    youtube_id: "example2",
    view_count: 2300,
    status: "published"
  },
  %{
    title: "Teknik Optimasi Kinerja Database",
    description:
      "Pelajari teknik-teknik penting untuk mengoptimalkan kinerja database dalam aplikasi web. Topik mencakup strategi indexing, optimasi query, dan penanganan dataset besar secara efisien.",
    thumbnail_url: "https://i.ytimg.com/vi/example3/maxresdefault.jpg",
    # 55 menit dalam detik
    duration: 3300,
    published_at: ~N[2024-02-15 14:00:00],
    youtube_id: "example3",
    view_count: 1800,
    status: "published"
  },
  %{
    title: "Membangun API dengan Phoenix",
    description:
      "Panduan lengkap untuk membangun API yang robust menggunakan Phoenix Framework. Kita akan membahas prinsip REST, serialisasi JSON, autentikasi, dan best practice dalam desain API.",
    thumbnail_url: "https://i.ytimg.com/vi/example4/maxresdefault.jpg",
    # 50 menit dalam detik
    duration: 3000,
    published_at: ~N[2024-03-01 16:00:00],
    youtube_id: "example4",
    view_count: 1200,
    status: "published"
  }
]

Enum.with_index(episodes, 1)
|> Enum.each(fn {episode, index} ->
  episode
  |> Map.put(:episode_number, index)
  |> then(&Episode.changeset(%Episode{}, &1))
  |> Repo.insert!()
end)
