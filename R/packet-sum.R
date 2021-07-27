#' Extract packet summary table (if any) from a PCAP
#'
#' @param pcap path to PCAP file ([path.expand()] will be called on this value)
#' @return data frame
#' @export
#' @examples
#' packet_summary(system.file("pcap", "http.pcap", package = "tsharrk"))
packet_summary <- function(pcap) {

  pcap <- path.expand(pcap[1])

  if (!file.exists(pcap)) {
    stop(sprintf("Cannont locate %s", pcap), call.=FALSE)
  }

  errf <- tempfile()
  on.exit(unlink(errf))

  outf <- tempfile()
  on.exit(unlink(outf))

  system2(
    command = find_tshark(),
    args = c("-T", "tabs", "-r", pcap),
    stderr = errf,
    stdout = outf
  ) -> res

  if (res != 0) {
    stop("Error retrieving packet summary from PCAP.", call.=FALSE)
  }

  if (file.size(outf) == 0) {
    data.frame(
      packet_num = double(0),
      ts = double(0),
      src = character(0),
      dst = character(0),
      proto = character(0),
      length = double(0),
      info = character(0)
    )
  } else {

    read.csv(
      file = outf,
      sep = "\t",
      header = FALSE,
      col.names = c("packet_num", "ts", "src", "junk", "dst", "proto", "length", "info"),
      colClasses = c("double", "double", "character", "character", "character", "character", "double", "character")
    ) -> out

    out$junk <- NULL

    out

  }

}