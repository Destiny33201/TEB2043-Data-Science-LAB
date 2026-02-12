weight <- readline(prompt = "Enter your weight in kg:")
height <- readline(prompt = "Enter your height in meters:")
weight <- as.double(weight)
height <- as.double(height)
Underweight <- Normal <- Overweight <- Obese <- "FALSE"

BMI <- weight/((height)**2)
BMI <- as.double(BMI)

if (BMI <= 18.4)
  Underweight <- "TRUE"
if (BMI >= 18.5 & BMI <= 24.9)
  Normal <- "TRUE"
if (BMI >= 25.0 & BMI <= 39.9)
  Overweight <- "TRUE"
if (BMI >=40.0)
  Obese <- "TRUE"

print(paste("Underweight:", Underweight))
print(paste("Normal:", Normal))
print(paste("Overweight:", Overweight))
print(paste("Obese:", Obese))