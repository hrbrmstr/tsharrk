#' Read in a JSON file created with [pcap_to_json()]
#'
#' @param json path to JSON output from [pcap_to_json()]. [path.expand()] will be
#'        called on this value.
#' @return `list` classed as `tshark_json` for better `print`ing.
#' @export
ts_read_json <- function(json) {

  json <- path.expand(json[1])
  if (!file.exists(json)) {
    stop(sprintf("Cannont locate %s", json), call.=FALSE)
  }

  RcppSimdJson::fload(
    json = json,
    empty_array = list(),
    empty_object = list(),
    single_null = list()
  ) -> res

  class(res) <- c("tshark_json", "list")

  invisible(res)

}

#' @rdname ts_read_json
#' @export
print.tshark_json <- function(x, ...) {

  info <- sprintf("Capture: %s", x$`_index`[1])
  cat(info, "\n", strrep("─", nchar(info)), "\n", sep="")

  lapply(x$`_source`, function(.x) names(.x$layers)) %>%
    sapply(paste0, collapse = " ── ") -> frames

  cat(
    paste(
      sprintf("%s.", stri_pad_left(
        str = 1:length(frames),
        width = nchar(as.character(length(frames))),
        pad = " "
      )),
      frames, sep = " "
    ),
    sep = "\n"
  )

}

