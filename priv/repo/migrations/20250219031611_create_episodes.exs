defmodule Ngobrolin.Repo.Migrations.CreateEpisodes do
  use Ecto.Migration

  def change do
    create table(:episodes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :thumbnail_url, :string
      add :duration, :integer
      add :published_at, :naive_datetime
      add :youtube_id, :string
      add :view_count, :integer
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
