# A list of useful code blocks, which can be used universally. 
# These variables can be used in a variety of ways, including 
# just by using the command eval.

# Header tag
if [[ "$__ALIASES_SH" -ne "1" ]]; then 
    __ALIASES_SH=1
fi

PRINT_HELPMSG=('
    case "$1" in 
        "-h" | "--help" | "--Help" )
            prompt -i "$helpmsg"
            return 0
            ;;
    esac
')

