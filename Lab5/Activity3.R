num <- readline(prompt = "Input an integer: ")
num <- as.integer(num)

original_num <- num
sum <- 0

n <- nchar(as.character(num))

while (num > 0) {
  digit <- num %% 10
  sum <- sum + digit^n
  num <- num %/% 10
}

if (sum == original_num) {
  cat(original_num, "is an Armstrong number.\n")
} else {
  cat(original_num, "is not an Armstrong number.\n")
}