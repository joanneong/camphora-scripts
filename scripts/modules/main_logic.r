######################################################################
# (\__/)
# (>'.'<)   Script dependencies
# (")_(")
######################################################################

# Load other scripts for main logic
source(paste(WORKING_DIR, "scripts", "modules", "util.r", sep=SEPARATOR))
source(paste(WORKING_DIR, "scripts", "modules", "dup_rows.r", sep=SEPARATOR))
source(paste(WORKING_DIR, "scripts", "modules", "sort_bat_data.r", sep=SEPARATOR))
source(paste(WORKING_DIR, "scripts", "modules", "match_gps.r", sep=SEPARATOR))

######################################################################
# (\__/)
# (>'.'<)   Functions for main program logic
# (")_(")
######################################################################

# Process data in a single session folder
process_one_folder <- function(folder) {
    print("[INFO]: Duplicating rows based on manual ids...")
    expanded_meta = dup_rows_by_ids(META_FILE, DELIMITER)
    print("[INFO]: Checkpoint 1 - SUCCESS - Rows have been duplicated based on manual ids.")

    print("[INFO]: Checking for any duplicated <IN FILE, MANUAL ID>...")
    check_for_duplicates(expanded_meta)
    print("[INFO]: Checkpoint 2 - SUCCESS - No duplicate <IN FILE, MANUAL ID> found.")

    print("[INFO]: Sorting .wav files based on manual ids...")
    sort_wav_files(expanded_meta, WAV_FOLDER, OUTPUT_FOLDER, SEPARATOR)
    print("[INFO]: Checkpoint 3 - SUCCESS - .wav files have been sorted based on manual ids.")

    print("[INFO]: Matching GPS data...")
    match_gps_data(expanded_meta, META_FILE_DATE_FORMAT, HANDHELD_GPS_FILE, SKIPPED_ROWS)
    print("[INFO]: Checkpoint 4 - SUCCESS - GPS data has been matched.")
}

# Process data in all session folders
process_all_folders <- function() {
    # Get all folders in current directory
    folders = list.dirs(full.names=FALSE, recursive=FALSE)
    
    # Skip processing scripts folder
    folders = folders[folders != "scripts"]

    print("[INFO]: These folders will be processed:")
    print(folders)

    # Process each folder sequentially
    for (i in 1:length(folders)) {
        folder = folders[i]
        set_working_dir(paste(WORKING_DIR, folder, sep=SEPARATOR))
        process_one_folder(folder)
        print(paste("[INFO]: (", i, "/", length(folders), ") - SUCCESS - Finished processing", folder))
    }

    print("[INFO]: SUCCESS. All folders have been processed :)")
}

set_working_dir(WORKING_DIR)
process_all_folders()
