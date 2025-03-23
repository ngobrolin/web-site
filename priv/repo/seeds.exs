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
alias Ngobrolin.Youtube
alias Ngobrolin.Content.Episode

# Clear existing episodes
Repo.delete_all(Episode)

Youtube.sync(Application.get_env(:ngobrolin, :playlist_id))
