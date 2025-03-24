defmodule Ngobrolin.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Ngobrolin.Repo

  alias Ngobrolin.Content.Episode

  @doc """
  Returns the list of episodes.

  ## Examples

      iex> list_episodes()
      [%Episode{}, ...]

  """
  def list_episodes(opts \\ %{}) do
    Episode
    |> apply_ordering()
    |> apply_limit(opts)
    |> apply_conditions(opts)
    |> Repo.all()
  end

  defp apply_ordering(query) do
    query |> order_by([e], desc: e.published_at)
  end

  defp apply_limit(query, %{limit: limit}) do
    query |> limit(^limit)
  end

  defp apply_limit(query, _opts) do
    query
  end

  defp apply_conditions(query, %{where: conditions}) do
    query |> where(^conditions)
  end

  defp apply_conditions(query, _opts) do
    query
  end

  def list_new_episodes() do
    Episode
    |> where([e], e.status != "downloaded")
    |> Repo.all()
  end

  @doc """
  Gets a single episode.

  Raises `Ecto.NoResultsError` if the Episode does not exist.

  ## Examples

      iex> get_episode!(123)
      %Episode{}

      iex> get_episode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_episode!(id), do: Repo.get!(Episode, id)

  def get_episode_by_youtube_id!(youtube_id) do
    Episode
    |> where([e], e.youtube_id == ^youtube_id)
    |> Repo.one()
  end

  if Mix.env() == :test do
    @doc """
    Creates a episode. Only available in test environment.

    ## Examples

        iex> create_episode(%{field: value})
        {:ok, %Episode{}}

        iex> create_episode(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_episode(attrs \\ %{}) do
      %Episode{}
      |> Episode.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a episode.

  ## Examples

      iex> update_episode(episode, %{field: new_value})
      {:ok, %Episode{}}

      iex> update_episode(episode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_episode(%Episode{} = episode, attrs) do
    episode
    |> Episode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a episode.

  ## Examples

      iex> delete_episode(episode)
      {:ok, %Episode{}}

      iex> delete_episode(episode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_episode(%Episode{} = episode) do
    Repo.delete(episode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking episode changes.

  ## Examples

      iex> change_episode(episode)
      %Ecto.Changeset{data: %Episode{}}

  """
  def change_episode(%Episode{} = episode, attrs \\ %{}) do
    Episode.changeset(episode, attrs)
  end
end
