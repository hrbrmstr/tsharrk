#' Extract hostname/IP table (if any) from a PCAP
#'
#' @param pcap path to PCAP file ([path.expand()] will be called on this value)
#' @return data frame
#' @export
#' @examples
#' tryCatch(
#'   tshark_hosts(system.file("pcap", "http.pcap", package = "tsharrk")),
#'   error = function(e) message("No tshark")
#' )
tshark_hosts <- function(pcap) {

  pcap <- path.expand(pcap[1])

  if (!file.exists(pcap)) {
    stop(sprintf("Cannont locate %s", pcap), call.=FALSE)
  }

  tshark_exec(
    args = c("-q", "-z", "hosts", "-r", pcap)
  ) -> res

  if (res$status != 0) {
    stop("Error retrieving hosts from PCAP.", call.=FALSE)
  }

  host_table_raw <- tail(res$stdout, -4)

  if (length(host_table_raw) == 0) {
    data.frame(
      ip = character(0),
      host = character(0)
    )
  } else {
    read.csv(
      text = paste0(host_table_raw, collapse = "\n"),
      sep = "\t",
      header = FALSE,
      col.names = c("ip", "host"),
      colClasses = c("character", "character")
    )
  }


}