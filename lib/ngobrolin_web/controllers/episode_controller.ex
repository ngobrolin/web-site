defmodule NgobrolinWeb.EpisodeController do
  use NgobrolinWeb, :controller

  alias Ngobrolin.Content
  alias Ngobrolin.Content.Episode

  def index(conn, _params) do
    episodes = Content.list_episodes()
    render(conn, :index, episodes: episodes)
  end

  def new(conn, _params) do
    changeset = Content.change_episode(%Episode{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"episode" => episode_params}) do
    case Content.create_episode(episode_params) do
      {:ok, episode} ->
        conn
        |> put_flash(:info, "Episode created successfully.")
        |> redirect(to: ~p"/episodes/#{episode}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    episode = Content.get_episode!(id)
    render(conn, :show, episode: episode)
  end

  def edit(conn, %{"id" => id}) do
    episode = Content.get_episode!(id)
    changeset = Content.change_episode(episode)
    render(conn, :edit, episode: episode, changeset: changeset)
  end

  def update(conn, %{"id" => id, "episode" => episode_params}) do
    episode = Content.get_episode!(id)

    case Content.update_episode(episode, episode_params) do
      {:ok, episode} ->
        conn
        |> put_flash(:info, "Episode updated successfully.")
        |> redirect(to: ~p"/episodes/#{episode}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, episode: episode, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    episode = Content.get_episode!(id)
    {:ok, _episode} = Content.delete_episode(episode)

    conn
    |> put_flash(:info, "Episode deleted successfully.")
    |> redirect(to: ~p"/episodes")
  end
end
