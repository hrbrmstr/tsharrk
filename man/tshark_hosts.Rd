% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tshark-hosts.R
\name{tshark_hosts}
\alias{tshark_hosts}
\title{Extract hostname/IP table (if any) from a PCAP}
\usage{
tshark_hosts(pcap)
}
\arguments{
\item{pcap}{path to PCAP file (\code{\link[=path.expand]{path.expand()}} will be called on this value)}
}
\value{
data frame
}
\description{
Extract hostname/IP table (if any) from a PCAP
}
\examples{
tryCatch(
  tshark_hosts(system.file("pcap", "http.pcap", package = "tsharrk")),
  error = function(e) message("No tshark")
)
}
