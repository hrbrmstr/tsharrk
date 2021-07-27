#' Tools to Make Analyses Using 'tshark' Easier
#'
#' The 'tshark' (<https://www.wireshark.org/docs/man-pages/tshark.html>)
#' command line utility comes with Wireshark and is a is useful when performing
#' analyses on packet captures (PCAPs). Tools are provided to make it a bit easier
#' to work with 'tshark' to perform analyses with R.
#'
#' @md
#' @name tsharrk
#' @keywords internal
#' @author Bob Rudis (bob@@rud.is)
#' @import arrow
#' @import RcppSimdJson
#' @import stringi
#' @importFrom utils browseURL help read.csv tail
#' @importFrom tools file_path_sans_ext file_ext
"_PACKAGE"
