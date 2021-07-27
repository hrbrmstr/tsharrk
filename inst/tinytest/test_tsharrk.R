library(tsharrk)

loc <- tryCatch(
  find_tshark(),
  error = function(e) message("No tshark")
)

tryCatch(
  tshark_hosts(system.file("pcap", "http.pcap", package = "tsharrk")),
  error = function(e) message("No tshark")
)

tryCatch(
  packet_summary(system.file("pcap", "http.pcap", package = "tsharrk")),
  error = function(e) message("No tshark")
)