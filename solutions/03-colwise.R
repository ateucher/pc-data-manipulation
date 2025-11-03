library(readr)
library(dplyr)

# calculate mean of all numeric columns
mtcars |>
  group_by(cyl) |>
  summarize(across(where(is.numeric), mean))

# Scale `hfl` and `wgt` (use `across()`) in `rodents` to have mean 0 and standard deviation 1. *(Hint: Check out the `scale()` function)*
# Bonus: Use the .names argument to keep the original columns and give the new columns a sensible name
rodents |>
  mutate(across(c(hfl, wgt), scale, .names = "{.col}_scaled"))

# calculate mean and sd of all numeric columns, grouped by cyl
mtcars |>
  group_by(cyl) |>
  summarize(
    across(where(is.numeric), list(mean = mean, sd = sd))
  )

# For all numeric columns in penguins calculate the mean and standard deviation
# Run this in your R session, what do you get?

penguins |>
  summarize(
    across(where(is.numeric), list(mean = mean, sd = sd))
  )

# Fix it using custom functions

library(dplyr)

sd_na <- function(x) {
  sd(x, na.rm = TRUE)
}

mean_na <- function(x) {
  mean(x, na.rm = TRUE)
}

penguins |>
  summarize(
    across(where(is.numeric), list(mean = mean_na, sd = sd_na))
  )

# Anonymous functions

penguins |>
  summarize(
    across(
      where(is.numeric),
      list(
        mean = \(x) mean(x, na.rm = TRUE),
        sd = \(x) sd(x, na.rm = TRUE)
      )
    )
  )

# Calculate maximum of all bill measurements for each species in the built-in penguins dataset

penguins |>
  group_by(species) |>
  summarise(
    across(
      starts_with("bill"),
      \(x) max(x, na.rm = TRUE),
      .names = c("max_{.col}")
    )
  )

# Calculate the median of hind-foot length (`hfl`) and weight (`wgt`) for each species in `rodents`, ignoring `NA` values.

rodents <- read_csv("PortalData/Rodents/Portal_rodent.csv")

rodents |>
  group_by(species) |>
  summarize(across(c(hfl, wgt), median))

rodents |>
  group_by(species) |>
  summarize(across(c(hfl, wgt), \(x) median(x, na.rm = TRUE)))

# Round all of the numeric colums in the `PortalData/SiteandMethods/Portal_UTMCoords.csv` dataset to 2 decimal places
plots |>
  mutate(across(where(is.double), \(x) round(x, digits = 2)))
