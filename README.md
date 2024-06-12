# README


## Research Question

Which demographic groups are impacted by light rail openings in the
United States.

## Research Context

- Houston, Texas

  - Red Line Light Rail

- Timeline: 2000-2008

- Hypothesis: Light rail openings increase pollution around stations

  - Reasoning: Light rail stations aggregate commuters throughout
    Houston, resulting in a concentration of pollution around these
    stations.

  - Confounding Factors

    - Power Plants: Houston has several power plants that produce PM2.5

    - Roads/Highways/Intersections: Houston has some of the most
      congested roads in the U.S.

    - Meteorological Factors

- Include table of confounding factor

``` r
library('knitr')
```

    Warning: package 'knitr' was built under R version 4.3.3

``` r
t <- read.csv('Untitled spreadsheet - Sheet1.csv')
kable(t)
```

| Name                            | Address                                         | Coords |
|:--------------------------------|:------------------------------------------------|:-------|
| UH Central Power Plant          | 4738 Calhoun Rd, Houston, TX 77004              | NA     |
| NRG T.H. Wharton Plant          | 16301 Texas 249 Access Rd, Houston, TX 77064    | NA     |
| Friendswood Energy Center       | 12100 Hiram Clarke Rd bldg-d, Houston, TX 77045 | NA     |
| W.A. Parish Generating Station  | 2500 Y. U. Jones Rd, Richmond, TX 77469         | NA     |
| EIF Channelview Cogeneration    | 8580 Sheldon Rd, Houston, TX 77049              | NA     |
| Smith Power Systems             | 256 N Sam Houston Pkwy E, Houston, TX 77060     | NA     |
| Calpine Deer Park Energy Center | 5665 Hwy 225, Deer Park, TX 77536               | NA     |

- Include table or map of stations

``` r
t <- read.csv('Houston Data Collection - Charlotte.csv')
kable(t)
```

| Station                                           | Opening.Dates   | Address                                     | Coordinate | Parking |
|:--------------------------------------------------|:----------------|:--------------------------------------------|:-----------|:--------|
| UH-Downtown                                       | 1/1/2004        | 6 N Main St, Houston, TX 77002              | NA         | FALSE   |
| Preston Northbound                                | 1/1/2004        | 367 Main St, Houston, TX 77002              | NA         | FALSE   |
| Preston Southbound                                | 1/1/2004        | 414 Main St, Houston, TX 77002              | NA         | FALSE   |
| Central Station Main                              | 2/18/2015       | 714 Main St, Houston, TX 77002              | NA         | FALSE   |
| Main Street Square Northbound                     | 1/1/2004        | 960 Main St, Houston, TX 77002              | NA         | FALSE   |
| Main Street Square Southbound                     | 1/1/2004        | 1131 Main St, Houston, TX 77002             | NA         | FALSE   |
| Bell Northbound                                   | January 1, 2004 | 1453 Main St., Houston, TX 77002            | NA         | FALSE   |
| Bell Southbound                                   | January 1, 2004 | 1523 Main St., Houston, TX 77002            | NA         | FALSE   |
| Downtown Transit Center Northbound                | 1/1/2004        | 1840 Main St., Houston, TX 77002            | NA         | FALSE   |
| Downtown Transit Center Southbound                | 1/1/2004        | 1914 Main St., Houston, TX 77002            | NA         | FALSE   |
| McGowen Northbound                                | 1/1/2004        | 2560 Main St., Houston, TX 77002            | NA         | FALSE   |
| McGowen Southbound                                | 1/1/2004        | 2606 Main St., Houston, TX 77002            | NA         | FALSE   |
| Ensemble / HCC Northbound                         | 1/1/2004        | 3509 Main St., Houston, TX 77002            | NA         | FALSE   |
| Ensemble / HCC Southbound                         | 1/1/2004        | 3604 Main St., Houston, TX 77002            | NA         | FALSE   |
| Wheeler                                           | 1/1/2004        | 4590 Main St., Houston, TX 77002            | NA         | FALSE   |
| Museum District Northbound                        | 1/1/2004        | 5640 San Jacinto St, Houston, TX 77004      | NA         | FALSE   |
| Museum District Southbound                        | 1/1/2004        | 5660 Fannin St., Houston, TX 77004          | NA         | FALSE   |
| Hermann Park / Rice U                             | 1/1/2004        | 6050 Fannin St., Houston, TX 77030          | NA         | FALSE   |
| Memorial Hermann Hospital /Houston Zoo Northbound | 1/1/2004        | 6413 Fannin St., Houston, TX 77030          | NA         | FALSE   |
| Memorial Hermann Hospital /Houston Zoo Southbound | 1/1/2004        | 6407 Fannin St., Houston, TX 77030          | NA         | FALSE   |
| Dryden/TMC Northbound                             | 1/1/2004        | 6607 Fannin St., Houston, TX 77021          | NA         | FALSE   |
| Dryden/TMC Southbound                             | 1/1/2004        | 6614 Fannin St., Houston, TX 77030          | NA         | FALSE   |
| TMC Transit Center                                | 1/1/2004        | 5640 San Jacinto St., Houston, TX 77004Will | NA         | FALSE   |
| Smith Lands                                       | 1/1/2004        | 7834 Greenbriar Drive, Houston, TX 77054    | NA         | FALSE   |
| Stadium Park / Astrodome                          | 1/1/2004        | 8168 Fannin St., Houston, TX 77054          | NA         | FALSE   |
| Fannin South                                      | 1/1/2004        | 1604 West Bellfort Ave., Houston, TX 77054  | NA         | TRUE    |

``` r
library('terra')
```

    Warning: package 'terra' was built under R version 4.3.3

    terra 1.7.78


    Attaching package: 'terra'

    The following object is masked from 'package:knitr':

        spin

``` r
library('maptiles')
```

    Warning: package 'maptiles' was built under R version 4.3.3

``` r
library('tidyverse')
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
    ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
    ✔ purrr     1.0.2     

    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ tidyr::extract() masks terra::extract()
    ✖ dplyr::filter()  masks stats::filter()
    ✖ dplyr::lag()     masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library('ggmap')
```

    Warning: package 'ggmap' was built under R version 4.3.3

    ℹ Google's Terms of Service: <https://mapsplatform.google.com>
      Stadia Maps' Terms of Service: <https://stadiamaps.com/terms-of-service/>
      OpenStreetMap's Tile Usage Policy: <https://operations.osmfoundation.org/policies/tiles/>
    ℹ Please cite ggmap if you use it! Use `citation("ggmap")` for details.

    Attaching package: 'ggmap'


    The following object is masked from 'package:terra':

        inset

``` r
x <- vect('bg_x_vect.shp')
buff_sta <- vect('buff_sta.shp')
sta_pts <- vect('sta_pts.shp')
pow_pla_pts <- vect('pow_pla_pts.shp')
tsp <- vect('tsp.shp')

extent <- buffer(x, width = 10000)
bg <- get_tiles(ext(extent))



plot(bg)
points(sta_pts)
points(pow_pla_pts, col = 'blue')
lines(buff_sta, col = 'red')
lines(tsp, col = "yellow", lwd = 2)
```

![](README_files/figure-commonmark/unnamed-chunk-3-1.png)
