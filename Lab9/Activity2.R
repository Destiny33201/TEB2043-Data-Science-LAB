library(caret)

# Use all numeric columns of mtcars
mydata <- mtcars

# 1. Log Transformation
scaled_log <- log(mydata)
print(scaled_log)

# 2. Standard Scaling (Z-score)
scaled_std <- as.data.frame(scale(mydata))
print(scaled_std)

# 3. Min-Max Scaling
minmax      <- preProcess(mydata, method = c("range"))
scaled_minmax <- predict(minmax, mydata)
print(scaled_minmax)

# Compare summaries
summary(mydata)
summary(scaled_log)
summary(scaled_std)
summary(scaled_minmax)