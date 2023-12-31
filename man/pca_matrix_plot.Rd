% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/pca_matrix_plot-methods.R
\name{pca_matrix_plot}
\alias{pca_matrix_plot}
\alias{pca_matrix_plot,matrix-method}
\alias{pca_matrix_plot,Matrix-method}
\alias{pca_matrix_plot,data.frame-method}
\alias{pca_matrix_plot,ExpressionSet-method}
\alias{pca_matrix_plot,DGEList-method}
\alias{pca_matrix_plot,SummarizedExperiment-method}
\alias{pca_matrix_plot,Seurat-method}
\title{Make a matrix plot of PCA with top PCs}
\usage{
pca_matrix_plot(
  data,
  features = "all",
  slot = "counts",
  group_by = NULL,
  scale = TRUE,
  n = 4,
  loading = FALSE,
  n_loadings = 10,
  gene_id = "SYMBOL"
)

\S4method{pca_matrix_plot}{matrix}(
  data,
  features = "all",
  group_by = NULL,
  scale = TRUE,
  n = 4,
  loading = FALSE,
  n_loadings = 10,
  gene_id = "SYMBOL"
)

\S4method{pca_matrix_plot}{Matrix}(
  data,
  features = "all",
  group_by = NULL,
  scale = TRUE,
  n = 4,
  loading = FALSE,
  n_loadings = 10,
  gene_id = "SYMBOL"
)

\S4method{pca_matrix_plot}{data.frame}(
  data,
  features = "all",
  group_by = NULL,
  scale = TRUE,
  n = 4,
  loading = FALSE,
  n_loadings = 10,
  gene_id = "SYMBOL"
)

\S4method{pca_matrix_plot}{ExpressionSet}(
  data,
  features = "all",
  group_by = NULL,
  scale = TRUE,
  n = 4,
  loading = FALSE,
  n_loadings = 10,
  gene_id = "SYMBOL"
)

\S4method{pca_matrix_plot}{DGEList}(
  data,
  features = "all",
  slot = "counts",
  group_by = NULL,
  scale = TRUE,
  n = 4,
  loading = FALSE,
  n_loadings = 10,
  gene_id = "SYMBOL"
)

\S4method{pca_matrix_plot}{SummarizedExperiment}(
  data,
  features = "all",
  slot = "counts",
  group_by = NULL,
  scale = TRUE,
  n = 4,
  loading = FALSE,
  n_loadings = 10,
  gene_id = "SYMBOL"
)

\S4method{pca_matrix_plot}{Seurat}(
  data,
  features = "all",
  slot = "counts",
  group_by = NULL,
  scale = TRUE,
  n = 4,
  loading = FALSE,
  n_loadings = 10,
  gene_id = "SYMBOL"
)
}
\arguments{
\item{data}{expression data, can be matrix, eSet, seurat...}

\item{features}{vector of gene symbols or 'all', specify the genes used for
PCA, default 'all'}

\item{slot}{character, specify the slot name of expression to be used,
optional}

\item{group_by}{character, specify the column to be grouped and colored,
default NULL}

\item{scale}{logical, if to scale data for PCA, default TRUE}

\item{n}{num, specify top n PCs to plot}

\item{loading}{logical, if to plot and label loadings of PCA, default 'FALSE'}

\item{n_loadings}{num, top n loadings to plot; or a vector of gene IDs;
only work when \code{loading = TRUE}}

\item{gene_id}{character, specify which column of IDs used to calculate TPM,
also indicate the ID type of expression data's rowname,
could be one of 'ENSEMBL', 'SYMBOL', 'ENTREZ'...,
default 'SYMBOL'}
}
\value{
matrix plot of PCA
}
\description{
Make a matrix plot of PCA with top PCs
}
\examples{
data("im_data_6")
pca_matrix_plot(data = im_data_6, scale = FALSE)

}
