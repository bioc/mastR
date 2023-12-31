#' @include plot.R
NULL

#' @rdname pca_matrix_plot
setMethod(
  "pca_matrix_plot", signature(
    data = "matrix"
  ),
  function(data,
           features = "all",
           group_by = NULL,
           scale = TRUE,
           n = 4,
           loading = FALSE,
           n_loadings = 10,
           gene_id = "SYMBOL") {
    p <- pca_matrix_plot_init(
      data = data, features = features,
      group_by = group_by,
      scale = scale, n = n, loading = loading,
      n_loadings = n_loadings, gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname pca_matrix_plot
setMethod(
  "pca_matrix_plot", signature(
    data = "Matrix"
  ),
  function(data,
           features = "all",
           group_by = NULL,
           scale = TRUE,
           n = 4,
           loading = FALSE,
           n_loadings = 10,
           gene_id = "SYMBOL") {
    p <- pca_matrix_plot_init(
      data = data, features = features,
      group_by = group_by,
      scale = scale, n = n, loading = loading,
      n_loadings = n_loadings, gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname pca_matrix_plot
setMethod(
  "pca_matrix_plot", signature(
    data = "data.frame"
  ),
  function(data,
           features = "all",
           group_by = NULL,
           scale = TRUE,
           n = 4,
           loading = FALSE,
           n_loadings = 10,
           gene_id = "SYMBOL") {
    p <- pca_matrix_plot_init(
      data = as.matrix(data), features = features,
      group_by = group_by,
      scale = scale, n = n, loading = loading,
      n_loadings = n_loadings, gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname pca_matrix_plot
setMethod(
  "pca_matrix_plot", signature(
    data = "ExpressionSet"
  ),
  function(data,
           features = "all",
           group_by = NULL,
           scale = TRUE,
           n = 4,
           loading = FALSE,
           n_loadings = 10,
           gene_id = "SYMBOL") {
    if (is.character(group_by)) {
      group_by <- data[[group_by]]
    }
    data <- Biobase::exprs(data)

    p <- pca_matrix_plot(
      data = data, features = features,
      group_by = group_by,
      scale = scale, n = n, loading = loading,
      n_loadings = n_loadings, gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname pca_matrix_plot
setMethod(
  "pca_matrix_plot", signature(
    data = "DGEList"
  ),
  function(data,
           features = "all",
           slot = "counts",
           group_by = NULL,
           scale = TRUE,
           n = 4,
           loading = FALSE,
           n_loadings = 10,
           gene_id = "SYMBOL") {
    if (is.character(group_by)) {
      group_by <- data$samples[[group_by]]
    }
    data <- data[[slot]]

    p <- pca_matrix_plot(
      data = data, features = features,
      group_by = group_by,
      scale = scale, n = n, loading = loading,
      n_loadings = n_loadings, gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname pca_matrix_plot
setMethod(
  "pca_matrix_plot", signature(
    data = "SummarizedExperiment"
  ),
  function(data,
           features = "all",
           slot = "counts",
           group_by = NULL,
           scale = TRUE,
           n = 4,
           loading = FALSE,
           n_loadings = 10,
           gene_id = "SYMBOL") {
    if (is.character(group_by)) {
      group_by <- SummarizedExperiment::colData(data)[[group_by]]
    }
    data <- SummarizedExperiment::assay(data, slot)

    p <- pca_matrix_plot(
      data = data, features = features,
      group_by = group_by,
      scale = scale, n = n, loading = loading,
      n_loadings = n_loadings, gene_id = gene_id
    )
    return(p)
  }
)

#' @rdname pca_matrix_plot
setMethod(
  "pca_matrix_plot", signature(
    data = "Seurat"
  ),
  function(data,
           features = "all",
           slot = "counts",
           group_by = NULL,
           scale = TRUE,
           n = 4,
           loading = FALSE,
           n_loadings = 10,
           gene_id = "SYMBOL") {
    if (is.character(group_by)) {
      group_by <- slot(data, "meta.data")[[group_by]]
    }
    data <- SeuratObject::GetAssayData(data, slot = slot)

    p <- pca_matrix_plot(
      data = data, features = features,
      group_by = group_by,
      scale = scale, n = n, loading = loading,
      n_loadings = n_loadings, gene_id = gene_id
    )
    return(p)
  }
)
