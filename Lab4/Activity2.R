V1 = c(2,3,1,5,4,6,8,7,9)

matrix1 <- matrix(c(V1), nrow = 3, byrow = TRUE)
matrix2 <- t(matrix1)

rownames(matrix1) = c("row1", "row2", "row3")
colnames(matrix1) = c("col1", "col2", "col3")

rownames(matrix2) = c("row1", "row2", "row3")
colnames(matrix2) = c("col1", "col2", "col3")

print(matrix1)
print(matrix2)

result <- matrix1 + matrix2
cat("Result of addition","\n")
print(result)

result <- matrix1 - matrix2
cat("Result of subtraction","\n")
print(result)

result <- matrix1 * matrix2
cat("Result of multiplication","\n")
print(result)

result <- matrix1 / matrix2
cat("Result of division","\n")
print(result)