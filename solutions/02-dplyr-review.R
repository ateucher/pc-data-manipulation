library(dplyr)
library(janitor)
library(readr)

rodents <- read_csv("PortalData/Rodents/Portal_rodent.csv") |>
  clean_names()

# Select record_id, id, and species from rodents

rodents |> select(record_id, species, id)

# Select the `id` column, and all of the numeric columns

rodents |> select(id, where(is.numeric))

# Select all columns except the "note" columns (starting with `note`)

rodents |> select(-starts_with("note"))

# Reorder the columns, moving the last column to the first position, without specifying any column names

rodents |> select(last_col(), everything())

# Using the `rodents` data set find the mean hindfoot length per weight of
# Merriam's Kangaroo Rats (`"DM"`) grouped by `plot` and arranged by thew new
# hfl per weight column.

rodents |>
  filter(species == "DM") |>
  mutate(hfl_per_wgt = hfl / wgt) |>
  group_by(plot) |>
  summarise(mean_hfl_per_wgt = mean(hfl_per_wgt, na.rm = TRUE)) |>
  arrange(mean_hfl_per_wgt)

# Remove records from invalid sampling periods (when `period` is negative). Re-assign the result to the `rodents` data frame.

rodents <- rodents |>
  filter(period > 0)

# How many individuals of each species were caught in 1995?

rodents |>
  filter(year == 1995) |>
  group_by(species) |>
  summarize(count = n_distinct(id))

# OR, use the newer `.by` argument of `summarize()`

rodents |>
  filter(year == 1995) |>
  summarize(count = n_distinct(id), .by = species)

# What date had the highest number of individual rodents caught?
rodents |>
  mutate(date = as.Date(paste(year, month, day, sep = "-"))) |>
  group_by(date) |>
  summarize(count = n_distinct(id)) |>
  slice_max(order_by = count, n = 1)

# Calculate the percent difference in weight from the species' average weight for each capture.
rodents <- rodents |>
  filter(!is.na(wgt)) |>
  group_by(species) |>
  mutate(
    avg_spec_weight = mean(wgt, na.rm = TRUE),
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
