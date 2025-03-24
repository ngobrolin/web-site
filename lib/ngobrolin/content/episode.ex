defmodule Ngobrolin.Content.Episode do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "episodes" do
    field :status, :string
    field :description, :string
    field :title, :string
    field :thumbnail_url, :string
    field :duration, :integer
    field :published_at, :naive_datetime
    field :youtube_id, :string
    field :view_count, :integer, default: 0
    field :episode_number, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(episode, attrs) do
    episode
    |> cast(attrs, [
      :title,
      :description,
      :thumbnail_url,
      :duration,
      :published_at,
      :youtube_id,
      :view_count,
      :status,
      :episode_number
    ])
    |> validate_required([
      :title,
      :description,
      :thumbnail_url,
      :duration,
      :published_at,
      :youtube_id,
      :status
    ])
  end
end
