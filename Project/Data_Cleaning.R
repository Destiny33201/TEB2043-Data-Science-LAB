# ============================================================
# DATA CLEANING SCRIPT
# Input:  Unclean_Dataset.csv
# Output: Cleaned_data.csv
# ============================================================

# ── 1. LOAD REQUIRED LIBRARIES ───────────────────────────────
# install.packages(c("dplyr", "stringr", "lubridate")) # uncomment if needed
library(dplyr)
library(stringr)
library(lubridate)


# ── 2. READ THE RAW FILE AS PLAIN TEXT ───────────────────────
# The file mixes pipe (|) and comma (,) delimiters, so we read
# it line-by-line first and normalise before parsing.
# encoding = "latin1" handles special characters like £ (\xa3)
# that would otherwise cause gsub to fail with "invalid string" errors.
raw_lines <- readLines("C:/Users/User/Desktop/DSLAB/Project/Unclean_Dataset.csv", warn = FALSE, encoding = "latin1")

# Remove the header line; we will assign column names manually
raw_lines <- raw_lines[-1]


# ── 3. NORMALISE DELIMITERS ───────────────────────────────────
# Some rows use "|" as a delimiter. Replace "|" with "," so
# every row is comma-separated, then collapse extra whitespace.
raw_lines <- gsub("\\|", ",", raw_lines)


# ── 4. PARSE INTO A DATA FRAME ───────────────────────────────
# read.csv from a text connection handles the now-uniform commas.
# fill = TRUE pads short rows; blank.lines.skip drops empty rows.
df_raw <- read.csv(
  text            = paste(raw_lines, collapse = "\n"),
  header          = FALSE,
  fill            = TRUE,
  blank.lines.skip = TRUE,
  stringsAsFactors = FALSE,
  strip.white     = TRUE
)

# Keep only the first 8 columns (columns 9+ are artefacts of
# rows that duplicated their own content after extra commas).
df_raw <- df_raw[, 1:8]

# Assign clean column names
colnames(df_raw) <- c("Student_ID", "First_Name", "Last_Name",
                      "Age", "Gender", "Course",
                      "Enrollment_Date", "Total_Payments")


# ── 5. REMOVE COMPLETELY EMPTY ROWS ──────────────────────────
# Rows where every column is blank or NA add no information.
df <- df_raw %>%
  filter(rowSums(. == "" | is.na(.)) < ncol(.))


# ── 6. CLEAN Student_ID ───────────────────────────────────────
# Strip all non-numeric characters; set blank / non-numeric IDs to NA.
df$Student_ID <- str_trim(df$Student_ID)
df$Student_ID <- gsub("[^0-9]", "", df$Student_ID)
df$Student_ID[df$Student_ID == ""] <- NA


# ── 7. CLEAN First_Name & Last_Name ──────────────────────────
# Trim whitespace, title-case each name, set empty strings to NA.
clean_name <- function(x) {
  x <- str_trim(x)
  x <- str_to_title(x)
  x[x == ""] <- NA
  return(x)
}
df$First_Name <- clean_name(df$First_Name)
df$Last_Name  <- clean_name(df$Last_Name)

# Some rows stored the full name in First_Name and duplicated it
# in Last_Name (e.g. "Faramotu Ismail", "Faramotu Ismail").
# Where First_Name == Last_Name and contains a space, split them.
both_same_fullname <- !is.na(df$First_Name) &
  !is.na(df$Last_Name) &
  df$First_Name == df$Last_Name &
  str_detect(df$First_Name, " ")

split_names <- str_split_fixed(df$First_Name[both_same_fullname], " ", 2)
df$First_Name[both_same_fullname] <- split_names[, 1]
df$Last_Name[both_same_fullname]  <- split_names[, 2]


# ── 8. CLEAN Age ──────────────────────────────────────────────
# Age may contain asterisks, letters mixed with numbers, or be
# embedded in the Gender column (e.g. "M 25"). Extract digits only.
# Also handle "Gender Age" combos accidentally placed in Age column.

# Fix cases where Gender column contains "M 25" or "F 24" –
# split Gender and Age that were merged into one field.
gender_age_mask <- str_detect(df$Gender, "^[MmFf]\\s+\\d+$")
if (any(gender_age_mask, na.rm = TRUE)) {
  parts <- str_split_fixed(df$Gender[gender_age_mask], "\\s+", 2)
  df$Gender[gender_age_mask] <- parts[, 1]
  df$Age[gender_age_mask]    <- parts[, 2]
}

# Strip non-numeric characters from Age, convert to integer
df$Age <- as.integer(gsub("[^0-9]", "", str_trim(df$Age)))

# Flag biologically implausible ages (< 10 or > 75) as NA
df$Age[!is.na(df$Age) & (df$Age < 10 | df$Age > 75)] <- NA


