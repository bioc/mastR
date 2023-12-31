#' @include plot.R
#' @import ggplot2
NULL

#' @rdname sig_boxplot
setMethod(
  "sig_boxplot", signature(
    data = "matrix",
    sigs = "vector",
    group_col = "vector",
    target_group = "character"
  ),
  function(data,
           sigs,
           group_col,
           target_group,
           type = c("score", "expression"),
           method = "t.test",
           gene_id = "SYMBOL") {
    stopifnot(is.character(method), is.character(gene_id))
    type <- match.arg(type)

    if (type == "score") {
      ## plot scores of signature
      ## calculate scores
      scores <- singscore_init(
        expr = data, sigs = sigs, by = group_col,
        gene_id = gene_id
      )
      ## boxplot of scores
      p <- score_boxplot_init(
        scores = scores, by = group_col,
        target_group = target_group, method = method
      )
    } else {
      ## plot median expression of signature
      p <- exp_boxplot_init(
        expr = data, sigs = sigs,
        target_group = target_group,
        by = group_col,
        method = method,
        gene_id = gene_id
      )
    }

    return(p)
  }
)

#' @rdname sig_boxplot
setMethod(
  "sig_boxplot", signature(
    data = "Matrix",
    sigs = "vector",
    group_col = "vector",
    target_group = "character"
  ),
  function(data,
           sigs,
           group_col,
           target_group,
           type = c("score", "expression"),
           method = "t.test",
           gene_id = "SYMBOL") {
    stopifnot(is.character(method), is.character(gene_id))
    type <- match.arg(type)

    if (type == "score") {
      ## plot scores of signature
      ## calculate scores
      scores <- singscore_init(
        expr = as.matrix(data),
        sigs = sigs,
        by = group_col,
        gene_id = gene_id
      )
      ## boxplot of scores
      p <- score_boxplot_init(
        scores = scores, by = group_col,
        target_group = target_group, method = method
      )
    } else {
      ## plot median expression of signature
      p <- exp_boxplot_init(
        expr = data, sigs = sigs,
        target_group = target_group,
        by = group_col,
        method = method,
        gene_id = gene_id
      )
    }

    return(p)
  }
)

#' @rdname sig_boxplot
setMethod(
  "sig_boxplot", signature(
    data = "data.frame",
    sigs = "vector",
    group_col = "vector",
    target_group = "character"
  ),
  function(data,
           sigs,
           group_col,
           target_group,
           type = c("score", "expression"),
           method = "t.test",
           gene_id = "SYMBOL") {
    stopifnot(is.character(method), is.character(gene_id))
    type <- match.arg(type)

    p <- sig_boxplot(
      data = as.matrix(data),
      sigs = sigs,
      group_col = group_col,
      target_group = target_group,
      type = type,
      method = method,
      gene_id = gene_id
    )

    return(p)
  }
)

#' @rdname sig_boxplot
setMethod(
  "sig_boxplot", signature(
    data = "DGEList",
    sigs = "vector",
    group_col = "character",
    target_group = "character"
  ),
  function(data,
           sigs,
           group_col,
           target_group,
           type = c("score", "expression"),
           method = "t.test",
           slot = "counts",
           gene_id = "SYMBOL") {
    p <- sig_boxplot(
      data = data[[slot]],
      sigs = sigs,
      group_col = data$samples[[group_col]],
      target_group = target_group,
      type = type,
      method = method,
      gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname sig_boxplot
setMethod(
  "sig_boxplot", signature(
    data = "ExpressionSet",
    sigs = "vector",
    group_col = "character",
    target_group = "character"
  ),
  function(data,
           sigs,
           group_col,
           target_group,
           type = c("score", "expression"),
           method = "t.test",
           gene_id = "SYMBOL") {
    p <- sig_boxplot(
      data = Biobase::exprs(data),
      sigs = sigs,
      group_col = Biobase::pData(data)[[group_col]],
      target_group = target_group,
      type = type,
      method = method,
      gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname sig_boxplot
setMethod(
  "sig_boxplot", signature(
    data = "Seurat",
    sigs = "vector",
    group_col = "character",
    target_group = "character"
  ),
  function(data,
           sigs,
           group_col,
           target_group,
           type = c("score", "expression"),
           method = "t.test",
           slot = "counts",
           gene_id = "SYMBOL") {
    p <- sig_boxplot(
      data = SeuratObject::GetAssayData(data, slot = slot),
      sigs = sigs,
      group_col = slot(data, "meta.data")[[group_col]],
      target_group = target_group,
      type = type,
      method = method,
      gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname sig_boxplot
setMethod(
  "sig_boxplot", signature(
    data = "SummarizedExperiment",
    sigs = "vector",
    group_col = "character",
    target_group = "character"
  ),
  function(data,
           sigs,
           group_col,
           target_group,
           type = c("score", "expression"),
           method = "t.test",
           slot = "counts",
           gene_id = "SYMBOL") {
    p <- sig_boxplot(
      data = SummarizedExperiment::assay(data, slot),
      sigs = sigs,
      group_col = SummarizedExperiment::colData(data)[[group_col]],
      target_group = target_group,
      type = type,
      method = method,
      gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname sig_boxplot
setMethod(
  "sig_boxplot", signature(
    data = "list",
    sigs = "vector",
    group_col = "character",
    target_group = "character"
  ),
  function(data,
           sigs,
           group_col,
           target_group,
           type = c("score", "expression"),
           method = "t.test",
           slot = "counts",
           gene_id = "SYMBOL") {
    if (length(target_group) == 1) {
      target_group <- rep(target_group, length(data))
    }
    if (length(group_col) == 1) {
      group_col <- rep(group_col, length(data))
    }
    if (length(slot) == 1) {
      slot <- rep(slot, length(data))
    }
    if (length(gene_id) == 1) {
      gene_id <- rep(gene_id, length(data))
    }
    if (length(type) == 1) {
      type <- rep(type, length(data))
    }

    p <- list()
    for (i in seq_along(data)) {
      p[[i]] <- sig_boxplot(
        data = data[[i]],
        sigs = sigs,
        group_col = group_col[[i]],
        target_group = target_group[i],
        type = type[i],
        method = method,
        slot = slot[i],
        gene_id = gene_id[i]
      )
      if (!is.null(names(data))) {
        p[[i]] <- p[[i]] + ggplot2::labs(subtitle = names(data)[i]) +
          ggplot2::theme(plot.subtitle = element_text(hjust = 0.5))
      }
    }
    p <- patchwork::wrap_plots(p) +
      patchwork::plot_layout(guides = "collect")
    return(p)
  }
)
