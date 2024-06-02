defmodule Ngobrolin.Scheduler do
  use GenServer

  @period 60_000

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(state) do
    schedule_fetch()
    {:ok, state}
  end

  def handle_info(:fetch_episodes, state) do
    IO.puts("Fetching episodes...")
    episodes =
      Ngobrolin.YoutubeApi.request_episodes_from_playlist("PLTY2nW4jwtG8Sx2Bw6QShC271PzX31CtT")
      |> Ngobrolin.YoutubeApi.parse_body()

    Enum.each(episodes, fn episode ->
      Ngobrolin.Content.create_episode(%{
        title: episode.title,
        youtubeid: episode.video_id,
        description: episode.description,
        artwork: episode.artwork
      })
    end)

    schedule_fetch()
    {:noreply, state}
    
  end

  defp schedule_fetch do
    Process.send_after(self(), :fetch_episodes, @period)
  end
end