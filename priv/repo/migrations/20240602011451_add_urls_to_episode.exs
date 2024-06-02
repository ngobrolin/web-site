defmodule Ngobrolin.Repo.Migrations.AddUrlsToEpisode do
  use Ecto.Migration

  def change do
    alter table(:episodes) do
      add :audio_url, :string
      add :video_url, :string
    end
  end
end
