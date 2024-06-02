defmodule NgobrolinWeb.EpisodeHTML do
  use NgobrolinWeb, :html

  embed_templates "episode_html/*"

  @doc """
  Renders a episode form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def episode_form(assigns)
end
