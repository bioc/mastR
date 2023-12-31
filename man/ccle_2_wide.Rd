% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/remove_bg_exp-methods.R
\name{ccle_2_wide}
\alias{ccle_2_wide}
\title{Convert CCLE data from long data to wide data.}
\usage{
ccle_2_wide(ccle)
}
\arguments{
\item{ccle}{CCLE data downloaded by \code{\link[depmap:TPM]{depmap::depmap_TPM()}}}
}
\value{
a matrix
}
\description{
Convert CCLE data downloaded by \code{\link[depmap:TPM]{depmap::depmap_TPM()}} from long
data into wide matrix, with row names are gene names and column names are
depmap IDs.
}
\examples{
data("ccle_crc_5")
ccle <- data.frame(
  gene_name = rownames(ccle_crc_5),
  ccle_crc_5$counts
) |>
  tidyr::pivot_longer(
    -gene_name,
    names_to = "depmap_id",
    values_to = "rna_expression"
  )
ccle_wide <- ccle_2_wide(ccle)
}
