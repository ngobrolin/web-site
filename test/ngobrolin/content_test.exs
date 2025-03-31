defmodule Ngobrolin.ContentTest do
  use Ngobrolin.DataCase

  alias Ngobrolin.Content

  describe "episodes" do
    alias Ngobrolin.Content.Episode

    import Ngobrolin.ContentFixtures

    @invalid_attrs %{
      status: nil,
      description: nil,
      title: nil,
      thumbnail_url: nil,
      duration: nil,
      published_at: nil,
      youtube_id: nil,
      view_count: nil
    }

    test "list_episodes/0 returns all episodes" do
      episode = episode_fixture()
      assert Content.list_episodes() |> List.first() |> Map.get(:id) == episode.id
    end

    test "list_episodes/1 returns all episodes with the given status" do
      episode_fixture(status: "downloaded")
      episode_fixture()
      expected_episode = Content.list_episodes(%{where: [status: "downloaded"]})
      assert Enum.count(expected_episode) > 0
    end

    test "list_new_episodes/0 returns all episodes with status != downloaded" do
      episode_fixture(status: "downloaded")
      episode_fixture()
      new_episodes = Content.list_new_episodes()
      assert Enum.count(new_episodes) > 0
    end

    test "get_episode!/1 returns the episode with given id" do
      episode = episode_fixture(episode_number: 191)
      assert Content.get_episode!(episode.id) == episode
    end

    test "get_episode_by_youtube_id!/1 returns the episode with given youtube_id" do
      episode = episode_fixture(youtube_id: "some_youtube_id")
      expected_episode = Content.get_episode_by_youtube_id!(episode.youtube_id)
      assert expected_episode.id == episode.id
    end

    test "get_episode_by_youtube_id!/1 raises error if youtube_id not found" do
      assert_raise Ecto.NoResultsError, fn -> Content.get_episode_by_youtube_id!("non_existent_youtube_id") end
    end

    describe "get_episode_by_episode_number!/1" do
      import Ngobrolin.ContentFixtures

      setup :episode_fixture # Use the imported fixture function for setup

      test "returns the episode with the given episode_number", %{episode: episode} do
        # The episode from setup should have a valid episode_number
        found_episode = Content.get_episode_by_episode_number!(episode.episode_number)
        assert found_episode.id == episode.id
      end

      test "raises if episode with given episode_number does not exist" do
        assert_raise Ecto.NoResultsError, fn -> Content.get_episode_by_episode_number!(999_999) end
      end
    end

    test "create_episode/1 with valid data creates a episode" do
      valid_attrs = %{
        status: "some status",
        description: "some description",
        title: "some title",
        thumbnail_url: "some thumbnail_url",
        duration: 42,
        published_at: ~N[2025-02-18 03:16:00],
        youtube_id: "some youtube_id",
        view_count: 42
      }

      assert {:ok, %Episode{} = episode} = Content.create_episode(valid_attrs)
      assert episode.status == "some status"
      assert episode.description == "some description"
      assert episode.title == "some title"
      assert episode.thumbnail_url == "some thumbnail_url"
      assert episode.duration == 42
      assert episode.published_at == ~N[2025-02-18 03:16:00]
      assert episode.youtube_id == "some youtube_id"
      assert episode.view_count == 42
    end

    test "create_episode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_episode(@invalid_attrs)
    end

    test "update_episode/2 with valid data updates the episode" do
      episode = episode_fixture()

      update_attrs = %{
        status: "some updated status",
        description: "some updated description",
        title: "some updated title",
        thumbnail_url: "some updated thumbnail_url",
        duration: 43,
        published_at: ~N[2025-02-19 03:16:00],
        youtube_id: "some updated youtube_id",
        view_count: 43
      }

      assert {:ok, %Episode{} = episode} = Content.update_episode(episode, update_attrs)
      assert episode.status == "some updated status"
      assert episode.description == "some updated description"
      assert episode.title == "some updated title"
      assert episode.thumbnail_url == "some updated thumbnail_url"
      assert episode.duration == 43
      assert episode.published_at == ~N[2025-02-19 03:16:00]
      assert episode.youtube_id == "some updated youtube_id"
      assert episode.view_count == 43
    end

    test "update_episode/2 with invalid data returns error changeset" do
      episode = episode_fixture(episode_number: 205)
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
