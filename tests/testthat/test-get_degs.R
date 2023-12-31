test_that("get_degs works", {
  data("im_data_6")
  ## test Expression object
  DEGs <- get_degs(im_data_6, group_col = "celltype:ch1", target_group = "NK")
  expect_identical(names(DEGs), c("DEGs", "proc_data"))

  ## test DGEList object
  data <- DEGs$proc_data
  DEGs <- get_degs(data,
    group_col = "celltype.ch1",
    target_group = "NK", normalize = FALSE,
    filter = c(1, 4)
  )
  expect_identical(names(DEGs), c("DEGs", "proc_data"))

  ## test matrix object
  DEGs <- get_degs(Biobase::exprs(im_data_6),
    group_col = im_data_6$`celltype:ch1`,
    target_group = "NK"
  )
  expect_identical(names(DEGs), c("DEGs", "proc_data"))

  ## test Matrix object
  DEGs <- get_degs(Matrix::Matrix(Biobase::exprs(im_data_6)),
    group_col = im_data_6$`celltype:ch1`,
    target_group = "NK"
  )
  expect_identical(names(DEGs), c("DEGs", "proc_data"))

  ## test seurat object
  data_seurat <- SeuratObject::CreateSeuratObject(
    counts = Biobase::exprs(im_data_6),
    meta.data = data$samples
  )
  DEGs <- get_degs(data_seurat,
    group_col = "celltype.ch1",
    target_group = "NK"
  )
  expect_identical(names(DEGs), c("DEGs", "proc_data"))

  ## test sce object
  data_sce <- SingleCellExperiment::SingleCellExperiment(
    assays = list(counts = Biobase::exprs(im_data_6)),
    colData = data$samples
  )
  DEGs <- get_degs(data_sce,
    group_col = "celltype.ch1",
    target_group = "NK"
  )
  expect_identical(names(DEGs), c("DEGs", "proc_data"))

  ## test batch effect correction
  DEGs <- get_degs(im_data_6,
    group_col = "celltype:ch1",
    target_group = "NK", batch = "race:ch1"
  )
  expect_identical(names(DEGs), c("DEGs", "proc_data"))
})
