% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/sig_boxplot-methods.R
\name{sig_boxplot}
\alias{sig_boxplot}
\alias{sig_boxplot,matrix,vector,vector,character-method}
\alias{sig_boxplot,Matrix,vector,vector,character-method}
\alias{sig_boxplot,data.frame,vector,vector,character-method}
\alias{sig_boxplot,DGEList,vector,character,character-method}
\alias{sig_boxplot,ExpressionSet,vector,character,character-method}
\alias{sig_boxplot,Seurat,vector,character,character-method}
\alias{sig_boxplot,SummarizedExperiment,vector,character,character-method}
\alias{sig_boxplot,list,vector,character,character-method}
\title{Boxplot of median expression or scores of signature}
\usage{
sig_boxplot(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  slot = "counts",
  gene_id = "SYMBOL"
)

\S4method{sig_boxplot}{matrix,vector,vector,character}(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  gene_id = "SYMBOL"
)

\S4method{sig_boxplot}{Matrix,vector,vector,character}(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  gene_id = "SYMBOL"
)

\S4method{sig_boxplot}{data.frame,vector,vector,character}(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  gene_id = "SYMBOL"
)

\S4method{sig_boxplot}{DGEList,vector,character,character}(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  slot = "counts",
  gene_id = "SYMBOL"
)

\S4method{sig_boxplot}{ExpressionSet,vector,character,character}(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  gene_id = "SYMBOL"
)

\S4method{sig_boxplot}{Seurat,vector,character,character}(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  slot = "counts",
  gene_id = "SYMBOL"
)

\S4method{sig_boxplot}{SummarizedExperiment,vector,character,character}(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  slot = "counts",
  gene_id = "SYMBOL"
)

\S4method{sig_boxplot}{list,vector,character,character}(
  data,
  sigs,
  group_col,
  target_group,
  type = c("score", "expression"),
  method = "t.test",
  slot = "counts",
  gene_id = "SYMBOL"
)
}
\arguments{
\item{data}{expression data, can be matrix, DGEList, eSet, seurat, sce...}

\item{sigs}{a vector of signature (Symbols)}

\item{group_col}{character or vector, specify the column name to compare in coldata}

\item{target_group}{pattern, specify the group of interest as reference}

\item{type}{one of "score" and "expression", to plot score or expression of
the signature}

\item{method}{a character string indicating which method to be used for
\code{stat_compare_means()} to compare the means across groups,
could be "t.test", 'wilcox.test', 'anova'..., default "t.test"}

\item{slot}{character, indicate which slot used as expression, optional}

\item{gene_id}{character, indicate the ID type of rowname of expression data's ,
could be one of 'ENSEMBL', 'SYMBOL', ... default 'SYMBOL'}
}
\value{
patchwork or ggplot of boxplot
}
\description{
Make boxplot and show expression or score level of signature across subsets.
}
\examples{
data("im_data_6", "nk_markers")
p <- sig_boxplot(
  im_data_6,
  sigs = nk_markers$HGNC_Symbol[1:30],
  group_col = "celltype:ch1", target_group = "NK",
  gene_id = "ENSEMBL"
)

}
