test_that("get_de_table works", {
  data("im_data_6")
  ## test Expression object
  DEG_table <- get_de_table(im_data_6,
    group_col = "celltype:ch1",
    target_group = "NK"
  )
  expect_true(all(vapply(DEG_table, is.data.frame, FUN.VALUE = TRUE)))

  ## test DGEList object
  data <- process_data(im_data_6,
    group_col = "celltype:ch1",
    target_group = "NK"
  )
  DEG_table <- get_de_table(data,
    group_col = "celltype.ch1",
    target_group = "NK", normalize = FALSE
  )
  expect_true(all(vapply(DEG_table, is.data.frame, FUN.VALUE = TRUE)))

  ## test matrix object
  DEG_table <- get_de_table(
    Biobase::exprs(im_data_6),
    group_col = im_data_6$`celltype:ch1`,
    target_group = "NK"
  )
  expect_true(all(vapply(DEG_table, is.data.frame, FUN.VALUE = TRUE)))

  ## test Matrix object
  DEG_table <- get_de_table(Matrix::Matrix(Biobase::exprs(im_data_6)),
    group_col = im_data_6$`celltype:ch1`,
    target_group = "NK"
  )
  expect_true(all(vapply(DEG_table, is.data.frame, FUN.VALUE = TRUE)))


  ## test seurat object
  data_seurat <- SeuratObject::CreateSeuratObject(
    counts = Biobase::exprs(im_data_6),
    meta.data = data$samples
  )
  DEG_table <- get_de_table(data_seurat,
    group_col = "celltype.ch1",
    target_group = "NK"
  )
  expect_true(all(vapply(DEG_table, is.data.frame, FUN.VALUE = TRUE)))

  ## test sce object
  data_sce <- SingleCellExperiment::SingleCellExperiment(
    assays = list(counts = Biobase::exprs(im_data_6)),
    colData = data$samples
  )
  DEG_table <- get_de_table(data_sce,
    group_col = "celltype.ch1",
    target_group = "NK"
  )
  expect_true(all(vapply(DEG_table, is.data.frame, FUN.VALUE = TRUE)))
})
