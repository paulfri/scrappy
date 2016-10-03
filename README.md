# Scrappy

This is a scraper I wrote to get historical MLS game data from mlssoccer.com. It
may or may not work if the layout of their page ever changes.

The output is in the `data/` directory, e.g., results from the [1996
season](https://github.com/paulfri/scrappy/blob/master/data/1996.csv). Somewhat
hilariously, MLS preserved the names of the original stadiums, but not for teams
that have had more than one name (RBNY, SJ, SKC, FC Dallas, etc).

I didn't bother filtering for full-time results, so if you run this during the
middle of a game, it will show the score in progress.

## Usage

Bundled as an escript, so requires an Elixir installation.

```
./bin/scrappy --year 2016
```
