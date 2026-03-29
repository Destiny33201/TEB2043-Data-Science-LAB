library(corrplot)
library(RColorBrewer)
library(reshape2)
library(ggplot2)

# Load dataset
data("ToothGrowth")
head(ToothGrowth)

# Step 1: Compute correlation matrix
# Note: 'supp' is categorical, so we use only numeric columns: len & dose
corr_mat <- round(cor(ToothGrowth[, c("len", "dose")]), 2)
print(corr_mat)

# Step 2: Pearson correlation test between len and dose
result <- cor.test(ToothGrowth$len, ToothGrowth$dose, method = "pearson")
print(result)

# Step 3: Correlogram (Lab 9a style)
corrplot(corr_mat, type = "upper")
corrplot(corr_mat, type = "upper", order = "hclust",
         col = brewer.pal(n = 8, name = "RdYlBu"))

# Step 4: Reorder and melt for heatmap
dist <- as.dist((1 - corr_mat) / 2)
hc   <- hclust(dist)
corr_mat <- corr_mat[hc$order, hc$order]

melted_corr_mat <- melt(corr_mat)
head(melted_corr_mat)

# Step 5: ggplot2 heatmap
ggplot(data = melted_corr_mat, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(Var2, Var1, label = value), color = "white", size = 4) +
  labs(title = "ToothGrowth Correlation Heatmap")