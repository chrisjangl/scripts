#! /bin/bash
# Some notes on how to style text in the terminal

# General Info
# `-e` is required to enable escape sequences. Then we can escape certain characters that will allow us to tell the terminal how to format and style output
# more info can be found here: https://misc.flogisoft.com/bash/tip_colors_and_formatting

# will show the words "Colored Text" in blue, on a green background
echo -e "\033[34;42mColored Text\033[0m"
# `Colored Text`

# Breakdown
# `\033[34;42m` is one of the escaped sequences in the string above
# - `\033` is the ANSI code for ESCAPE, also represented by \e or \x1B (although not in all environments)
# - `[` starts the formating 
# - `34;42` is the actual formatting code (see references for a listing of the formatting codes)
# - `m` ends the formating
# `Colored Text` is the the text that we want formatted
# `\033[0m` is another escaped sequence: `\033[` tells the shell that we're going to give some formatting, `0` represents how we want the text formatted, and then `m` tells the shell we're done. In this example, `0` means no special formatting
# putting it all together, we have `\033m[34;42m` (format the following blue on green bg) `Colored Text` (the text) `\033[0m` (stop any special formatting)


# print "Error: ", bold & underlined in red, with black background. Reset (so we get ride of bold & underline in this particular example), then print "Something went wrong." in red, black background. Then reset again, so any further command doesn't get formatted.
echo -e "\033[1;4;31;40mError: \033[0m\033[31;40mSomething went wrong.\033[0m"

# using variables
# The example above is pretty unwieldy. We can set the specific formatting strings to variables to make it a little easier to set up, read/comprehend and avoid mistakes
boldredunderline="\033[1;4;31;40m"
red="\033[31;40m"
none="\033[0m"
echo -e $boldredunderline"Error: "$none$red"Something went wrong."$none

# Styled text (tput)
# more verbose, but more comprehensible. What's nice is that colors have the same number representation when used as foreground or background. When being used in variable, we'll need to use command substitution: `$( )`
# for more info, see the man page for terminfo: `man terminfo`
# more info can be found here: https://www.gnu.org/software/termutils/manual/termutils-2.0/html_chapter/tput_1.html
boldred=$(tput setab 0; tput setaf 1; tput bold)
red=$(tput setab 0; tput setaf 1)
none=$(tput sgr0)
echo -e $boldred"asdfaf: "$none$red"Something went wrong."$none

