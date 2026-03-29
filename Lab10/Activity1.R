# Load dataset
data("Theoph")
head(Theoph)

# Step 1: Build linear model — predict Dose from Wt
x <- Theoph$Wt     # weight (kg)
y <- Theoph$Dose   # dose (mg/kg)

model_theoph <- lm(y ~ x)
print(model_theoph)
print(summary(model_theoph))

# Step 2: Visualise
plot(y, x,
     main  = "Theoph: Weight vs Dose",
     abline(lm(Wt ~ Dose, data = Theoph)),
     xlab  = "Dose (mg/kg)",
     ylab  = "Weight (kg)",
     col   = "blue", pch = 16, cex = 1.3)

scatter.smooth(y, x,
               main = "Weight ~ Dose",
               xlab = "Dose (mg/kg)",
               ylab = "Weight (kg)")

# Step 3: Predict dose for weights 90, 95, 100 kg
new_weights <- data.frame(x = c(90, 95, 100))
result      <- predict(model_theoph, new_weights)
print(result)