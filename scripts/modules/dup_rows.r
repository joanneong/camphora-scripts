######################################################################
# (\__/)
# (>'.'<)   Functions to duplicate rows based on manual ids
# (")_(")
######################################################################

# Substitute character(0) as an empty string for easy processing
sub_with_empty_string <- function(ids) {
  if (identical(ids, character(0))) {
    ''
  } else {
    ids
  }
}

# Duplicate rows based on manual ids
dup_rows_by_ids <- function(meta_file, delimiter) {
  # Read csv file as data frame
  meta_data = read.csv(meta_file)

  # Split manual ids by delimiter
  split_ids = strsplit(as.character(meta_data$MANUAL.ID), split=delimiter)
  split_ids = lapply(split_ids, sub_with_empty_string)

  # Get number of manual ids in each row
  repeat_freq = lengths(split_ids)

  # Duplicate rows based on number of manual ids
  expanded_meta_data <- meta_data[rep(row.names(meta_data), repeat_freq), ]
  
  # Replace manual ids in duplicated rows with split ids
  expanded_meta_data$MANUAL.ID <- unlist(split_ids)

  expanded_meta_data
}
