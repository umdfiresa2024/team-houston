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

  ### Table of Power Plants

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

### Table of Red Line Stations

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

### Map of Houston

- Red Line Stations: Black Points

- Buffers: Red Circles

  - Radius: 125 km

- Highways: Yellow Lines

- Power Plants: Blue Points

``` r
#|warning: false
#|message: false

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

    Warning: package 'tidyverse' was built under R version 4.3.3

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

### Combining PM2.5 Data and Meteorological Data

``` r
t <- read.csv('stations_data.csv')
head(t)
```

      X     Station city_num date_parse   pm25.y Tair_f_tavg Wind_f_tavg
    1 1 UH-Downtown        1   20070606 18.09169    300.0631    3.152199
    2 2 UH-Downtown        1   20031018 18.92850    295.6240    4.312547
    3 3 UH-Downtown        1   20030731 28.39712    301.5336    1.857964
    4 4 UH-Downtown        1   20030924 32.69661    298.6476    2.772936
    5 5 UH-Downtown        1   20030419 16.35215    296.5158    5.005250
    6 6 UH-Downtown        1   20021021 13.58177    296.0952    3.418124
      Qair_f_tavg Swnet_tavg Lwnet_tavg Qle_tavg  Qh_tavg     Qg_tavg   Rainf_tavg
    1  0.01820959   175.8085  -58.87698 63.58242 52.06745  1.28607237 0.000000e+00
    2  0.01390711   153.7672  -48.85344 84.08550 19.23183  1.59069490 6.226079e-04
    3  0.02092853   196.6315  -52.28700 72.03625 65.13770  7.16767359 1.031377e-05
    4  0.01676618   131.1580  -30.78349 67.24549 33.07461  0.05478838 5.304586e-05
    5  0.01464971   153.5152  -41.79403 85.57352 24.12227  2.02892733 1.439977e-04
    6  0.01588336   118.1107  -43.18064 42.62752 33.30393 -1.00141191 2.303306e-06
          Qsb_tavg AvgSurfT_tavg SoilMoist_S_tavg SoilMoist_RZ_tavg
    1 7.922070e-10      301.0076         7.130842          362.2582
    2 0.000000e+00      295.7036         8.847394          369.9988
    3 0.000000e+00      303.7087         7.372685          368.4690
    4 5.936561e-10      299.4848         7.535685          364.8384
    5 1.130284e-09      296.7788         8.085110          371.8716
    6 1.478257e-09      296.8988         7.796390          393.4534
      SoilMoist_P_tavg    TVeg_tavg   ESoil_tavg ACond_tavg Rainf_f_tavg
    1         1675.651 4.960877e-06 2.081741e-05 0.02019928 0.000000e+00
    2         1651.855 1.833586e-06 2.590503e-05 0.02388821 6.226080e-04
    3         1653.718 6.568407e-06 2.118947e-05 0.01734417 1.031377e-05
    4         1654.721 2.892142e-06 1.795057e-05 0.01781925 5.304586e-05
    5         1711.885 2.385599e-06 2.548229e-05 0.02923577 1.439977e-04
    6         1751.740 1.677072e-06 1.317038e-05 0.02178558 2.303306e-06
      Psurf_f_tavg SWdown_f_tavg month       DOW holiday
    1     101444.0      198.9910     6 Wednesday   FALSE
    2     101826.2      172.8554    10  Saturday   FALSE
    3     101881.5      223.2050     7  Thursday   FALSE
    4     101372.7      148.3467     9 Wednesday   FALSE
    5     101194.8      174.4067     4  Saturday   FALSE
    6     101416.2      132.8056    10    Monday   FALSE

``` r
#kable(t)
```

### Linear Regression Model for PM2.5

``` r
m <- read.csv('regression_model.csv')
m
```

        X               term      estimate    std.error   statistic       p.value
    1   1        (Intercept) -1.728364e+04 4.335717e+03  -3.9863398  6.715645e-05
    2   2          MetroOpen -2.873664e-01 1.271390e-02 -22.6025339 8.824241e-113
    3   3       construction -1.112408e-01 9.764917e-03 -11.3918838  4.826359e-30
    4   4               TERP -1.783369e-01 6.382279e-03 -27.9425116 4.862843e-171
    5   5              NAAQS -5.425625e-02 8.232035e-03  -6.5908673  4.398115e-11
    6   6               temp  3.172098e-02 1.123585e-03  28.2319258 1.529887e-174
    7   7           lag_temp  2.389477e+02 5.976766e+01   3.9979432  6.394926e-05
    8   8         lag_temp_2 -1.237950e+00 3.088745e-01  -4.0079388  6.130321e-05
    9   9         lag_temp_3  2.847831e-03 7.092352e-04   4.0153548  5.940740e-05
    10 10         lag_temp_4 -2.454570e-06 6.105229e-07  -4.0204396  5.813977e-05
    11 11               wind -9.690739e-02 1.394700e-03 -69.4826127  0.000000e+00
    12 12           lag_wind -2.005594e-01 5.501304e-02  -3.6456702  2.668550e-04
    13 13         lag_wind_2  1.998077e-02 1.984693e-02   1.0067435  3.140609e-01
    14 14         lag_wind_3  2.782947e-03 2.977300e-03   0.9347216  3.499344e-01
    15 15         lag_wind_4 -4.065162e-04 1.577418e-04  -2.5770991  9.965010e-03
    16 16           humidity -1.386630e+01 1.266402e+00 -10.9493680  6.985198e-28
    17 17       lag_humidity -1.837564e+02 2.689862e+01  -6.8314417  8.462917e-12
    18 18     lag_humidity_2  2.709702e+04 3.433238e+03   7.8925554  2.995706e-15
    19 19     lag_humidity_3 -1.592338e+06 1.832090e+05  -8.6913780  3.642943e-18
    20 20     lag_humidity_4  3.156415e+07 3.480072e+06   9.0699711  1.215016e-19
    21 21 as.factor(month)02  1.025522e-02 6.875174e-03   1.4916302  1.357998e-01
    22 22 as.factor(month)03 -2.626650e-02 7.619032e-03  -3.4474852  5.661055e-04
    23 23 as.factor(month)04 -2.387214e-02 9.305570e-03  -2.5653602  1.030858e-02
    24 24 as.factor(month)05 -9.520868e-03 1.123398e-02  -0.8475061  3.967155e-01
    25 25 as.factor(month)06 -2.000203e-01 1.296543e-02 -15.4272015  1.270658e-53
    26 26 as.factor(month)07 -1.731716e-01 1.360831e-02 -12.7254319  4.617874e-37
    27 27 as.factor(month)08 -2.066385e-01 1.389550e-02 -14.8708986  5.887471e-50
    28 28 as.factor(month)09 -1.512243e-01 1.227203e-02 -12.3226829  7.324430e-35
    29 29 as.factor(month)10 -1.844891e-01 9.908933e-03 -18.6184658  3.246327e-77
    30 30 as.factor(month)11 -8.425188e-02 7.633989e-03 -11.0364160  2.665689e-28
    31 31 as.factor(month)12 -5.381416e-02 6.683598e-03  -8.0516749  8.271644e-16
    32 32    as.factor(dow)2  8.600251e-02 5.102138e-03  16.8561723  1.200155e-63
    33 33    as.factor(dow)3  1.052052e-01 5.038276e-03  20.8811970  1.390314e-96
    34 34    as.factor(dow)4  1.023084e-01 5.047436e-03  20.2693896  3.942050e-91
    35 35    as.factor(dow)5  9.726118e-02 5.044109e-03  19.2821347  1.141142e-82
    36 36    as.factor(dow)6  1.244446e-01 5.041952e-03  24.6818258 4.991926e-134
    37 37    as.factor(dow)7  5.511228e-02 5.044618e-03  10.9249648  9.138635e-28
    38 38        holidayTRUE -1.018700e-01 7.819250e-03 -13.0281021  9.226716e-39
    39 39                  t -1.966327e-05 4.601863e-05  -0.4272894  6.691697e-01
    40 40                 t2  7.261783e-07 5.046115e-08  14.3908397  6.709424e-47
    41 41                 t3 -3.896620e-10 2.133349e-11 -18.2652753  2.173276e-74
    42 42                 t4  5.718178e-14 3.023975e-15  18.9094753  1.390127e-79
