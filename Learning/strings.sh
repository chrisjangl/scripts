#! /bin/bash
# Examples of working with strings



## Concatenation
a="hello"
b="world"

c=$a$ab
echo $c

## Substrings
# returns a string starting at the 3rd character of $c (0-based)
echo ${c:3}

# returns a string starting at the 3rd character of $c (0-based), and then goes for 4 characters
echo ${c:3:4}

# returns the last 4 characters of $c
echo ${c: -4}

# returns a string starting at 4th from last character, and then going for 3 characters
echo ${c: -4:3}

## String manipulation
fruit="apple banana banana cherry"

### replace text
# format accepts the string we want to manipulate/term we want to replace/term to replace with
# note there are no spaces between slashes
# notes that only the first instance of the search term will be replaced
echo ${fruit/banana/durian}
# `apple durian banana cherry`

# to replace all instances of the search term, use // before the search term
echo ${fruit//banana/durian}
# `apple durian durian cherry`

# to replace the search term *only* if it's at the beginning of the string, preface it with # (pound or hash)
# this will replace apple with durian, because apple is at the start of the string
echo ${fruit/#apple/durian}
# `durian banana banana cherry`
# this will *not* replace banana with durian, because banana is not at the start of the string
echo ${fruit/#banana/durian}
# `apple banana banana cherry`

# to replace the serach term only if it's at the *end* of a string, preface it with % (percent)
# this will replace cherry with durian, because cherry is at the end of the string
echo ${fruit/%cherry/durian}
# `apple banana banana durian`
# this will *not* replace banana with durian, because banana is not at the end of the string
echo ${fruit/%banana/durian}
# `apple banana banana cherry`