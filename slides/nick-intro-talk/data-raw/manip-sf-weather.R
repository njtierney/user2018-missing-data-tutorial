dat_sf_raw <- readr::read_rds("data/dat_sf_raw.rds")

library(tidyverse)
library(lubridate)
library(leaflet)
library(naniar)

# can I get, date, wind, temperature, rain?

dat_sf_raw %>% visdat::vis_miss()

dat_sf_raw %>%
  filter(STN_NAME == "SAN FRANCISCO") %>%
  select(LAT,LON) %>%
  slice(1)

dat_sf_raw %>%
  filter(STN_NAME == "SAN FRANCISCO") %>%
  leaflet() %>%
  addTiles() %>%
  addCircles(~LON,
             ~LAT) %>%
  addCircles(lng = -122.3999,
             lat = 37.78502)

dat_sf <- dat_sf_raw %>%
  select(STN_NAME,
         YEARMODA,
         MIN,
         MAX,
         TEMP,
         MXSPD) %>%
  filter(STN_NAME == "SAN FRANCISCO") %>%
  # drop station name
  select(-STN_NAME) %>%
  # fix names 
  janitor::clean_names() %>%
  rename(date = yearmoda,
         temp_avg = temp,
         temp_min = min,
         temp_max = max,
         wind_speed_max = mxspd)

dat_sf %>%
  ggplot(aes(x = temp_avg,
             y = wind_speed_max)) + 
  geom_point()

ggplot(dat_sf,
       aes(x = date,
           y = wind_speed_max)) + 
  geom_line() + 
  geom_hline(yintercept = 8)

dat_sf_na <- dat_sf %>% mutate(high_wind = wind_speed_max >= 8)

# set things to NA quickly
dat_sf_na[dat_sf_na$high_wind,"temp_avg"] <- NA
dat_sf_na[dat_sf_na$high_wind,"temp_max"] <- NA
dat_sf_na[dat_sf_na$high_wind,"temp_min"] <- NA

# drop high_wind
dat_sf_na[["high_wind"]] <- NULL

dat_sf_na %>%
  ggplot(aes(x = temp_avg,
             y = wind_speed_max)) + 
  geom_point()

dat_sf_na %>%
  ggplot(aes(x = temp_avg,
             y = wind_speed_max)) + 
  geom_miss_point()

dat_sf_2018

visdat::vis_miss(dat_sf_na)

# add a bit more messyness
# dat_sf_messy <- 
  
dat_sf_clean <- dat_sf_na %>%
    mutate(na_id = sample(x = c(TRUE,FALSE), 
                          size = n(), 
                          replace = TRUE, 
                          prob = c(0.05,.95)),
           wind_speed_max = if_else(na_id,
                                    true = NA_real_,
                                    false = wind_speed_max)) %>%
    # drop missing indicator
    select(-na_id) %>%
  # add a month column
  mutate(month  = lubridate::month(date)) %>%
  select(date, month, everything())

dat_sf_unclean <- dat_sf_clean %>%
  mutate_if(is.numeric, as.character)

# save the data

readr::write_rds(dat_sf_clean, "data/dat_sf_clean.rds")
readr::write_rds(dat_sf_unclean, "data/dat_sf_unclean.rds")
