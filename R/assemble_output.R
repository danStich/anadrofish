#' @title Assemble simulation results
#'
#' @description Internal function used to assemble per-year output rows
#' into a single data.frame.
#'
#' For internal use in \code{\link{sim_pop}}. Not intended
#' to be called directly.
#'
#' @param rows A list of named lists, one per simulation year, as returned
#' by \code{make_output_row}.
#'
#' @param age_structured_output Logical; if TRUE, list-valued fields (e.g.
#' pop, spawners) provided in \code{make_row_output} are returned as
#' age-structured columns.
#'
#' @param output_years Character; if "last", only the final year is returned.
#'
#' @return A data.frame of simulation results.
#'
#' @keywords Internal
#'
#' @export
#'
assemble_output <- function(rows, age_structured_output, output_years) {
  all_names <- names(rows[[1]])
  list_names <- all_names[vapply(rows[[1]], is.list, logical(1))]
  scalar_names <- setdiff(all_names, list_names)

  # -- Scalar columns --
  scalars <- data.frame(
    lapply(scalar_names, function(nm) sapply(rows, function(r) r[[nm]])),
    stringsAsFactors = FALSE
  )
  names(scalars) <- scalar_names

  # -- List columns: expand each to a matrix, pad to 13 cols --
  list_dfs <- lapply(list_names, function(nm) {
    mat <- do.call(rbind, lapply(rows, function(r) unlist(r[[nm]])))
    if (ncol(mat) < 13) {
      mat <- cbind(mat, matrix(0, nrow = nrow(mat), ncol = 13 - ncol(mat)))
    }
    mat <- round(mat)
    mat[is.na(mat)] <- 0

    if (age_structured_output) {
      colnames(mat) <- paste0(nm, "_", seq_len(ncol(mat)))
      as.data.frame(mat)
    } else {
      out <- data.frame(rowSums(mat))
      names(out) <- nm
      out
    }
  })

  out <- do.call(cbind, c(list(scalars), list_dfs))

  if (output_years == "last") out[nrow(out), , drop = FALSE] else out
}
