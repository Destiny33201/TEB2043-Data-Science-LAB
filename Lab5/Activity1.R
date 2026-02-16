year <- readline(prompt("Input year:"))
year <- as.integer(year)
if ((year%%4 == 0) && (year%%100 != 0) || (year%%400 == 0)){
  print(paste("Output:", year, "is a leap year"))
}else{
  print(paste("Output:", year, "is not a leap year"))
}