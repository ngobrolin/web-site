defmodule Ngobrolin.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ngobrolin.Content` context.
  """

  @doc """
  Generate a episode.
  """
  def episode_fixture(attrs \\ %{}) do
    {:ok, episode} =
      attrs
      |> Enum.into(%{
        description: "some description",
        duration: 42,
        published_at: ~N[2024-02-19 03:16:00],
        status: "published",
        thumbnail_url: "some thumbnail_url",
        title: "some title",
        view_count: 42,
        youtube_id: "some youtube_id"
      })
      |> Ngobrolin.Content.create_episode()

    episode
  end
end
