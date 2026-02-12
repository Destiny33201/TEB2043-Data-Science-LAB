name <- readline(prompt = "Enter your name:")
phone_number <- readline(prompt = "Enter your phone number:")
phone_number <- as.character(phone_number)
first_pn <- substring(phone_number, 1, 3)
last_pn <- substring(phone_number, 7, 10)


name <- toupper(name)
print(paste("Hi,", name,". A verification code has been sent to ", first_pn, "-xxxx", last_pn))