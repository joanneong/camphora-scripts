######################################################################
# (\__/)
# (>'.'<)   Utility functions (non task-specific functions)
# (")_(")
######################################################################

# Set the working directory
set_working_dir <- function(working_dir) {
  # Set the working directory
  setwd(working_dir)
  
  # Double check the current working directory
  print(paste("[INFO]: Current working directory set to:", getwd()))
}

# Check whether there are duplicate combinations of <IN FILE, MANUAL ID>
check_for_duplicates <- function(meta_data) {
    # Specify combination of columns to check for duplicates
    cols_to_check = c('IN.FILE', 'MANUAL.ID')
    duplicates = meta_data[duplicated(meta_data[cols_to_check]),]
    
    # Print the duplicate(s) and exit the program if any duplicate(s) is/are found
    if (nrow(duplicates) >= 1) {
        print(duplicates[cols_to_check])
        stop(paste("[ERROR]: There are duplicates in the meta file.",
                   "Please check the duplicates found above."))
    }
}
