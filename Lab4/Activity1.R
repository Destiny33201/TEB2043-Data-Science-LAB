age = c(55,57,56,52,51,59,58,53,59,55,60,60,60,60,52,55,56,51,60,52,54,56,52,57,54,56,58,53,53,50,55,51,57,60,57,55,51,50,57,58)
age = factor(age)
print(levels(age))
age <- as.numeric(as.character(age))
agerange <- cut(age, breaks = 5)
print(table(age))
print(table(agerange))

