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

  @doc """
  Returns the configured site URL from application config.
  This centralizes the website URL to make it easier to change domains.
  """
  def site_url do
    Application.get_env(:ngobrolin, :site_url)
  end

  @doc """
  Joins the site URL with a provided path.
  Ensures proper formatting of URLs throughout the site.
  """
  def site_url(path) do
    base = site_url()
    path = if String.starts_with?(path, "/"), do: path, else: "/#{path}"
    "#{base}#{path}"
  end
end
