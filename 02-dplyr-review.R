library(dplyr)
library(janitor)
library(readr)

rodents <- read_csv("PortalData/Rodents/Portal_rodent.csv") |>
  clean_names()

# How many individuals of each species were caught in 1995?

rodents |>
  filter(year == 1995) |>
  group_by(species) |>
  summarize(count = n_distinct(id))

# OR, use the newer `.by` argument of `summarize()`

rodents |>
  filter(year == 1995) |>
  summarize(count = n_distinct(id), .by = species)

# Calculate the percent difference in weight from the species' average weight for each capture.
rodents <- rodents |>
  filter(!is.na(wgt)) |>
  group_by(species) |>
  mutate(
    avg_spec_weight = mean(wgt),
    pct_diff = ((wgt - avg_spec_weight) / avg_spec_weight) * 100
  )

# Of all Ord's Kangaroo Rats (species code "DO") that have been caught more than 5 times,
# which individual has the highest average percent difference in weight from the species' average weight?
rodents |>
  filter(species == "DO") |>
  group_by(id) |>
  mutate(n_captures = n()) |>
  filter(n_captures > 5) |>
  summarize(mean_pct_diff = mean(pct_diff)) |>
  slice_max(order_by = mean_pct_diff, n = 1)
