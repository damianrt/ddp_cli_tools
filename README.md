
<!-- README.md is generated from README.Rmd. Please edit that file -->
ddp\_cli\_tools
===============

Linux-based command line tools to process economic data published by Federal Reserve.

Installation
------------

``` bash
git clone https://github.com/damianrt/ddp_cli_tools
```

Examples
--------

Download a zip file

``` bash
wget "https://www.federalreserve.gov/datadownload/Output.aspx?rel=H15&filetype=zip" -q -O FRB_H15.zip
```

Extract the XML data file

``` bash
unzip -l FRB_H15.zip
#> Archive:  FRB_H15.zip
#>   Length      Date    Time    Name
#> ---------  ---------- -----   ----
#>  58293357  2018-11-14 11:59   H15_data.xml
#>     96648  2018-11-14 11:59   H15_struct.xml
#>    139870  2018-11-14 11:59   frb_common.xsd
#>     10237  2018-11-14 11:59   H15_discontinued.xsd
#>     10219  2018-11-14 11:59   H15_H15.xsd
#> ---------                     -------
#>  58550331                     5 files
```

``` bash
unzip -u FRB_H15.zip H15_data.xml
#> Archive:  FRB_H15.zip
#>   inflating: H15_data.xml
```

Extract data

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

Extract metadata

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

Change the column delimiter to a tab

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
