#' Find the `tshark` binary
#'
#' Use the environment variable `TSHARK_PATH` or specify the directory in
#' the call to this function.
#'
#' @param path hint to where to look for the `tshark` binary
#' @export
#' @return length 1 character vector of the path to the `tshark` binary or `""`
#' @examples
#' loc <- tryCatch(
#'   find_tshark(),
#'   error = function(e) message("No tshark")
#' )
find_tshark <- function(path = Sys.getenv("TSHARK_PATH", "")) {

  if (path != "") {
    Sys.setenv(
      PATH = paste0(c(path, Sys.getenv("PATH")), collapse = .Platform$path.sep)
    )
  }

  res <- Sys.which("tshark")

  if (res == "") {
    stop("Cannot locate tshark binary.", call.=FALSE)
  }

  unname(res)

}

set_names <- function (object = nm, nm) {
  names(object) <- nm
  object
}