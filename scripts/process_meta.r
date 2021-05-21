######################################################################
#  (\__/)
# \(>'.'<)/   Variables to customise
#  (")_(")
######################################################################

# TODO: Set full absolute path to your working directory
WORKING_DIR = "/Users/joanneong/Desktop/working_dir"

# OPTIONAL: Specify name of meta file
META_FILE = "meta.csv"

# OPTIONAL: Specify delimiter used for manual ids
DELIMITER = "_"

# OPTIONAL: Specify name of folder containing .wav files
WAV_FOLDER = "wav_files"

# OPTIONAL: Specify name of output folder (for sorted .wav folders)
OUTPUT_FOLDER = "out"

# OPTIONAL: Specify name of handheld gps data file
HANDHELD_GPS_FILE = "handheld.csv"

# OPTIONAL: Specify number of rows before actual GPS data
# in handheld GPS data file (to skip processing these data)
SKIPPED_ROWS = 42

######################################################################
# (\__/)
# (>'.'<)   Utility functions (non-task-specific functions)
# (")_(")
######################################################################

# Determine whether filepaths should be "xx/xx" (Unix) or "yy\yy" (Windows)
get_separator <- function() {
    if (.Platform$OS.type == "unix") {
        separator <- "/"
    } else {
        # Escape for special character
        separator <- "\\"
    }
    return(separator)
}

######################################################################
# (\__/)
# (>'.'<)   Global variables
# (")_(")
######################################################################

SEPARATOR = get_separator()

######################################################################
# (\__/)
# (>'.'<)   Script dependencies
# (")_(")
######################################################################

# Load script for main logic
source(paste(WORKING_DIR, "scripts", "modules", "main_logic.r", sep=SEPARATOR))
