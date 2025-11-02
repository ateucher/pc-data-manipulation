library(readr)
library(tidyr)
library(dplyr)

billboard

# How would we plot this data to show how the rank of different songs changed over time?

library(ggplot2)

# What shape would this data have in long format?.

# Use `SitesandMethods/Portal_plot_treatments.csv` and pivot it to longer so
# there is a start_date, end_date, and treatment column. See if you can get the
# dates into proper date format. The `lubridate` package may be helpful.
portal_plot_treatments <- read_csv(
  "PortalData/SiteandMethods/Portal_plot_treatments.csv"
)
