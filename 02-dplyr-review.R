library(dplyr)
library(janitor)
library(readr)

# Use `readr::read_csv()` and assign it to a data frame called `rodents`.
# Standardize column names to use `snake_case` *(hint: check out the `janitor` package)*

# Select record_id, id, and species from rodents

# Select the `id` column, and all of the numeric columns

# Select all columns except the columns starting with "note"

# Reorder the columns, moving the last column to the first position, without specifying any column names

## Filter

## Mutate

# Using the `rodents` data set find the mean hindfoot length per weight of
# Merriam's Kangaroo Rats (`"DM"`) grouped by `plot` and arranged by thew new
# hfl per weight column.

# Remove records from invalid sampling periods (when `period` is negative). Re-assign the result to the `rodents` data frame.

# How many individuals of each species were caught in 1995?

# What date had the highest number of individual rodents caught?

# Calculate the percent difference in weight from the species' average weight for each capture.

# Of all Ord's Kangaroo Rats (species code "DO") that have been caught more than 5 times,
# which individual has the highest average percent difference in weight from the species' average weight?
