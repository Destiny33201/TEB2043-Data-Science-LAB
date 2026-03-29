library(e1071)
library(caTools)
library(class)

# Load dataset
data("ChickWeight")
head(ChickWeight)

# Convert Diet to factor (it's the target class)
ChickWeight$Diet <- as.factor(ChickWeight$Diet)

# Step 1: Split data
split    <- sample.split(ChickWeight, SplitRatio = 0.7)
train_cl <- subset(ChickWeight, split == TRUE)
test_cl  <- subset(ChickWeight, split == FALSE)

# Step 2: Feature scaling (numeric columns: weight, Time)
train_scale <- scale(train_cl[, c("weight", "Time")])
test_scale  <- scale(test_cl[,  c("weight", "Time")])

# Step 3: Try different K values to find optimal
for (k in c(1, 3, 5, 7, 15, 19)) {
  classifier_knn  <- knn(train = train_scale,
                         test  = test_scale,
                         cl    = train_cl$Diet,
                         k     = k)
  misClassError   <- mean(classifier_knn != test_cl$Diet)
  cat("K =", k, "| Accuracy =", round(1 - misClassError, 4), "\n")
}

# Step 4: Use optimal K (e.g. K=5 — adjust based on output above)
optimal_k      <- 5
classifier_knn <- knn(train = train_scale,
                      test  = test_scale,
                      cl    = train_cl$Diet,
                      k     = optimal_k)

# Step 5: Confusion Matrix
cm <- table(test_cl$Diet, classifier_knn)
print(cm)

# Step 6: Final Accuracy
misClassError <- mean(classifier_knn != test_cl$Diet)
print(paste("Accuracy =", 1 - misClassError))