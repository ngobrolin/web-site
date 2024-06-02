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
        artwork: "some artwork",
        description: "some description",
        title: "some title",
        youtubeid: "some youtubeid"
      })
      |> Ngobrolin.Content.create_episode()

    episode
  end
end
