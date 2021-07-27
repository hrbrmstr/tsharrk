#' Get tshark
#'
#' Opens the default browser to the place where you can get tshark
#'
#' @export
#' @examples
#' if (interactive()) get_tshark()
get_tshark <- function() {
  utils::browseURL("https://tshark.dev/setup/install/")
}