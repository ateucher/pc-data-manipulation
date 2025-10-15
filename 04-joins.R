library(dplyr)
library(readr)
library(lubridate)

plant_census_dates <- read_csv(
  "PortalData/Plants/Portal_plant_census_dates.csv",
  na = c("unknown", "none")
)

rodent_trapping <- read_csv("PortalData/Rodents/Portal_rodent_trapping.csv")

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
