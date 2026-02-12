# -------------------------
# Create Array1
# 2 rows, 4 columns, 3 tables
# -------------------------

Array1 <- array(
  c(1,2,3,4,5,6,7,8,
    9,10,11,12,13,14,15,16,
    17,18,19,20,21,22,23,24),
  dim = c(2,4,3)
)

cat("Array1\n")
print(Array1)


# -------------------------
# Create Array2
# 3 rows, 2 columns, 5 tables
# -------------------------

Array2 <- array(
  c(25,26,27,28,29,30,
    31,32,33,34,35,36,
    37,38,39,40,41,42,
    43,44,45,46,47,48,
    49,50,51,52,53,54),
  dim = c(3,2,5)
)

cat("Array2\n")
print(Array2)


# -------------------------
# Required Outputs
# -------------------------

cat("\n\"The second row of the second matrix of the array:\"\n")
print(Array1[2,,2])

cat("\n\"The element in the 3rd row and 2nd column of the 1st matrix:\"\n")
print(Array2[3,2,1])
