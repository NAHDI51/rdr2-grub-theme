#!/bin/bash


# This file handles output formatting and colorization of the console 
# output. This will take standard color codes of @background and
# @foreground, and output accordingly.

# dependency: include.sh
eval $START_INCLUDE_BASED_SYSTEM 2> /dev/null

# Dependencies
include_once 'src/colors/colors.sh' 'src/colors/prompt.sh'


# colorize_console: self explanatory, see $helpmsg for argument options.
colorize_output() {
    local helpmsg=("
        Usage: colorize_output [-options] ... [text] \n
        \n
        Colorize the output using various options. Call this function with the  \n
        background and foreground color operations specified. Additionally, the \n
        formatting options for the foreground text can be specified. \n
        \n
        OPERATIONS \n
        -B | --background [COLOR] \t          Format the background text \n
        -F | --foreground [COLOR] \t          Format the foreground text \n
        -h | --help \t \t \t                  Print this text \n
        -[FORMAT]   \t \t \t                  Formatizes the output (Check FORMATS) \n
        \n
        FORMATS\n
        -r | --regular \n 
        -b | --bold \n
        -f | --faint \n
        -i | --italics \n
        -u | --underlined \t  Underlines the text \n
        -l | --blinking \t    Text blinks \n
        \n
        \n
        COLORS\n
        --black      \t\t --red         \t\t\t --green        \n
        --yellow     \t\t --blue          \t\t --magneta      \n
        --cyan       \t\t --light-gray    \t\t --gray         \n
        --light-red  \t\t --light-green   \t\t --light-yellow \n
        --light-blue \t\t --light-magneta   \t --light-cyan   \n
        --white \n
        \n
        \n
        DEFAULTS \n
        FORMAT     = Regular \n
        COLOR      = White \n
        Foreground = White regular text \n
        Background = No background \n
        \n
        NOTES \n
        1. You must call the color flag if you call the -B or -F flags. Calling \n
        -B or -F without --color, or calling --color without -B or -F will result in \n
        a warning that the specified option will be omitted. \n
        2. help message immediately terminates the program. Thus, do not call any \n
        other flags with --help. \n
        3. Multiple format specification is not yet implemented. For instance, you \n
        cannot call --bold and --italics simultaneously. calling so will result in a \n
        warning, and a potential error. \n
    ")

    #Stores the arguments called
    # echo $#

    # Damn this control flow prove to be a real pain in the ass
    local ARGS=()
    local ARG=''
    for ARG in "$@"
    do
        #append ARGS
        ARGS[${#ARGS[@]}]=$ARG
    done

    # Print ARGS
    # for ((i=0; i<${#ARGS[@]}; i++))
    # do
    #   echo -e "$i ${ARGS[i]}"
    # done

    # Parse the arguments 
    local FGCOL=0
    local BGCOL=0
    local FORM=-1
    local i=0 
    for  ((i=0; i<$#; i++)); do
        local GROUND=-1
        local COLOR=""
        local FORMAT="-1"
        local errmsg
        local prev_i=$i


        case ${ARGS[i]} in
            "-h" | "--help")
                echo -e $helpmsg
                return 0
                ;;

            "-B" | "--background")
                GROUND=$BG_MODE
                ;;

            "-F" | "--foreground")
                GROUND=$FG_MODE 
                ;;
            
            # Formats
            "-r" | "--regular")
                FORMAT=$REGULAR
                ;;
            "-b" | "--bold")
                FORMAT=$BOLD
                ;;
            "-f" | "--faint")
                FORMAT=$FAINT
                ;;
            "-i" | "--italics")
                FORMAT=$ITALICS
                ;;
            "-u" | "--underlined")
                FORMAT=$UNDERLINED
                ;;
            "-l" | "--blinking")
                FORMAT=$BLINKING
                ;;
            *)
            # There might be some calling error if it reaches this part of the 
            # function. In that case, we must warn the caller that the call had
            # some flaws. We will also give them general troubleshooting directions.

            # Firstly, if the argument is the last of the arguments, it is for printing.
            local tmp=$#
            let "tmp--"
            let "tmp--"
            
            if [[ "$i" -ge "$tmp" ]]; then
                break
            fi

