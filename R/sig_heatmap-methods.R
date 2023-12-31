#' @include plot.R
#' @import ggplot2 patchwork
NULL

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "matrix",
    sigs = "character",
    group_col = "vector",
    markers = "missing"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           ...) {
    scale <- match.arg(scale)
    stopifnot(is.character(gene_id), is.logical(ranks_plot))

    p <- heatmap_init(
      expr = data,
      sigs = list(Sig = sigs),
      by = factor(group_col),
      scale = scale,
      gene_id = gene_id,
      ranks_plot = ranks_plot,
      ...
    )

    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "matrix",
    sigs = "character",
    group_col = "vector",
    markers = "vector"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           ...) {
    scale <- match.arg(scale)
    stopifnot(is.character(gene_id), is.logical(ranks_plot))

    ## build sigs
    sigs <- list(Original = setdiff(markers, sigs), Screen_Sig = sigs)

    p1 <- heatmap_init(
      expr = data,
      sigs = sigs,
      by = factor(group_col),
      scale = scale,
      gene_id = gene_id,
      ranks_plot = ranks_plot,
      cluster_column_slices = FALSE,
      cluster_row_slices = FALSE,
      name = "expr_orig",
      column_title = "Expression of Original Markers",
      ...
    )
    p2 <- heatmap_init(
      expr = data,
      sigs = sigs["Screen_Sig"],
      by = factor(group_col),
      scale = scale,
      gene_id = gene_id,
      ranks_plot = ranks_plot,
      cluster_column_slices = FALSE,
      cluster_row_slices = FALSE,
      name = "expr_scr",
      column_title = "Expression of Screened Signature",
      ...
    )
    slot(p2, "top_annotation") <- slot(p1, "top_annotation")
    ## convert to ggplot
    p1 <- patchwork::wrap_elements(grid::grid.grabExpr(ComplexHeatmap::draw(p1)))
    p2 <- patchwork::wrap_elements(grid::grid.grabExpr(ComplexHeatmap::draw(p2)))

    p <- patchwork::wrap_plots(p1, p2)
    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "matrix",
    sigs = "list",
    group_col = "vector",
    markers = "missing"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           ...) {
    scale <- match.arg(scale)
    stopifnot(is.character(gene_id), is.logical(ranks_plot))

    p <- heatmap_init(
      expr = data,
      sigs = sigs,
      by = factor(group_col),
      scale = scale,
      gene_id = gene_id,
      ranks_plot = ranks_plot,
      ...
    )

    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "Matrix",
    group_col = "vector"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           ...) {
    stopifnot(
      is.character(scale),
      is.character(gene_id), is.logical(ranks_plot)
    )

    if (missing(markers)) {
      p <- sig_heatmap(
        data = as.matrix(data), sigs = sigs,
        group_col = group_col,
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    } else {
      p <- sig_heatmap(
        data = as.matrix(data), sigs = sigs,
        group_col = group_col, markers = markers,
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    }

    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "data.frame",
    group_col = "vector"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           ...) {
    if (missing(markers)) {
      p <- sig_heatmap(
        data = as.matrix(data), sigs = sigs,
        group_col = group_col,
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    } else {
      p <- sig_heatmap(
        data = as.matrix(data), sigs = sigs,
        group_col = group_col, markers = markers,
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    }

    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "DGEList",
    group_col = "character"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           slot = "counts",
           ...) {
    if (missing(markers)) {
      p <- sig_heatmap(
        data = data[[slot]], sigs = sigs,
        group_col = data$samples[[group_col]],
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    } else {
      p <- sig_heatmap(
        data = data[[slot]], sigs = sigs,
        group_col = data$samples[[group_col]],
        markers = markers,
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    }

    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "ExpressionSet",
    group_col = "character"
  ),
  function(data,
           sigs,
           group_col,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           ...) {
    if (missing(markers)) {
      p <- sig_heatmap(
        data = Biobase::exprs(data), sigs = sigs,
        group_col = data[[group_col]],
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    } else {
      p <- sig_heatmap(
        data = Biobase::exprs(data), sigs = sigs,
        group_col = data[[group_col]], markers = markers,
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    }

    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "Seurat",
    group_col = "character"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           slot = "counts",
           ...) {
    if (missing(markers)) {
      p <- sig_heatmap(
        data = SeuratObject::GetAssayData(data, slot = slot),
        sigs = sigs, group_col = slot(data, "meta.data")[[group_col]],
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    } else {
      p <- sig_heatmap(
        data = SeuratObject::GetAssayData(data, slot = slot),
        sigs = sigs, group_col = slot(data, "meta.data")[[group_col]],
        markers = markers,
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    }

    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "SummarizedExperiment",
    group_col = "character"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           slot = "counts",
           ...) {
    if (missing(markers)) {
      p <- sig_heatmap(
        data = SummarizedExperiment::assay(data, slot),
        sigs = sigs, group_col = SummarizedExperiment::colData(data)[[group_col]],
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    } else {
      p <- sig_heatmap(
        data = SummarizedExperiment::assay(data, slot),
        sigs = sigs, group_col = SummarizedExperiment::colData(data)[[group_col]],
        markers = markers,
        scale = scale, gene_id = gene_id,
        ranks_plot = ranks_plot, ...
      )
    }

    return(p)
  }
)

#' @rdname sig_heatmap
setMethod(
  "sig_heatmap", signature(
    data = "list",
    group_col = "character"
  ),
  function(data,
           sigs,
           group_col,
           markers,
           scale = "none",
           gene_id = "SYMBOL",
           ranks_plot = FALSE,
           slot = "counts",
           ...) {
    stopifnot(
      is.character(scale),
      is.character(gene_id), is.logical(ranks_plot)
    )

    if (length(group_col) == 1) {
      group_col <- rep(group_col, length(data))
    }
    if (length(slot) == 1) {
      slot <- rep(slot, length(data))
    }
    if (length(gene_id) == 1) {
      gene_id <- rep(gene_id, length(data))
    }

    p <- list()
    for (i in seq_along(data)) {
      if (missing(markers)) {
        p[[i]] <- sig_heatmap(
          data = data[[i]],
          sigs = sigs, group_col = group_col[[i]],
          scale = scale, gene_id = gene_id[i],
          slot = slot[i], ranks_plot = ranks_plot, ...
        )
      } else {
        p[[i]] <- sig_heatmap(
          data = data[[i]],
          sigs = sigs, group_col = group_col[[i]],
          markers = markers,
          scale = scale, gene_id = gene_id[i],
          slot = slot[i], ranks_plot = ranks_plot, ...
        )
      }

      if (!is.null(names(data))) {
        if (is.ggplot(p[[i]])) {
          p[[i]] <- p[[i]] + ggtitle(names(data)[i])
        } else {
          p[[i]] <- ComplexHeatmap::draw(p[[i]], column_title = names(data)[i])
          p[[i]] <- grid::grid.grabExpr(p[[i]])
          p[[i]] <- patchwork::wrap_elements(p[[i]])
        }
      } else {
        if (is.ggplot(p[[i]])) {
          p[[i]] <- p[[i]] + ggtitle(i)
        } else {
          p[[i]] <- ComplexHeatmap::draw(p[[i]], column_title = i)
          p[[i]] <- grid::grid.grabExpr()
          p[[i]] <- patchwork::wrap_elements()
        }
      }
    }

    p <- patchwork::wrap_plots(p)
    return(p)
  }
)
