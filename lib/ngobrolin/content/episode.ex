defmodule Ngobrolin.Content.Episode do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "episodes" do
    field :artwork, :string
    field :description, :string
    field :title, :string
    field :youtubeid, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(episode, attrs) do
    episode
    |> cast(attrs, [:title, :description, :youtubeid, :artwork])
    |> validate_required([:title, :description, :youtubeid, :artwork])
  end
end
