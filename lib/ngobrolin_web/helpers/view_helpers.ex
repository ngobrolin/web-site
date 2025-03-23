defmodule NgobrolinWeb.ViewHelpers do
  def format_duration(seconds) do
    case seconds do
      nil ->
        "0 detik"

      sec ->
        minutes = div(sec, 60)
        "#{minutes} menit"
    end
  end

  def format_date(naive_datetime) do
    case naive_datetime do
      nil ->
        "Tanggal tidak tersedia"

      _ ->
        Calendar.strftime(naive_datetime, "%d %b %Y")
    end
  end

  def truncate(string, max_length \\ 300) do
    if String.length(string) > max_length do
      String.slice(string, 0, max_length) <> "..."
    else
      string
    end
  end
end
