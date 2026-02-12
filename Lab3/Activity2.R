# Create a list containing student names and exam scores
students <- list(
  names = c("Robert", "Hemsworth", "Scarlett", "Evans", "Pratt",
            "Larson", "Holland", "Paul", "Simu", "Renner"),
  scores = c(59, 71, 83, 68, 65, 57, 62, 92, 92, 59)
)
# Find highest score
highest_score <- max(students$scores)

# Find lowest score
lowest_score <- min(students$scores)

# Find average score
average_score <- mean(students$scores)

# Student(s) with highest score
student_highest <- students$names[students$scores == highest_score]

# Student(s) with lowest score
student_lowest <- students$names[students$scores == lowest_score]

cat("Highest Score:", highest_score, "\n")
cat("Lowest Score:", lowest_score, "\n")
cat("Average Score:", average_score, "\n")
cat("Student with highest score:", student_highest, "\n")
cat("Student with lowest score:", student_lowest, "\n")
