defmodule NgobrolinWeb.ViewHelpers do
  def format_duration(seconds) do
    minutes = div(seconds, 60)
    "#{minutes} menit"
  end

  def format_date(naive_datetime) do
    Calendar.strftime(naive_datetime, "%d %b %Y")
  end
end
