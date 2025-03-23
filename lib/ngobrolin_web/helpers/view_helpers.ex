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

  def format_date_with_timezone(naive_datetime, timezone \\ "Asia/Jakarta") do
    utc_dt = DateTime.from_naive!(naive_datetime, "Etc/UTC")
    local_dt = DateTime.shift_zone!(utc_dt, timezone)

    # Subtract one day
    adjusted_dt = DateTime.add(local_dt, -1, :day)

    Calendar.strftime(adjusted_dt, "%d %b %Y")
  end

  def truncate(string, max_length \\ 300) do
    if String.length(string) > max_length do
      String.slice(string, 0, max_length) <> "..."
    else
      string
    end
  end
end
