library(dplyr)
library(readr)
library(lubridate)
library(janitor)

# Use a join to add location information to the rodent captures data
# The `SiteandMethods/Portal_UTMCoords.csv` file contains information about the location of each plot

rodents <- read_csv("PortalData/Rodents/Portal_rodent.csv") |>
  clean_names()


plots <- read_csv("PortalData/SiteandMethods/Portal_UTMCoords.csv") |>
  clean_names()

rodents_with_locations <- rodents |>
  left_join(
    plots |> filter(type == "stake") |> mutate(plot = as.numeric(plot)),
    by = c("plot", "stake" = "number")
  )

# Warning message:
# In left_join(rodents, mutate(filter(plots, type == "stake"), plot = as.numeric(plot)),  :
#   Detected an unexpected many-to-many relationship
# between `x` and `y`.
# ℹ Row 2670 of `x` matches multiple rows in `y`.
# ℹ Row 843 of `y` matches multiple rows in `x`.
# ℹ If a many-to-many relationship is expected, set
#   `relationship = "many-to-many"` to silence this
#   warning.

unique_stakes <- plots |>
  filter(type == "stake") |>
  mutate(plot = as.numeric(plot)) |>
  summarise(across(where(is.numeric), mean), .by = c(plot, type, number))

rodents_with_locations <- rodents |>
  left_join(
    unique_stakes,
    by = c("plot", "stake" = "number")
  )


# Use a join to find all the captures where the species is a granivore
rodents <- read_csv("PortalData/Rodents/Portal_rodent.csv") |>
  clean_names()
rodent_species <- read_csv("PortalData/Rodents/Portal_rodent_species.csv")

granivores <- rodent_species |>
  mutate(granivore = as.logical(granivore)) |>
  filter(granivore) |>
  select(speciescode, species)

granivore_captures <- rodents |>
  semi_join(granivores, by = c("species" = "speciescode"))

# overlap joins with between()
# Using the rodent trapping data and the plant census dates data, join the two
# datasets to find out which plant census (year and season) each rodent capture is associated with.
rodent_trapping <- read_csv("PortalData/Rodents/Portal_rodent_trapping.csv")

plant_census_dates <- read_csv(
  "PortalData/Plants/Portal_plant_census_dates.csv",
  na = c("unknown", "none")
)


plant_census_dates <- plant_census_dates |>
  filter(!if_any(matches("(day)|(month)$"), is.na)) |>
  mutate(
    start_date = ymd(paste(year, start_month, start_day, sep = "-")),
    end_date = ymd(paste(year, end_month, end_day, sep = "-"))
  )

# exclude <- c("unknown", "none")
# plant_census_dates <- plant_census_dates |>
#   filter(if_any(matches("(day)|(month)$"), \(x) {
#     !x %in% exclude
#   })) |>
#   mutate(
#     start_date = as.Date(paste(year, start_month, start_day, sep = "-")),
#     end_date = as.Date(paste(year, end_month, end_day, sep = "-"))
#   )

rodent_trapping <- rodent_trapping |>
  mutate(date = as.Date(paste(year, month, day, sep = "-")))

joined_data <- rodent_trapping |>
  inner_join(
    plant_census_dates,
    by = join_by(between(date, start_date, end_date))
  )

# Extra challenge: Pretend that `period` is not a column in `PortalData/Rodents/moon_dates.csv` data,
# find the closest new moon prior to each trapping period in `PortalData/Rodents/Portal_rodent_trapping.csv`
