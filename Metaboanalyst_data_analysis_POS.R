# Opening libraries
library(MetaboAnalystR)
library(pls)

# initializing Rserv...
mSet<-InitDataObjects("pktable", "stat", FALSE)

# Reading .csv file
mSet<-Read.TextData(mSet, "D:/Gustavo/Cancer de colon/Positivo/SAUDÁVEIS_CONTROLE_3/data_original.csv", "rowu", "disc");

# Sanity check
mSet<-SanityCheckData(mSet)

# Replacing missing/zeros
mSet<-ReplaceMin(mSet);

# Filtering variables
mSet<-FilterVariable(mSet, "none", "F", 25)

# Preparing data for normalization
mSet<-PreparePrenormData(mSet)

# Row-wise normalization
mSet<-Normalization(mSet, "SumNorm", "NULL", "ParetoNorm", ratio=FALSE, ratioNum=20)

# Ploting normalization results (features)
mSet<-PlotNormSummary(mSet, "norm_0_", "png", 72, width=NA)

# Ploting normalization results (samples)
mSet<-PlotSampleNormSummary(mSet, "snorm_0_", "png", 72, width=NA)


# Fold-change
#mSet<-FC.Anal.unpaired(mSet, 2.0, 0)

# Ploting Fold-change results
#mSet<-PlotFC(mSet, "fc_0_", "png", 72, width=NA)

# t-test
mSet<-Ttests.Anal(mSet, F, 0.05, FALSE, TRUE)

# Ploting t-test results
mSet<-PlotTT(mSet, "tt_0_", "png", 72, width=NA)

# PLS
mSet<-PLSR.Anal(mSet, reg=TRUE)

# Pairploting PLS scores 
mSet<-PlotPLSPairSummary(mSet, "pls_pair_0_", "png", 72, width=NA, 5)

# Ploting 2D PLS score plot
mSet<-PlotPLS2DScore(mSet, "pls_score2d_0_", "png", 72, width=NA, 1,2,0.95,0,0)

# Ploting 3D PLS score plot
mSet<-PlotPLS3DScoreImg(mSet, "pls_score3d_0_", "png", 72, width=NA, 1,2,3, 40)

# Cross-validation
mSet<-PLSDA.CV(mSet, "T",8, "Q2")

# Ploting PLS-DA cross-validation results
mSet<-PlotPLS.Classification(mSet, "pls_cv_0_", "png", 72, width=NA)

# Permutation test
mSet<-PLSDA.Permut(mSet, 1000, "bw")

# Ploting permutation test results
mSet<-PlotPLS.Permutation(mSet, "pls_perm_1_", "png", 72, width=NA)

# Runing PCA analysis
mSet<-PCA.Anal(mSet)

# Pairploting PCA scores
mSet<-PlotPCAPairSummary(mSet, "pca_pair_0_", "png", 72, width=NA, 5)

# Ploting 2D PCA score plot
mSet<-PlotPCA2DScore(mSet, "pca_score2d_0_", "png", 72, width=NA, 1,2,0.95,0,0)

# Ploting PCA scree
mSet<-PlotPCAScree(mSet, "pca_scree_0_", "png", 72, width=NA, 5)


