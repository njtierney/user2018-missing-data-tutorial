library(GSODR)
# https://ropensci.github.io/GSODR/articles/GSODR.html#using-nearest_stations

sf_loc <- ggmap::geocode("201 3rd Street, San Francisco")

sf_stations <- nearest_stations(LAT = sf_loc$lat,
                                LON = sf_loc$lon,
                                distance = 10)

dat_sf_raw <- get_GSOD(years = c(2017,2018), station = sf_stations)

str(dat_sf_raw)


dat_sf_raw %>%
  leaflet() %>%
  addTiles() %>%
  addCircles(~LON,
             ~LAT) %>%
  addCircles(lng = -122.3999,
             lat = 37.78502)


readr::write_rds(dat_sf_raw, path = "data/dat_sf_raw.rds")
