######################################################################
# (\__/)
# (>'.'<)   Script dependencies
# (")_(")
######################################################################

# Load packages to work with dates
library(lubridate, warn.conflicts=FALSE)

######################################################################
# (\__/)
# (>'.'<)   Functions to match GPS data
# (")_(")
######################################################################

# Format time data in mobile gps data row to POSIXct type
format_mobile_time <- function(mobile_gps) {
  # Parse the date in the data row
  parsed_date <- parse_date_time(mobile_gps['DATE'], orders=c("ymd", "dmy"))
  
  # Combine date and time columns in mobile gps into a datetime column
  datetime <- paste(parsed_date, mobile_gps['TIME'])
  
  # Set timezone to Singapore
  mobile_gps_time <- ymd_hms(datetime, tz="Asia/Singapore")
}

# Find index in handheld gps data with the closest time to the current
# mobile gps data row
find_closest_idx <- function(mobile_gps_row, handheld_gps) {
  mobile_gps_time <- format_mobile_time(mobile_gps_row)
  time_diff <- abs(mobile_gps_time - handheld_gps$CLEANED.DATETIME)
  min_diff_idx <- which.min(time_diff)
}

# Format time data in handheld gps data to POSIXct type
format_handheld_time <- function(handheld_gps) {
  handheld_gps$CLEANED.DATETIME <- ymd_hms(handheld_gps$time, tz="UTC")
  
  # Convert time to Singapore timezone
  handheld_gps$CLEANED.DATETIME <- with_tz(handheld_gps$CLEANED.DATETIME,
                                           tzone="Asia/Singapore")
  
  handheld_gps
}

# Process gps data files
match_gps_data <- function(mobile_gps, handheld_gps_file, skipped_rows) {
  # Read csv file as data frame
  handheld_gps = read.csv(handheld_gps_file, skip=skipped_rows)

  # Format time
  handheld_gps = format_handheld_time(handheld_gps)
  
  # Process each row in mobile gps data
  closest_idx <- apply(mobile_gps, 1, find_closest_idx, handheld_gps=handheld_gps)
  
  # Replace latitudes and longitudes based on closest indices
  mobile_gps$LATITUDE <- handheld_gps$lat[closest_idx]
  mobile_gps$LONGITUDE <- handheld_gps$lon[closest_idx]
  
  # Write dataframe to csv file
  write.csv(mobile_gps, "matched_gps.csv", row.names=FALSE)
}
