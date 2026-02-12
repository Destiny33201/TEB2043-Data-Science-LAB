# Input vector (20 students)
scores <- c(33, 24, 54, 94, 16, 89, 60, 6, 77, 61,
            13, 44, 26, 24, 73, 73, 90, 39, 90, 54)

# Count number of students in each grade range
A <- sum(scores >= 90 & scores <= 100)
B <- sum(scores >= 80 & scores <= 89)
C <- sum(scores >= 70 & scores <= 79)
D <- sum(scores >= 60 & scores <= 69)
E <- sum(scores >= 50 & scores <= 59)
F <- sum(scores <= 49)

# Display grade counts
cat("Number of students in each grade:\n")
cat("A (90-100):", A, "\n")
cat("B (80-89):", B, "\n")
cat("C (70-79):", C, "\n")
cat("D (60-69):", D, "\n")
cat("E (50-59):", E, "\n")
cat("F (<=49):", F, "\n\n")

# Check pass or fail (>49 is pass)
pass_status <- scores > 49

# Display pass/fail (TRUE/FALSE)
cat("Pass status (TRUE = Pass, FALSE = Fail):\n")
print(pass_status)
