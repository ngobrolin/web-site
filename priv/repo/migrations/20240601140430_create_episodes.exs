defmodule Ngobrolin.Repo.Migrations.CreateEpisodes do
  use Ecto.Migration

  def change do
    create table(:episodes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :string
      add :youtubeid, :string
      add :artwork, :string

      timestamps(type: :utc_datetime)
    end
  end
end
