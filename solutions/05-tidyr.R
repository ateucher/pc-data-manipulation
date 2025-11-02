library(readr)
library(tidyr)
library(dplyr)

billboard

# How would we plot this data to show how the rank of different songs changed over time?

library(ggplot2)

ggplot(billboard) +
  geom_line(aes())
# ... this is tricky!

# What shape would this data have in long format?.

billboard_long <- billboard |>
  pivot_longer(
    cols = wk1:last_col(),
    names_to = "week",
    names_prefix = "wk",
    names_transform = as.integer,
    values_to = "chart_position",
    values_drop_na = TRUE
  )

ggplot(billboard_long) +
  geom_line(aes(x = week_num, y = chart_position, group = track)) +
  scale_y_reverse()

# Use `SitesandMethods/Portal_plot_treatments.csv` and pivot it to longer so
# there is a start_date, end_date, and treatment column. See if you can get the
# dates into proper date format. The `lubridate` package may be helpful.
portal_plot_treatments <- read_csv(
  "PortalData/SiteandMethods/Portal_plot_treatments.csv"
)

portal_plot_treatments |>
  pivot_longer(
    cols = -c(plot, term),
    names_to = "date_range",
    values_to = "treatment"
  ) |>
  separate_wider_delim(
    date_range,
    delim = "_",
    names = c("start_date", "end_date")
  ) |>
  mutate(
    across(ends_with("date"), lubridate::my),
    end_date = lubridate::ceiling_date(
      end_date,
      unit = "months"
    ) -
      lubridate::day(1)
  )

# OR all in one

portal_plot_treatments_long <- portal_plot_treatments |>
  pivot_longer(
    cols = -c(plot, term),
    names_to = c("start_date", "end_date"),
    names_sep = "_",
    names_transform = list(
      start_date = lubridate::my,
      end_date = \(x) lubridate::rollforward(lubridate::my(x))
    ),
    # names_transform = \(x) as.Date(paste0("01",x), format = "%d%B%Y"),
    values_to = "treatment"
  )
