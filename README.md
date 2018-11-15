
<!-- README.md is generated from README.Rmd. Please edit that file -->
ddp\_cli\_tools
===============

Linux-based command line tools to process economic data published by Federal Reserve.

Installation
------------

``` bash
git clone ...
```

Examples
--------

Extract metadata to a csv

``` bash
cat H15_data.xml | ./metadata.awk > H15_metadata.csv
```

``` bash
head H15_metadata.csv
#> maturity,unit_mult,unit,currency,series_name,instrument,freq,tif
#> O,1,Percent:_Per_Year,NA,RIFSPFF_N.B,FF,9,business
#> O,1,Percent:_Per_Year,NA,RIFSPFF_N.D,FF,8,daily
#> O,1,Percent:_Per_Year,NA,RIFSPFF_N.WW,FF,19,wwednesday
#> O,1,Percent:_Per_Year,NA,RIFSPFF_N.BWAW,FF,67,bw1wednesday
#> O,1,Percent:_Per_Year,NA,RIFSPFF_N.M,FF,129,monthly
#> O,1,Percent:_Per_Year,NA,RIFSPFF_N.A,FF,203,annual
#> M1,1,Percent,NA,RIFSPPNAAD30_N.B,NFCP,9,business
#> M1,1,Percent,NA,RIFSPPNAAD30_N.WF,NFCP,21,wfriday
#> M1,1,Percent,NA,RIFSPPNAAD30_N.M,NFCP,129,monthly
```

Extract data to a csv

``` bash
cat H15_data.xml | ./data.awk > H15_data.csv
```

``` bash
head H15_data.csv
#> obs_value,series_name,obs_status,time_period
#> 1.13,RIFSPFF_N.B,A,1954-07-01
#> 1.25,RIFSPFF_N.B,A,1954-07-02
#> 0.88,RIFSPFF_N.B,A,1954-07-05
#> 0.25,RIFSPFF_N.B,A,1954-07-06
#> 1.00,RIFSPFF_N.B,A,1954-07-07
#> 1.25,RIFSPFF_N.B,A,1954-07-08
#> 1.25,RIFSPFF_N.B,A,1954-07-09
#> 1.25,RIFSPFF_N.B,A,1954-07-12
#> 1.13,RIFSPFF_N.B,A,1954-07-13
```

Change the delimiter

``` bash
cat H15_data.xml | ./data.awk -v sep='\t' > H15_data.tsv
```

``` bash
head H15_data.tsv
#> obs_value    series_name obs_status  time_period
#> 1.13 RIFSPFF_N.B A   1954-07-01
#> 1.25 RIFSPFF_N.B A   1954-07-02
#> 0.88 RIFSPFF_N.B A   1954-07-05
#> 0.25 RIFSPFF_N.B A   1954-07-06
#> 1.00 RIFSPFF_N.B A   1954-07-07
#> 1.25 RIFSPFF_N.B A   1954-07-08
#> 1.25 RIFSPFF_N.B A   1954-07-09
#> 1.25 RIFSPFF_N.B A   1954-07-12
#> 1.13 RIFSPFF_N.B A   1954-07-13
```
