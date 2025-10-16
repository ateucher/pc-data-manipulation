library(dplyr)

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

penguins |>
  summarize(
    across(where(is.numeric), list(mean = mean, sd = sd))
  )


# Calculate median of bill measurements for each species in the built-in penguins dataset

penguins |>
  group_by(species) |>
  summarize(across(starts_with("bill"), median))

penguins |>
  group_by(species) |>
  summarize(across(starts_with("bill"), \(x) median(x, na.rm = TRUE)))

# Round all of the numeric colums in the `PortalData/SiteandMethods/Portal_UTMCoords.csv` dataset to 2 decimal places
plots |>
  mutate(across(where(is.double), \(x) round(x, digits = 2)))
