defmodule Scrappy do
  defmodule CLI do
    def main(argv) do
      {options, _, _} = OptionParser.parse(argv,
        switches: [year: :integer],
        aliases: [y: :year]
      )

      year = options[:year]

      url = cond do
        year < 1996 -> System.halt(1)
        year > 2016 -> System.halt(1)
        true        -> build_url(year)
      end

      Scrappy.scrape(url, ".match_item > .match_click_area")
      |> write_csv
    end

    defp write_csv(results) do
      IO.puts "home,home_score,away,away_score,venue\n"

      results |> Enum.each(&IO.puts(&1))
    end

    defp build_url(year) do
      "http://www.mlssoccer.com/schedule?month=all&year=#{year}&club_options=9"
    end
  end

  def scrape(url, selector) do
    fetch(url)
    |> Floki.find(selector)
    |> Enum.map(&(parse_game(&1)))
  end

  defp fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
        nil
    end
  end

  defp parse_game(game_div) do
    home       = game_div |> text(".home_club .club_name")
    home_score = game_div |> text(".home_club .match_score")
    away       = game_div |> text(".vs_club   .club_name")
    away_score = game_div |> text(".vs_club   .match_score")
    [_, venue] = game_div
                 |> text(".match_location_competition")
                 |> String.split(" / ")

    "#{home},#{home_score},#{away},#{away_score},#{venue}"
  end

  defp text(content, selector) do
    Floki.find(content, selector) |> Floki.text
  end
end
