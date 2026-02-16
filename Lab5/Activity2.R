input <- readline(prompt("Input an Integer:"))
input <- as.integer(input)
v <- 1:input
print(v)
for (i in v)
  print(paste("Number is:", i, "and cube of the", i, "is:", i^3))