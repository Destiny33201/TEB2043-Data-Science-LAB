library(readxl)
library(dplyr)

titanic <- read.csv("C:/Users/User/Desktop/DSLAB/Lab8/titanic.csv")
View(titanic)

titanic_cleaned = na.omit(titanic) #omit=deleting
dim(titanic_cleaned)
View(titanic_cleaned)

#calculating the survival rate of female students
TotalSurvivedFemale <- sum(titanic_cleaned$Sex == "female" & titanic_cleaned$Survived == 1)
TotalFemales <- sum(titanic_cleaned$Sex == "female")
FemaleSurvivalRate <- (TotalSurvivedFemale / TotalFemales) * 100
FemaleMortaliltyRate <- (100 - FemaleSurvivalRate)
FemalePie <- c(FemaleSurvivalRate, FemaleMortaliltyRate)
Femalelabels <- c("FemaleSurvivalRate","FemaleMortaliltyRate")

#calculating the survival rate of female students
TotalSurvivedMale <- sum(titanic_cleaned$Sex == "male" & titanic_cleaned$Survived == 1)
TotalMales <- sum(titanic_cleaned$Sex == "male")
MaleSurvivalRate <- (TotalSurvivedMale / TotalMales) * 100
MaleMortalityRate <- (100 - MaleSurvivalRate)
MalePie <- c(MaleSurvivalRate, MaleMortalityRate)
Malelabels <- c("MaleSurvivalRate","MaleMortalityRate")

#Total survival rate
TotalSurvived <- sum(titanic_cleaned$Survived == 1)
TotalPassenger <- nrow(titanic_cleaned)
TotalSurvivalRate <- (TotalSurvived / TotalPassenger) * 100
cat(TotalSurvived, TotalPassenger)

# Survival by Port (Cherbourg)
Cherbourg_data <- titanic_cleaned %>% filter(Embarked == "C")
C_Survival_Rate <- mean(Cherbourg_data$Survived) * 100
C_ThirdClass_Percent <- (sum(Cherbourg_data$Pclass == 3) / nrow(Cherbourg_data)) * 100


#printing the calculation
cat("The Survival Rate:", TotalSurvived, "%\n")
cat("Female Survival Rate:", FemaleSurvivalRate, "%\n")
cat("Male Survival Rate:", MaleSurvivalRate, "%\n")
cat("Cherbourg Survival Rate:", C_Survival_Rate, "%\n")

pie(MalePie,Malelabels)
pie(FemalePie,Femalelabels)


survrate <- c(MaleSurvivalRate, FemaleSurvivalRate)
labelsurv <- c("Male","Female")
barplot(survrate, names.arg = labelsurv, xlab = "Gender", ylab = "Survival Rate", col="pink", main = "Survival Rate Male vs Female",border="black")

print(input)

pie(input)

print(titanic_cleaned)