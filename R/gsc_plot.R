#' @title Make upset plot for given genesets
#'
#' @description Plot upset diagram for overlapping genes among given gene-sets.
#'
#' @param ... GeneSet or GeneSetCollection
#'
#' @return upset plot object
#' @export
#'
#' @examples
#' gsc_plot(mastR::msigdb_gobp_nk[1:3])
gsc_plot <- function(...) {
  ## input must be GeneSet or GeneSetCollection
  if(!all(sapply(list(...), class) %in% c("GeneSet", "GeneSetCollection")))
    stop("Only accept GeneSet or GeneSetCollection as input")

  gsc <- GSEABase::GeneSetCollection(c(...))

  if(length(gsc) > 1) {
    UpSetR::upset(UpSetR::fromList(gsc |> GSEABase::geneIds()),
                  nsets = length(gsc))
  }else stop("Only one gene-set is provided!")
}