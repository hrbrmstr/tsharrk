#' Convert an entire PCAP file to JSON
#'
#' @param pcap path to PCAP file ([path.expand()] will be called on this value)
#' @param json path (including filename) to the location where you want the JSON
#'        file stored ([path.expand()] will be called on this value)
#' @param protos character vector of protocols to include. (default is all)
#' @param include_child_nodes if `protos` is specified, this logical parameter
#'        (default `FALSE`) controls whether child nodes are included.
#' @return (expanded) path to `json` (invisibly)
#' @export
#' @examples
#' tryCatch(
#'   pcap_to_json(system.file("pcap", "http.pcap", package = "tsharrk"), tempfile()),
#'   error = function(e) message("No tshark")
#' )
pcap_to_json <- function(pcap, json, protos = c(), include_child_nodes = FALSE) {

  pcap <- path.expand(pcap[1])

  if (!file.exists(pcap)) {
    stop(sprintf("Cannont locate %s", pcap), call.=FALSE)
  }

  json <- path.expand(json[1])
  if (!dir.exists(dirname(json))) {
    stop(sprintf("Directory %s does not exist", dirname(json)), call.=FALSE)
  }

  errf <- tempfile()
  on.exit(unlink(errf))

  protos <- unique(trimws(tolower(as.character(protos))))

  if (length(protos)) {
    j <- if (include_child_nodes) "-J" else "-j"
    protos <- c(j, sprintf("'%s'", paste0(protos, collapse = " ")))
  }

  args <- c("-T", "json", protos, "-r", pcap)

  # cat(find_tshark(), args, "\n", sep=" ")

  system2(
    command = find_tshark(),
    args = args,
    stderr = errf,
    stdout = json
  ) -> res

  if (res != 0) {
    stop(
      sprintf("Error creating JSON from PCAP. See %s for more information.", errf),
      call.=FALSE
    )
  }

  invisible(json)

}