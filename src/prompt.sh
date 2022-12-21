#!/bin/bash

# This file handles output formatting and colorization of the console 
# output. This will take standard color codes of @background and
# @foreground, and output accordingly. Prompt 
# 
# 
# 

# define header: __PROMPT_SH
if [[ $(echo -en $__PROMPT_SH) -eq "" ]]; then
__PROMPT_SH="1"
fi

# dependency: include.sh
. $(dirname "$0")/src/include.sh

# Dependencies

if [[ $(echo -en $__COLORS_SH) -eq "" ]]; then
include 'src/colors.sh'
fi



# colorize_console: self explanatory, see $helpmsg for argument options.

colorize_output() {
    local helpmsg=("
        Usage: colorize_output [-options] ... [text] \n
        \n
        Colorize the output using various options. Call this function with the  \n
        background and foreground color operations specified. Additionally, the \n
        formatting options can 
        \n
        OPERATIONS \n
        -B | --background [FORMAT] [COLOR] \t Format the background text \n
        -F | --foreground [FORMAT] [COLOR] \t Format the foreground text \n
        -h | --help \t \t \t \t               Print this text \n
        \n
        [Note] Do not rearrange this structure when calling the function. For \n
        example, calling COLOR before FORMAT will result in an error. However, \n
        OMITTING one or multiple option is okay. \n
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
        COLORS\nneofetch
        --black \n
        --red \n
        --green \n 
        --yellow \n
        --blue \n
        --magneta \n
        --cyan \n
        --light-gray \n
        --gray \n
        --light-red \n
        --light-green \n
        --light-yellow \n
        --light-blue \n
        --light-magneta \n
        --light-cyan \n
        --white \n
        \n
        \n
        DEFAULTS \n
        FORMAT     = Regular \n
        COLOR      = White \n
        Foreground = White regular text \n
        Background = No background \n
    ")

    #Stores the arguments called
    # echo $#
    ARGS=()
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

    #HIERARCHY

    # 1. Help will always come first. This is a way to ensure that it doesn't 
    #    overlap with the other arguments.

    # 2. Then comes foreground/background option. Any specifier coming before
    #    it leads to termination of the function, with return 1.

    # 3. After bg/fg is specified, we will parse the options with specified
    #    arguments: FORMAT and COLOR, taking defaults wherever needed.

    #    Note that rearrangement of the options is not implemented. If you want
    #    to implement it, just keep reading the arguments till the next major
    #    argument (-B and -F in this case), and create an array of all the possible
    #    specifier of a certain mode (e.g -r, -b, -f, -i, -u, and -l for FORMAT). 
    #    Then, match the array, and the number of arguments, with appropriate
    #    specifiers, and parse.

    #    Similarly, you can write an amortized algorithm. Regardless, the details
    #    are redundant for the scope of this code right now. 


    # Parse the arguments 
    FGCOL="DEFAULT"
    BGCOL="DEFAULT"

    for  (( i=0; i<$#; i++))
    do
        local GROUND=-1
        local COLOR=""
        local FORMAT=""
        local errmsg
        local prev_i=$i

        #1
        case ${ARGS[i]} in
            "-h" | "--help")
                echo -e $helpmsg
                return 0
                ;;
        esac

        #2 
        case ${ARGS[i]} in
            "-B" | "--background")
                GROUND=$BG_MODE
                let "i++"
                ;;
            "-F" | "--foreground")
                GROUND=$FG_MODE 
                let "i++"
                ;;
        esac

        #3 
        # echo "${ARGS[i]} $i $GROUND"
        # Sub-specifiers

        if [[ "$GROUND" -ne "-1" ]]; then

            local toggle=0
            case ${ARGS[i]} in 
                "-r" | "--regular")
                    FORMAT=$REGULAR ;;
                "-b" | "--bold")
                    FORMAT=$BOLD ;;
                "-f" | "--faint")
                    FORMAT=$FAINT ;;
                "-i" | "--italics")
                    FORMAT=$ITALICS ;;
                "-u" | "--underlined")
                    FORMAT=$UNDERLINED ;;
                "-l" | "--blinking")
                    FORMAT=$BLINKING ;;
                *)     
                    toggle=1
                    FORMAT=$REGULAR ;;
            esac

            # Check if the argument has been used
            if [[ "$toggle" -eq "0" ]]; then 
                let "i++"
            fi

            toggle=0
            # echo ${ARGS[i]}
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
                    toggle=1
                    if [[ GROUND==BG_MODE ]]; then
            
                    #Change these lines to change your default background color
                        COLOR=""
                        FORMAT=""
                    elif [[ GROUND==FG_MODE ]]; then

                    # Change this line to change your default foreground color
                        COLOR=${WHITE[GROUND]}

                    fi
            esac


            # Check if the argument has been used
            if [[ "$toggle" -eq "0" ]]; then 
                let "i++"
            fi

            # Note that these functions are called if and only if the current
            # iteration is a specifier iteration. 

            errmsg=("
                colorize_output: Multiple calling and specification of argument \n
                '${ARGS[i]}'. Aborting function. \n
            ")

            case "$GROUND" in
                "$BG_MODE")
                    if [[ $(echo -en $BGCOL) -eq "DEFAULT" ]]; then
                        BGCOL="${FORMAT};${COLOR}"
                    
                    # Multiple call, redundancy error 
                    else
                        prompt -e "ERROR: "
                        prompt $errmsg

                        return 1
                    fi
                    ;;
                "$FG_MODE")
                    if [[ $(echo -en $FGCOL) -eq "DEFAULT" ]]; then
                        FGCOL="${FORMAT};${COLOR}"

                    # Multiple call, redundancy error 
                    else 
                        prompt -e "ERROR: "
                        prompt $errmsg 

                        return 1
                    fi
                    ;;
            esac

            if (( prev_i != i )); then
                let "i--"
            fi

        else 

        # There might be some calling error if it reaches this part of the 
        # function. In that case, we must warn the caller that the call had
        # some flaws. We will also give them general troubleshooting directions.

        # Firstly, if the argument is the last of the arguments, it is for printing.
        local tmp=$#
        let "tmp--"
        
        if [[ "$i" -ge "$tmp" ]]; then
            break
        fi

    errmsg=("
        colorize_output: \n
        Ignoring argument '${ARGS[i]}' in position '${i}': No general specifier \n
        specified. \n
        \n
        Possible Reasons: \n
        1. This option doesn't exist. Check if you have done any typing error, \n
        or any similar errors in general. Run 'colorize_output --help' for \n
        viewing the list of available commands. \n
        2. You may not have specified foreground or background [-F or -B] prior \n
        to calling this specifier. \n
        3. You may have called the arguments with wrong ordering. The general \n
        ordering is: \n
        colorize_output [-OPTION] [FORMAT] [COLOR] \n
    ")

        #This error is not fatal, although it may output wrong colors. 
        prompt -w "Warning: "
        prompt "$errmsg"

        fi
    done


    # Last wrap around: if any of the options are not specified

    if [[ $(echo -en "$FGCOL") -eq "DEFAULT" ]]; then
        FGCOL=""
    fi

    if [[ $(echo -en "$BGCOL") -eq "DEFAULT" ]]; then
        BGCOL=""
    fi


    # echo -e "$BGCOL $FGCOL"
    local last=$#
    let "last--"
    OUTPUT=${ARGS[last]}   
    echo -e "$BGCOL;$FGCOLm"
    echo -en "${BEGCOL}${BGCOL};${FGCOL}m${OUTPUT}${ENDCOL}"
}

