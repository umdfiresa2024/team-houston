# README


## Research Question

## Research Context

- Which city, which light rail

- Which timeline

- Hypothesis (light rail openings will cause decrease/increase) around
  stations

  - Reasoning on why you think your hypothesis is true

  - Confounding factors, explain what factors can also impact pollution
    near stations

- Include table of confounding factors

- Include table or map of stations

``` r
library("terra")
```

    terra 1.7.46

``` r
sta<-vect("buff_sta.shp")

plot(sta)
```

![](README_files/figure-commonmark/unnamed-chunk-1-1.png)
