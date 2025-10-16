library(dplyr)
library(readr)
library(lubridate)
library(janitor)

# Use a join to add location information to the rodent captures data
# The `PortalData/SiteandMethods/Portal_UTMCoords.csv` file contains information about the location of each plot

rodents <- read_csv("PortalData/Rodents/Portal_rodent.csv") |>
  clean_names()

plots <- read_csv("PortalData/SiteandMethods/Portal_UTMCoords.csv") |>
  clean_names()

# Use a join to find all the captures where the species is a granivore
rodents <- read_csv("PortalData/Rodents/Portal_rodent.csv") |>
  clean_names()

rodent_species <- read_csv("PortalData/Rodents/Portal_rodent_species.csv")

# Using the rodent trapping data and the plant census dates data, join the two
# datasets to find out which plant census (year and season) each rodent capture is associated with.
rodent_trapping <- read_csv("PortalData/Rodents/Portal_rodent_trapping.csv")

# Extra challenge: Pretend that `period` is not a column in `PortalData/Rodents/moon_dates.csv` data,
# find the closest new moon prior to each trapping period in `PortalData/Rodents/Portal_rodent_trapping.csv`
