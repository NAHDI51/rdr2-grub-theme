# A list of useful code blocks, which can be used universally. 
# These variables can be used in a variety of ways, including 
# just by using the command eval.

eval $START_INCLUDE_BASED_SYSTEM 2> /dev/null
include 'src/colors/prompt.sh'

# Prints helpmsg with the according arguments, if asked. 
PRINT_HELPMSG=('
    case "$1" in 
        "-h" | "--help" | "--Help" )
            prompt -i "$helpmsg"
            return 0
            ;;
    esac
')

# A global helper variable that stores the last returned value of
# a non-void variable. this variable is introducted due to the fact
# that bash functions cannot return non-integer values: they are
# designed for diplsaying program status.

# Also note that, for non-interactive functions, you can simply 
# do echo, an store the variable using substitution. This is a solid
# alternative, as it creates an almost identical return-value facade.

RETURN_VALUE=''

# A variable exclusively written for the rdr2-grub-theme project.
HAS_THEME_FILE='
compfunc() {
    # ENTRY is a directory, and it has a file called theme.txt
    if [ -d "$ENTRY" ] && [ -n "$(find "$ENTRY" -maxdepth 1 -type f -name "theme.txt" -print -quit)" ]; then
        return 0
    else
        # echo "Readhed here"
        return 1
    fi
}
'
# A variable exclusively written for the rdr2-grub-theme project.
IS_BACKGROUND_IMAGE='
compfunc() {
    if [[ $ENTRY == *.jpg || $ENTRY == *.jpeg || $ENTRY == *.png ]]; then 
        return 0
    else 
        return 1
    fi 
}
'

# If the called function is beyond argument boundaries
check_err_arg_num() {
    local helpmsg=('
SYNTAX: check_err_org_num [NUMBER] [MIN] [MAX]

This function checks whether the argument number is within MIN and MAX.
If not, this function returns an error, and error handling is up to the 
user of the function.

By default, MAX is set to 100000000, i.e, a really big number. Similarly,
MIN is set to 0.
')

    eval $PRINT_HELPMSG

    #Invalid number of arguments in itself
    if [[ $# -lt 1 || $# -gt 3 ]]; then
        prompt -e "Error: Invalid number of arguments.\n"
        echo "$helpmsg"
        return 1
    fi

    local NUMBER=$1
    local LOW=${2:-0}
    local HIGH=${3:-100000000}

    if (( $LOW <= $NUMBER && $NUMBER <= $HIGH )); then
        return 0
    else
        return 1
    fi

}

# apprently bash has some problem assigning array: it converts an array to string. 
# However, passing to an array argument splits them by blank spaces. 

# Thus, to circumvent this problem, I have written a function that will pass 
# the entire array, then I can return the index I desire. 

# The downside? The time complexity is absurdly huge, a whooping O(N) (because bash
# doesn't support call by reference). But I guess this is negligible because this 
# script will not be used for extreme cases. 

# A non-negligible downside? It cannot parse spaces. I guess this is one potential
# bash limitation, as it's hell passing these stuffs around functions.

get_index() {
    check_err_arg_num $# 2
    if (( $? == 1 )); then
        colorize_output -F --red "$LOG_HEADER: ERROR: Incorrect number of arguments. Returning with exit status 127.\n"
        return 127
    fi

    helpmsg=('
SYNTAX: get_index $INDEX ${ARR[@]}

NOTE: never call $ARR using quotes (e.g: "${ARR[@]}").
')

    eval $PRINT_HELPMSG

    local INDEX=$1
    shift

    # Index is not an integer.
    if [[ ! $INDEX =~ ^[0-9]+$ ]]; then
        prompt -e "Error: INDEX is not an integer. Returning with error code -1. \n"
        return -1 
    fi

    local -a ARR=("$@")

    # Validate array index.
    if (( INDEX < 0 || INDEX >= ${#ARR[@]} )); then
        prompt -e "Error: Invalid array index. Returning with exit status 1. \n"
        return 1
    fi

    echo "${ARR[INDEX]}"
}

# checks whether a command is available
function has_command() {
  command -v $1 > /dev/null
}
