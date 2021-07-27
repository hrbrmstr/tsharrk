
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
-   `pcap_to_json`: Convert an entire PCAP file to JSON
-   `ts_read_json`: Read in a JSON file created with pcap_to_json()
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
| R    |      10 | 0.38 | 172 | 0.40 |          56 | 0.33 |     102 | 0.37 |
| YAML |       2 | 0.08 |  27 | 0.06 |           6 | 0.04 |       2 | 0.01 |
| Rmd  |       1 | 0.04 |  18 | 0.04 |          22 | 0.13 |      34 | 0.12 |
| SUM  |      13 | 0.50 | 217 | 0.50 |          84 | 0.50 |     138 | 0.50 |

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

``` r
tf <- tempfile()
pcap_to_json(system.file("pcap", "http.pcap", package = "tsharrk"), json = tf)
## /opt/homebrew/bin/tshark -T json -r /Library/Frameworks/R.framework/Versions/4.1-arm64/Resources/library/tsharrk/pcap/http.pcap

http_cap <- ts_read_json(tf)

http_cap
## Capture: packets-2004-05-13
## ───────────────────────────
##  1. frame ── eth ── ip ── tcp
##  2. frame ── eth ── ip ── tcp
##  3. frame ── eth ── ip ── tcp
##  4. frame ── eth ── ip ── tcp ── http
##  5. frame ── eth ── ip ── tcp
##  6. frame ── eth ── ip ── tcp
##  7. frame ── eth ── ip ── tcp
##  8. frame ── eth ── ip ── tcp
##  9. frame ── eth ── ip ── tcp
## 10. frame ── eth ── ip ── tcp
## 11. frame ── eth ── ip ── tcp
## 12. frame ── eth ── ip ── tcp
## 13. frame ── eth ── ip ── udp ── dns
## 14. frame ── eth ── ip ── tcp
## 15. frame ── eth ── ip ── tcp
## 16. frame ── eth ── ip ── tcp
## 17. frame ── eth ── ip ── udp ── dns
## 18. frame ── eth ── ip ── tcp ── http
## 19. frame ── eth ── ip ── tcp
## 20. frame ── eth ── ip ── tcp
## 21. frame ── eth ── ip ── tcp
## 22. frame ── eth ── ip ── tcp
## 23. frame ── eth ── ip ── tcp
## 24. frame ── eth ── ip ── tcp
## 25. frame ── eth ── ip ── tcp
## 26. frame ── eth ── ip ── tcp
## 27. frame ── eth ── ip ── tcp ── tcp.segments ── http ── data-text-lines
## 28. frame ── eth ── ip ── tcp
## 29. frame ── eth ── ip ── tcp
## 30. frame ── eth ── ip ── tcp
## 31. frame ── eth ── ip ── tcp
## 32. frame ── eth ── ip ── tcp
## 33. frame ── eth ── ip ── tcp
## 34. frame ── eth ── ip ── tcp
## 35. frame ── eth ── ip ── tcp
## 36. frame ── eth ── ip ── tcp
## 37. frame ── eth ── ip ── tcp
## 38. frame ── eth ── ip ── tcp ── tcp.segments ── http ── xml
## 39. frame ── eth ── ip ── tcp
## 40. frame ── eth ── ip ── tcp
## 41. frame ── eth ── ip ── tcp
## 42. frame ── eth ── ip ── tcp
## 43. frame ── eth ── ip ── tcp

unlink(tf)
```

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
