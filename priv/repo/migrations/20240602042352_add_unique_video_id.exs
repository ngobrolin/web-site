defmodule Ngobrolin.Repo.Migrations.AddUniqueVideoId do
  use Ecto.Migration

  def change do
    create unique_index(:episodes, [:youtubeid])
  end
end
