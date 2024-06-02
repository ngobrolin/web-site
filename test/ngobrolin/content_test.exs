defmodule Ngobrolin.ContentTest do
  use Ngobrolin.DataCase

  alias Ngobrolin.Content

  describe "episodes" do
    alias Ngobrolin.Content.Episode

    import Ngobrolin.ContentFixtures

    @invalid_attrs %{artwork: nil, description: nil, title: nil, youtubeid: nil}

    test "list_episodes/0 returns all episodes" do
      episode = episode_fixture()
      assert Content.list_episodes() == [episode]
    end

    test "get_episode!/1 returns the episode with given id" do
      episode = episode_fixture()
      assert Content.get_episode!(episode.id) == episode
    end

    test "create_episode/1 with valid data creates a episode" do
      valid_attrs = %{artwork: "some artwork", description: "some description", title: "some title", youtubeid: "some youtubeid"}

      assert {:ok, %Episode{} = episode} = Content.create_episode(valid_attrs)
      assert episode.artwork == "some artwork"
      assert episode.description == "some description"
      assert episode.title == "some title"
      assert episode.youtubeid == "some youtubeid"
    end

    test "create_episode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_episode(@invalid_attrs)
    end

    test "update_episode/2 with valid data updates the episode" do
      episode = episode_fixture()
      update_attrs = %{artwork: "some updated artwork", description: "some updated description", title: "some updated title", youtubeid: "some updated youtubeid"}

      assert {:ok, %Episode{} = episode} = Content.update_episode(episode, update_attrs)
      assert episode.artwork == "some updated artwork"
      assert episode.description == "some updated description"
      assert episode.title == "some updated title"
      assert episode.youtubeid == "some updated youtubeid"
    end

    test "update_episode/2 with invalid data returns error changeset" do
      episode = episode_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_episode(episode, @invalid_attrs)
      assert episode == Content.get_episode!(episode.id)
    end

    test "delete_episode/1 deletes the episode" do
      episode = episode_fixture()
      assert {:ok, %Episode{}} = Content.delete_episode(episode)
      assert_raise Ecto.NoResultsError, fn -> Content.get_episode!(episode.id) end
    end

    test "change_episode/1 returns a episode changeset" do
      episode = episode_fixture()
      assert %Ecto.Changeset{} = Content.change_episode(episode)
    end
  end
end
