setwd("/Users/hosseinhariri/Documents/research/scATAC-MachineLearning-benchmarking-master/intra-10xPBMCsNextGem/bin")

label <- read.csv('../input/pbmc_5k_atac_label_nextgem.txt', sep = "\t", header = TRUE)

data <- readRDS("../input/10xpbmc5k-snap-full.rds")

label <- label[label$barcode %in% rownames(data), ]
data <- data[rownames(data) %in% label$barcode, ]
saveRDS(data, file = "../output/10xpbmc5k-snap-full.rds")

Cross_Validation <- function(LabelsPath, col_Index = 1, OutputDir, train_percentage = 0.8) {
  # Rest of the code remains the same
  "
  Cross_Validation
  Function returns train and test indices for 5 folds stratified across unique cell populations,
  also filter out cell populations with less than 10 cells.
  It return a 'CV_folds.RData' file which then used as input to classifiers wrappers.
  Parameters
  ----------
  LabelsPath : Cell population annotations file path (.csv).
  col_Index : column index (integer) defining which level of annotation to use,
  in case of multiple cell type annotations (default is 1)
  OutputDir : Output directory defining the path of the exported file.
  "
  
  Labels <- as.matrix(LabelsPath)
  Labels <- as.vector(Labels[,col_Index])
  
  Removed_classes <- !(table(Labels) > 10)
  Cells_to_Keep <- !(is.element(Labels,names(Removed_classes)[Removed_classes]))
  Labels <- Labels[Cells_to_Keep]
  # Getting training and testing Folds
  library(rBayesianOptimization)
  n_folds <- 5
  Folds <- KFold(Labels, nfolds = n_folds, stratified = TRUE)
  Test_Folds <- c(n_folds:1)
  
  Train_Idx <- list()
  Test_Idx <- list()
  
  for (i in c(1:length(Folds))) {
    Temp_Folds <- Folds
    Temp_Folds[Test_Folds[i]] <- NULL
    
    # Calculate the number of cells to use for training
    train_size <- round(train_percentage * length(unlist(Temp_Folds)))
    
    # Sample train_size number of cells from the remaining folds
    train_indices <- sample(length(unlist(Temp_Folds)), train_size)
    
    # Use the sampled indices for training
    Train_Idx[i] <- list(unlist(Temp_Folds)[train_indices])
    Test_Idx[i] <- Folds[Test_Folds[i]]
  }
  
  save(n_folds, Train_Idx, Test_Idx, col_Index, Cells_to_Keep, file = paste0(OutputDir, '/CV_folds.RData'))
}

Cross_Validation(label, 2, "../tmp", train_percentage = 0.8)
