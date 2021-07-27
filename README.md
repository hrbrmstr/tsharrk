
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-100%25-lightgrey.svg)
[![R-CMD-check](https://github.com/hrbrmstr/tsharrk/workflows/R-CMD-check/badge.svg)](https://github.com/hrbrmstr/tsharrk/actions?query=workflow%3AR-CMD-check)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/tsharrk.svg?branch=master)](https://travis-ci.org/hrbrmstr/tsharrk)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/tsharrk/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/tsharrk)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.6.0-blue.svg)
![License](https://img.shields.io/badge/License-AGPL-blue.svg)

# tsharrk

Tools to Make Analyses Using ‘tshark’ Easier

## Description

The ‘tshark’ (<https://www.wireshark.org/docs/man-pages/tshark.html>)
command line utility comes with Wireshark and is a is useful when
performing analyses on packet captures (PCAPs). Tools are provided to
make it a bit easier to work with ‘tshark’ to perform analyses with R.

## What’s Inside The Tin

The following functions are implemented:

-   `find_tshark`: Find the tshark binary
-   `get_tshark`: Get tshark
-   `packet_summary`: Extract packet summary table (if any) from a PCAP
-   `tshark_exec`: Call the tshark binary with optional custom
    environment variables and options
-   `tshark_hosts`: Extract hostname/IP table (if any) from a PCAP

## Installation

``` r
remotes::install_git("https://git.rud.is/hrbrmstr/tsharrk.git")
# or
remotes::install_gitlab("hrbrmstr/tsharrk")
# or
remotes::install_github("hrbrmstr/tsharrk")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

## Usage

``` r
library(tsharrk)

# current version
packageVersion("tsharrk")
## [1] '0.1.0'
```

## tsharrk Metrics

| Lang | # Files |  (%) | LoC |  (%) | Blank lines |  (%) | # Lines |  (%) |
|:-----|--------:|-----:|----:|-----:|------------:|-----:|--------:|-----:|
| R    |       7 | 0.35 | 108 | 0.36 |          33 | 0.29 |      65 | 0.33 |
| YAML |       2 | 0.10 |  27 | 0.09 |           6 | 0.05 |       2 | 0.01 |
| Rmd  |       1 | 0.05 |  13 | 0.04 |          18 | 0.16 |      32 | 0.16 |
| SUM  |      10 | 0.50 | 148 | 0.50 |          57 | 0.50 |      99 | 0.50 |

clock Package Metrics for tsharrk

``` r
tshark_hosts(system.file("pcap", "http.pcap", package = "tsharrk"))
##               ip                     host
## 1 216.239.59.104 pagead.google.akadns.net
## 2  216.239.59.99 pagead.google.akadns.net
```

``` r
library(tibble)

as_tibble(
  packet_summary(system.file("pcap", "http.pcap", package = "tsharrk"))
)
## # A tibble: 43 x 7
##    packet_num    ts src          dst          proto length info                                                         
##         <dbl> <dbl> <chr>        <chr>        <chr>  <dbl> <chr>                                                        
##  1          1 0     145.254.160… 65.208.228.… TCP       62 "3372 → 80 [SYN] Seq=0 Win=8760 Len=0 MSS=1460 SACK_PERM=1"  
##  2          2 0.911 65.208.228.… 145.254.160… TCP       62 "80 → 3372 [SYN, ACK] Seq=0 Ack=1 Win=5840 Len=0 MSS=1380 SA…
##  3          3 0.911 145.254.160… 65.208.228.… TCP       54 "3372 → 80 [ACK] Seq=1 Ack=1 Win=9660 Len=0"                 
##  4          4 0.911 145.254.160… 65.208.228.… HTTP     533 "GET /download.html HTTP/1.1 "                               
##  5          5 1.47  65.208.228.… 145.254.160… TCP       54 "80 → 3372 [ACK] Seq=1 Ack=480 Win=6432 Len=0"               
##  6          6 1.68  65.208.228.… 145.254.160… TCP     1434 "HTTP/1.1 200 OK  [TCP segment of a reassembled PDU]"        
##  7          7 1.81  145.254.160… 65.208.228.… TCP       54 "3372 → 80 [ACK] Seq=480 Ack=1381 Win=9660 Len=0"            
##  8          8 1.81  65.208.228.… 145.254.160… TCP     1434 "80 → 3372 [ACK] Seq=1381 Ack=480 Win=6432 Len=1380 [TCP seg…
##  9          9 2.01  145.254.160… 65.208.228.… TCP       54 "3372 → 80 [ACK] Seq=480 Ack=2761 Win=9660 Len=0"            
## 10         10 2.44  65.208.228.… 145.254.160… TCP     1434 "80 → 3372 [ACK] Seq=2761 Ack=480 Win=6432 Len=1380 [TCP seg…
## # … with 33 more rows
```

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
