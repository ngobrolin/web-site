defmodule Ngobrolin.Repo.Migrations.AddEpisodeNumberToEpisode do
  use Ecto.Migration

  def change do
    execute "CREATE SEQUENCE episode_number_seq"

    alter table(:episodes) do
      add :episode_number, :integer, default: fragment("nextval('episode_number_seq')")
    end
  end
end
