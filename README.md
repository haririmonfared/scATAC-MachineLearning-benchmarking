# scATAC-MachineLearning-benchmarking

Single-cell assay for transposase accessible chromatin using sequencing(scATAC-seq) is rapidly advancing our understanding of the cellular composition of complex tissues and organisms. The similarity of data structure and feature between scRNA-seq and scATAC-seq makes it feasible to identify the cell types in scATAC-seq through traditional supervised machine learning methods, which is widely proved reliable and used as underlying method in scRNA-seq classification analysis. Here, we evaluated 6 popular machine learning methods for classification in scATAC-seq. The performance of the methods is evaluated using 4 publicly available single cell ATAC-seq datasets of different tissues and sizes and technologies. We evaluated these methods using intra-datasets experiments of 5-folds cross validation based on accuracy, percentage of correctly predicted cells. We found that these methods may perform well in some types of cells in single dataset, but the overall results are not as well as in scRNA-seq analysis. The SVM method has overall the best performance across all experiments.

# HOW TO USE:
As you see here there are five folders that each of folders are same in categorization of codes they wrote. The main difference between these folders is that “inter-dataset” folder going to compare accuracy of each method between datasets and remaining four folders are for measuring the accuracy of each method in a single dataset.
So, for use this repo you have to select your desired folder, go to “input” folder and use “README” file to download datasets. Note that in some cases the names of downloaded datasets are same, so be wise to know each one is related to which dataset. After that, put downloaded dataset into input folder. Now go back one step and go to “bin” folder this time and run “1_preprocess_crossValidation.r”. find “setwd” command in first line and set the bin folder path. Simply, run rest of commands to generate “CV_folds_v1Train_nextgemTest.RData” file in “tmp” folder. Next, you have to run one of python codes in bin folder to predict cell types based on each method. These python files will generate results in “output” folder containing test and training time, predicted labels and true labels. Finally, in order to evaluate this methods based on F1 score, confusion matrix and pop size you have run “3_evaluate_....r” files to fill out folders with this names in output folder.  
# What we have done so far:
As we analyze the code, we realized that cross validation process is done by all the data that we have. This will cause that every predictors see all of data in each dataset, which is leading to achieving a high accuracy that is not reliable. So, we wrote a new preprocess code to spilt test and train data completely separate from each other by the ratio of “0.8”. You can find the new preprocess code under “new_prep” folder.



## Description
We provide all the scripts to run and evaluate all machine laerning methods, and to reproduce the results introduced in the paper.

All processed matrix used in paper are also provided.

1. Each folder stored the codes, input and output for a experiment
2. The bin folder stores the benchmarking and evaluation code
3. The input folder stores the bin-cell matrix and labels for dataset
4. The tmp folder stores the temporary file of experiment, especially the grouping information for 5-fold cross validation
5. The output file stores the results of each experiment and its evaluation results


## Citation
Zhe Cui, Liran Juan, Tao Jiang, Bo Liu, Tianyi Zang, Yadong Wang (2020), 'Assessment of Machine Learning Methods for Classification in Single Cell ATAC-seq', 2020 IEEE International Conference on Bioinformatics and Biomedicine (BIBM) (Accepted), Seoul, Korea.

## Credits
Zhe Cui, Liran Juan, Tao Jiang, Bo Liu, Tianyi Zang and Yadong Wang

## Email
 cuizhe@hit.edu.cn, mrcuizhe@gmail.com
