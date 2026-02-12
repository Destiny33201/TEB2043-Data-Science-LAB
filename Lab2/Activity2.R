string1 <- readline(prompt = "Enter string1:")
string2 <- readline(prompt = "Enter string2:")

string1 <- toupper(string1)
string2 <- toupper(string2)

if (string1 == string2)
  print("This program compare 2 strings. Both input are similar: TRUE")
if (string1 != string2)
  print("This program compare 2 strings. Both input are similar: FALSE")