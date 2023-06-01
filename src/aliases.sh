# A list of useful code blocks, which can be used universally. 
# These variables can be used in a variety of ways, including 
# just by using the command eval.

# Header tag
if [[ "$__ALIASES_SH" -ne "1" ]]; then 
    __ALIASES_SH=1
fi

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
