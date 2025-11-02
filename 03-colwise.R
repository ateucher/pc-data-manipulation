library(dplyr)
library(readr)

# calculate mean of all numeric columns
mtcars |>
  group_by(cyl) |>
  summarize(across(where(is.numeric), mean))

# calculate mean and sd of all numeric columns, grouped by cyl
mtcars |>
  group_by(cyl) |>
  summarize(
    across(where(is.numeric), list(mean = mean, sd = sd))
  )

# For all numeric columns in penguins calculate the mean and standard deviation
penguins |>
  summarize(
    across(where(is.numeric), list(mean = mean, sd = sd))
  )

# Fix this to make it remove NA values

# Calculate maximum of all bill measurements for each species in the built-in penguins dataset

# Calculate the median of hind-foot length (`hfl`) and weight (`wgt`) for each species in `rodents`, ignoring `NA` values.

# Round all of the numeric colums in the `PortalData/SiteandMethods/Portal_UTMCoords.csv` dataset to 2 decimal places

rodents <- read_csv("PortalData/Rodents/Portal_rodent.csv")
