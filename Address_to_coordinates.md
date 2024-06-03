# Addresses to Coordinates


``` r
#install.packages('terra')
library('tidyverse')
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
    ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
    ✔ purrr     1.0.2     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library('ggmap')
```

    Warning: package 'ggmap' was built under R version 4.3.3

    ℹ Google's Terms of Service: <https://mapsplatform.google.com>
      Stadia Maps' Terms of Service: <https://stadiamaps.com/terms-of-service/>
      OpenStreetMap's Tile Usage Policy: <https://operations.osmfoundation.org/policies/tiles/>
    ℹ Please cite ggmap if you use it! Use `citation("ggmap")` for details.

``` r
library('terra')
```

    Warning: package 'terra' was built under R version 4.3.3

    terra 1.7.78

    Attaching package: 'terra'

    The following object is masked from 'package:ggmap':

        inset

    The following object is masked from 'package:tidyr':

        extract

``` r
c <- read.csv('Houston Data Collection - Charlotte.csv')


register_google(key = "AIzaSyBwB1vPbEGg11mc-E2ePo8K_C5-cSmsWPw", write = TRUE)
```

    ℹ Replacing old key (AIzaSyBwB1vPbEGg11mc) with new key in C:\Users\joshu\OneDrive\Documents/.Renviron

``` r
addr <- data.frame(Address = c$Address,
                   stringsAsFactors = FALSE)

addr.geo <- mutate_geocode(addr, location = Address, output = "latlona")
```

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=6+N+Main+St,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=367+Main+St,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=414+Main+St,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=714+Main+St,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=960+Main+St,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=1131+Main+St,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=1453+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=1523+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=1840+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=1914+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=2560+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=2606+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=3509+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=3604+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=4590+Main+St.,+Houston,+TX+77002&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=5640+San+Jacinto+St,+Houston,+TX+77004&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=5660+Fannin+St.,+Houston,+TX+77004&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=6050+Fannin+St.,+Houston,+TX+77030&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=6413+Fannin+St.,+Houston,+TX+77030&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=6407+Fannin+St.,+Houston,+TX+77030&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=6607+Fannin+St.,+Houston,+TX+77021&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=6614+Fannin+St.,+Houston,+TX+77030&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=5640+San+Jacinto+St.,+Houston,+TX+77004Will&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=7834+Greenbriar+Drive,+Houston,+TX+77054&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=8168+Fannin+St.,+Houston,+TX+77054&key=xxx-E2ePo8K_C5-cSmsWPw>

    ℹ <https://maps.googleapis.com/maps/api/geocode/json?address=1604+West+Bellfort+Ave.,+Houston,+TX+77054&key=xxx-E2ePo8K_C5-cSmsWPw>

``` r
lon <- addr.geo$lon
lat <- addr.geo$lat
lonlat <- cbind(lon,lat)

crdref <- "+proj=longlat +datum=WGS84"

pts <- vect(lonlat, crs = crdref)
plot(pts, pax = list(xat = c(-95.4, -95.39, -95.38, -95.37, -95.36)))
```

![](Address_to_coordinates_files/figure-commonmark/unnamed-chunk-4-1.png)