errmsg=("colorize_output:

Ignoring argument '${ARGS[i]}' in position '${i}': No general specifier
specified.

Possible Reasons:

1. This option doesn't exist. Check if you have done any typing error,
or any similar errors in general. Run 'colorize_output --help' for
viewing the list of available commands. 

2. You may not have specified foreground or background [-F or -B] prior 
to calling this specifier.

3. You may have called the arguments with wrong ordering. The general 
ordering is:

colorize_output [OPTION] [FORMAT] [COLOR]
")
            #This error is not fatal, although it may output wrong colors. 
            prompt -w "Warning: \n"
            echo -e "$errmsg"
            continue

            ;;
        esac

        # The argument has been used, otherwise it won't reach this part of the
        # function 

        let "i++"

        #3 
        # echo "${ARGS[i]} $i $GROUND"
        # Sub-specifiers

        local TOGGLE=0
        # Sub color specifiers for foreground and background
        if (( GROUND != -1 )); then
            TOGGLE=1
            case ${ARGS[i]} in
                "--black") 
                    COLOR=${BLACK[GROUND]} ;;
                "--red")
                    COLOR=${RED[GROUND]} ;;
                "--green")
                    COLOR=${GREEN[GROUND]} ;;
                "--yellow")
                    COLOR=${YELLOW[GROUND]} ;;
                "--blue")
                    COLOR=${BLUE[GROUND]} ;;
                "--magneta")
                    COLOR=${MAGNETA[GROUND]} ;;
                "--cyan")
                    COLOR=${CYAN[GROUND]} ;;
                "--light-gray")
                    COLOR=${LGRAY[GORUND]} ;;
                "--gray")
                    COLOR=${GRAY[GROUND]} ;;
                "--light-red")
                    COLOR=${LRED[GROUND]} ;;
                "--light-green")
                    COLOR=${LGREEN[GROUND]} ;;
                "--light-yellow")
                    COLOR=${LYELLLOW[GROUND]} ;;
                "--light-blue")
                    COLOR=${LBLUE[GROUND]} ;;
                "--light-magneta")
                    COLOR=${LMAGNETA[GROUND]} ;;
                "--light-cyan")
                    COLOR=${LCYAN[GROUND]} ;;
                "--white")
                    COLOR=${WHITE[GROUND]} ;;
                *)     
                    let "i--"
                    errmsg=("
                    colorize_output: Color not spcified with the argument "${ARGS[i]}". Omitting the argument.
                    ")
                    prompt --warning "Warning: "
                    prompt "$errmsg"
                    prompt "\n"
                    continue
            esac

            # The sub option must be used
            if (( TOGGLE == 1 )); then
                let "i++"
            fi
            # Reset
            TOGGLE=0

            # Note that these functions are called if and only if the current
            # iteration is a specifier iteration. 

            # Prompts if any of the modes go wrong
            errmsg=("
                colorize_output: Multiple calling and specification of argument FOREGROUND/BACKGROUND. Omitting the argument.
                ")

            case "$GROUND" in

                "$BG_MODE")
                    if [[ $(echo -en $BGCOL) -eq "0" ]]; then
                        BGCOL=${COLOR}
                    
                    # Multiple call, redundancy error 
                    else
                        let "i--"
                        prompt --warning "WARNING: "
                        prompt "$errmsg"
                        prompt "\n"

                        continue
                    fi
                    ;;

                "$FG_MODE")
                    if [[ $(echo -en $FGCOL) -eq "0" ]]; then
                        FGCOL="${COLOR}"

                    # Multiple call, redundancy error 
                    else 
                        let "i--"
                        prompt --warning "WARNING: "
                        prompt "$errmsg"
                        prompt "\n"

                        continue
                    fi
                    ;;
            esac          
        fi

        errmsg=("
            colorize_output: Multiple calling and specification of argument FORMAT. Omitting the argument.\n
        ")  

        if [[ "$FORMAT" -ne "-1" ]]; then

            # Checks whether format has been specified before. 
            # If yes, then the argument is omitted.
            # Else, the argument is used.

            # While the argument is omitted, it does not abort the function.

            if [[ "$FORM" -ne "-1" ]]; then
                let "i--"
                prompt --warning "WARNING: "
                prompt "$errmsg"
                prompt "\n"

                continue
            fi
            FORM="${FORMAT}"
        fi
        
        # Offset
        let "i--"
    done

    # Last wrap around: if any of the options are not specified

    local FINAL=""
    if (( FORM != -1 )); then
        FINAL+="$FORM;"
    fi
    
    if (( BGCOL != 0 )); then
        FINAL+="$BGCOL;"
    fi 

    if (( FGCOL != 0 )); then
        FINAL+="$FGCOL"
    
    else 
        FINAL+="${WHITE[0]}"
    fi

    # echo -e "$BGCOL $FGCOL"
    local last=$#
    let "last--"
    OUTPUT=${ARGS[last]}  
    
    # This line is omitted because it was causing some semi-colon errors
    # when the other forms aren't called.

    # echo -en "${BEGCOL}${FORM};${BGCOL};${FGCOL}m${OUTPUT}${ENDCOL}"
    echo -en "${BEGCOL}${FINAL}m${OUTPUT}${ENDCOL}"
}
