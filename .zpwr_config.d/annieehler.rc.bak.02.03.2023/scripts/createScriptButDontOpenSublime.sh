#!/usr/bin/env bash
#{{{                    MARK:Header
#**************************************************************
##### Author: JACOBMENKE
##### Date: Mon Jul 10 12:13:53 EDT 2017
##### Purpose: bash script to add shebang line to new script file
##### Notes:
#}}}***********************************************************

function executableScriptsProcessing() {

    # then make it executable
    chmod 700 "$newfile"
    #add hr	echo "#created by JAKOBMENKE --> `date` " >> "$newfile"
    #and open file
    openTextEditor
}

function openTextEditor() {

    # open -t "$newfile"
    subl "$newfile/dogs"
    #run python3 script with pyautogi commands for keyboard shortcuts
    python3 "$HOME/PycharmProjects/textEditorTwoColumns.py"
}

function createTheFile() {

    #create newfile
    touch "$newfile"

    #echo shebang line into newfile
    case "$1" in
    .sh) echo "#!$HOMEBREW_PREFIX/bin/bash" >"$newfile" ;;
    .pl) echo "#!$HOMEBREW_PREFIX/bin/perl" >"$newfile" ;;
    .rb) echo "#!/usr/bin/env ruby" >"$newfile" ;;
    .py) echo "#!/Library/Frameworks/Python.framework/Versions/3.5/bin/python3" >"$newfile" ;;
    #if .txt or some other file ending then just open the file, no processing
    #exit so do not call executableScriptsProcessing
    *) subl "$newfile" && exit ;;
    esac

    executableScriptsProcessing

}

if [[ -z "$1" ]]; then
    echo "usage: createScriptButDontOpenSublime.sh <file>" >&2
    exit 1
fi

#file name is the first argument
newfile="$1"

if [[ -s "$newfile" ]]; then
    openTextEditor
    exit
fi

#check ending on file name and call createTheFile passing in argument for file ending
if [[ "$newfile" =~ .*\.sh ]]; then
    createTheFile .sh
elif [[ "$newfile" =~ .*\.pl ]]; then
    createTheFile .pl
elif [[ "$newfile" =~ .*\.rb ]]; then
    createTheFile .rb
elif [[ "$newfile" =~ .*\.py ]]; then
    createTheFile .py
elif [[ "$newfile" =~ .*\.txt ]]; then #.txt
    createTheFile .txt
elif [[ "$newfile" =~ .*\..* ]]; then # a file ending that we do not want to process
    createTheFile
else
    #if no file ending default to text file
    #construct file with ending of .txt
    newfile="$newfile.txt"

    createTheFile .txt
fi