# A generalized wrapper for colorize_output. Outputs messages
# according to their indication (e.g info, error, warning). See
# helpmsg for more details

prompt() {
    local helpmsg=("
        Usage: prompt [MODE] [STATEMENT]\n
        \n
        This is a generalized wrapper for colorize_output. Output specific \n
        indicative messages (e.g info, error, warning). \n
        \n
        This program assumes the first argument to be the mode, and the second \n
        argument to be the statement. \n
        \n
        MODES \n
        -h | --help  \t\t Displays this message. \n
        -e | --error \t\t Indicates that the following message is an ERROR prompt. \n
        -i | --info  \t\t Indicates that the following message is an INFO prompt. \n
        -w | --warning \t Indicates that the following message is a WARNING prompt. \n
        -s | --success \t Indicates that the following message is a SUCCESS prompt. \n    
        -c | --caution \t Indicates that the following message is a CATUIONARY prompt. \n
        \n
        DEFAULTS \n
        1. Error prompt prints the prompt in BOLD RED. \n
        2. Info prompt prints the prompt in LIGHT GRAY. \n
        3. Warning prompt prints the prompt in yellow. \n 
        4. Success prompt prints the prompt in GREEN. \n
        5. Default prompt prints the prompt in WHITE. \n
        6. Caution prompt blinks the background in RED, while prints the prompt \n
           in WHITE. \n
        \n
        For the time being, no argument-through changing of the defaults \n
        is implemented. Thus, if you want to change, do it through the color \n
        flags being called in below. \n
        \n
    ")
    case $1 in 
        "-h" | "--help")
            echo -e "$helpmsg" ;;
        "-e" | "--error")
            colorize_output -F -r --red "$2" ;;
        "-i" | "--info")
            colorize_output -F -r --light-gray "$2" ;;
        "-w" | "--warning")
            colorize_output -F -b --yellow "$2" ;;
        "-s" | "--success")
            colorize_output -F -b --light-green "$2" ;;
        "-c" | "--caution")
            colorize_output -B -b --light-red -F -r --white "$2" ;;
        *)
            echo -ne "$1" ;;
    esac

    return 0
}