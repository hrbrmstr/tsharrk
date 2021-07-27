#' Call the tshark binary with optional custom environment variables and options
#'
#' This is just a convenience wrapper around [system2()]. See [find_tshark()] for
#' information on helping this package find the tshark binary.
#'
#' @param tshark_bin specify a complete path or let [find_tshark()] do the dirty work.
#' @param args same as [system2()] `args`
#' @param env same as [system2()] `env`
#' @return `list` with `stderr`, `stdout`, and `status` (invisibly)
#' @export
tshark_exec <- function(tshark_bin = find_tshark(), args = c(), env = c()) {

  errf <- tempfile()
  on.exit(unlink(errf))

  outf <- tempfile()
  on.exit(unlink(outf))

  system2(
    command = tshark_bin,
    args = args,
    env = env,
    stderr = errf,
    stdout = outf
  ) -> res

  invisible(list(
    stderr = readLines(errf, warn = FALSE),
    stdout = readLines(outf, warn = FALSE),
    status = res
  ))

}