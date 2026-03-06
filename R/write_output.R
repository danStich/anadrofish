#' @title Write simulation results
#'
#' @description Internal function used to assemble per-year output rows
#' into a single data.frame.
#'
#' For internal use in \code{\link{sim_pop}}. Not intended
#' to be called directly.
#'
#' @param rows A list of named lists, one per simulation year, as returned
#'   by \code{make_output_row}.
#'
#' @param age_structured_output Logical; if TRUE, pop and spawners are
#'   returned as age-structured columns.
#'
#' @param output_years Character; if "last", only the final year is returned.
#'
#' @return A data.frame of simulation results.
#'
#' @keywords Internal
#'
#' @export
#'
write_output <- function(rows, age_structured_output, output_years) {
  # -- Pop and spawners: expand to matrices, pad to 13 cols --
  pop_mat <- do.call(rbind, lapply(rows, function(r) unlist(r$pop)))
  if (ncol(pop_mat) < 13) {
    pop_mat <- cbind(pop_mat, matrix(0, nrow = nrow(pop_mat),
                                     ncol = 13 - ncol(pop_mat)))
  }
  colnames(pop_mat) <- paste0("pop_", seq_len(ncol(pop_mat)))
  pop_mat <- round(pop_mat)
  pop_mat[is.na(pop_mat)] <- 0

  spawners_mat <- do.call(rbind, lapply(rows, function(r) unlist(r$spawners)))
  if (ncol(spawners_mat) < 13) {
    spawners_mat <- cbind(spawners_mat, matrix(0, nrow = nrow(spawners_mat),
                                               ncol = 13 - ncol(spawners_mat)))
  }
  colnames(spawners_mat) <- paste0("spawners_", seq_len(ncol(spawners_mat)))
  spawners_mat <- round(spawners_mat)
  spawners_mat[is.na(spawners_mat)] <- 0

  # -- Scalar columns: build with atomic vectors --
  scalar_names <- setdiff(names(rows[[1]]), c("pop", "spawners"))
  scalars <- data.frame(
    lapply(scalar_names, function(nm) sapply(rows, function(r) r[[nm]])),
    stringsAsFactors = FALSE
  )
  names(scalars) <- scalar_names

  # -- Combine --
  if (age_structured_output) {
    out <- cbind(scalars, as.data.frame(spawners_mat), as.data.frame(pop_mat))
  } else {
    out <- cbind(scalars,
                 spawners = rowSums(spawners_mat),
                 pop = rowSums(pop_mat))
  }

  if (output_years == "last") out[nrow(out), , drop = FALSE] else out
}