# ── 9. CLEAN Gender ───────────────────────────────────────────
# Standardise to "M" or "F"; everything else becomes NA.
df$Gender <- str_trim(toupper(df$Gender))
df$Gender <- str_extract(df$Gender, "^[MF]")
df$Gender[!df$Gender %in% c("M", "F")] <- NA


# ── 10. CLEAN Course ──────────────────────────────────────────
# Fix common truncations and typos, then title-case.
df$Course <- str_trim(df$Course)
df$Course[df$Course == ""] <- NA

# Map known truncations / typos to full correct names
course_fixes <- c(
  "Machine Learnin"  = "Machine Learning",
  "Web Developmen"   = "Web Development",
  "Web Developmet"   = "Web Development",
  "Web Develpment"   = "Web Development",
  "Data Analytics"   = "Data Analytics",
  "Data Analysis"    = "Data Analysis",
  "Cyber Security"   = "Cyber Security"
)
for (bad in names(course_fixes)) {
  df$Course[!is.na(df$Course) & df$Course == bad] <- course_fixes[bad]
}

# Remove rows where Course is a bare number (invalid entry)
df$Course[!is.na(df$Course) & grepl("^[0-9]+$", df$Course)] <- NA


# ── 11. CLEAN Enrollment_Date ────────────────────────────────
# Multiple date formats exist:
#   "2022-05-15"  →  ISO format
#   "05-09-23"    →  MM-DD-YY  (ambiguous; treated as MM-DD-YY)
#   "08-01-24"    →  MM-DD-YY
#   "01-Jul-21"   →  DD-Mon-YY
# "NA" strings are set to NA; blank cells also become NA.

df$Enrollment_Date <- str_trim(df$Enrollment_Date)
df$Enrollment_Date[df$Enrollment_Date %in% c("NA", "", "N/A")] <- NA

parse_dates <- function(x) {
  # Try ISO first (yyyy-mm-dd)
  d <- suppressWarnings(ymd(x))
  # Try DD-Mon-YY  e.g. "01-Jul-21"
  na_idx <- is.na(d)
  d[na_idx] <- suppressWarnings(dmy(x[na_idx]))
  # Try MM-DD-YY  e.g. "05-09-23"
  na_idx <- is.na(d)
  d[na_idx] <- suppressWarnings(mdy(x[na_idx]))
  return(d)
}

df$Enrollment_Date <- parse_dates(df$Enrollment_Date)

# Flag implausible enrollment years (before 2000 or after 2025)
year_val <- year(df$Enrollment_Date)
df$Enrollment_Date[!is.na(year_val) &
                     (year_val < 2000 | year_val > 2025)] <- NA


# ── 12. CLEAN Total_Payments ─────────────────────────────────
# Values contain currency symbols ($, £, ?, ₦, spaces, commas).
# Strip everything except digits and decimal points, then convert
# to numeric.
df$Total_Payments <- str_trim(df$Total_Payments)
df$Total_Payments[df$Total_Payments == ""] <- NA

df$Total_Payments <- gsub("[^0-9\\.]", "", df$Total_Payments)
df$Total_Payments[df$Total_Payments == ""] <- NA
df$Total_Payments <- as.numeric(df$Total_Payments)


# ── 13. REMOVE ROWS WITH ANY MISSING VALUES ──────────────────
# Any row that still has NA or blank in ANY of the 8 columns
# is considered incomplete and is dropped entirely.
df <- df %>%
  filter(
    !is.na(Student_ID)      & Student_ID      != "",
    !is.na(First_Name)      & First_Name      != "",
    !is.na(Last_Name)       & Last_Name       != "",
    !is.na(Age),
    !is.na(Gender)          & Gender          != "",
    !is.na(Course)          & Course          != "",
    !is.na(Enrollment_Date),
    !is.na(Total_Payments)
  )


# ── 14. REMOVE DUPLICATE ROWS ────────────────────────────────
# Drop exact duplicates across all 8 columns.
df <- distinct(df)

# Also deduplicate on Student_ID where ID is not NA,
# keeping the first occurrence.
df <- df %>%
  group_by(Student_ID) %>%
  filter(is.na(Student_ID) | row_number() == 1) %>%
  ungroup()


# ── 15. REORDER COLUMNS & SORT ───────────────────────────────
df <- df %>%
  select(Student_ID, First_Name, Last_Name, Age, Gender,
         Course, Enrollment_Date, Total_Payments) %>%
  arrange(as.numeric(Student_ID))


# ── 16. EXPORT CLEANED DATA ──────────────────────────────────
write.csv(df, "C:/Users/User/Desktop/DSLAB/Project/Cleaned_data.csv", row.names = FALSE, na = "")

cat("✔ Cleaning complete. Rows in raw data:", nrow(df_raw),
    "| Rows after cleaning:", nrow(df), "\n")
cat("✔ File saved as: Cleaned_data.csv\n")