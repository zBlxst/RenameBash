# Auto rename files

This is a little school project for an Advanced Scripts class.

# How to use

./rename.sh [OPTIONS]... "\<command\>" files

Examples:

// Reverses all the file names, asking for confirmation

$ ./rename.sh -q -v "rev" *


// Removes all file extensions

$ ./rename.sh "rev | cut –d. -f2- | rev" *

// Replace the initial of all files starting with "a." with an uppercase 

$ ./rename.sh 'awk '\\''\{print toupper(substr(\$0, 1, 1)) substr(\$0, 2)\}'\\''' a.*

