# Create a list with Chemistry and Physics scores
students <- list(
  names = c("Robert", "Hemsworth", "Scarlett", "Evans", "Pratt",
            "Larson", "Holland", "Paul", "Simu", "Renner"),
  
  chemistry = c(59, 71, 83, 68, 65, 57, 62, 92, 92, 59),
  
  physics = c(89, 86, 65, 52, 60, 67, 40, 77, 90, 61)
)
# Count Chemistry failures
chem_fail <- sum(students$chemistry <= 49)

# Count Physics failures
phy_fail <- sum(students$physics <= 49)

# Highest Chemistry score
highest_chem <- max(students$chemistry)

# Highest Physics score
highest_phy <- max(students$physics)

# Student(s) with highest Chemistry score
top_chem_students <- students$names[students$chemistry == highest_chem]

# Student(s) with highest Physics score
top_phy_students <- students$names[students$physics == highest_phy]

cat("Chemistry Failures:", chem_fail, "\n")
cat("Physics Failures:", phy_fail, "\n")
cat("Highest Chemistry Score:", highest_chem, "\n")
cat("Top Chemistry Student(s):", top_chem_students, "\n")
cat("Highest Physics Score:", highest_phy, "\n")
cat("Top Physics Student(s):", top_phy_students, "\n")
