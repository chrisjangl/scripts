#!/bin/bash
# Sample script to demonstrate the creation of an HTML report using shell scripting
# Web directory
WEB_DIR=./
# A little CSS and table layout to make the report look a little nicer
echo "<HTML>
<HEAD>
    <style>
        html {
            background-color: #fdfdfd;
        }
        h1, h2, h3 {
            color: #3e7fe3;
        }
        h3 {
            font-weight: 500;
        }
        
        /* Trial 1 */
        .trial1 {
            font-family: 'Open Sans', sans-serif;
        }
        .trial1 h1, trial1 .h2, .trial1 h3 {
            font-family: 'Open Sans Condensed', sans-serif;
        }
        
        /* Trial 2 */
        .trial2 {
            font-family: 'EB Garamond', serif;
        }
        .trial2 h1, .trial2 h2, .trial2 h3 {
            font-family: 'Oswald', sans-serif;
        }
        
        /* Trial 3 */
        .trial3 {
            font-family: 'Merriweather Sans', sans-serif;
            color: #3f3f3f;

        }
        .trial3 h1, .trial3 h2, .trial3 h3 {
            font-family: 'Montserrat', sans-serif;
        }
        
        /* Trial 4 */
        .trial4 {
            font-family: 'Roboto Slab', serif;
        }
        .trial4 h1, .trial4 h2, .trial4 h3 {
            font-family: 'Raleway', sans-serif;
        }
        
        /* Trial 5 */
        .trial5 {
            font-family: 'Source Sans Pro', sans-serif;
        }
        .trial5 h1, .trial5 h2, .trial5 h3 {
            font-family: 'Playfair Display', serif;
        }
    
        ul {
            list-style-type: none;
        }
        .fa-check-square {
            color: green;
        }
        .fa-minus-circle {
            color: red;
        }
    </style>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
    <script src=\"https://kit.fontawesome.com/678246634d.js\" crossorigin=\"anonymous\"></script>
    <link href=\"https://fonts.googleapis.com/css?family=DM+Serif+Display|EB+Garamond|Merriweather+Sans|Montserrat|Open+Sans|Open+Sans+Condensed:300|Oswald|Playfair+Display|Raleway|Roboto+Condensed|Roboto+Slab|Source+Sans+Pro&display=swap\" rel=\"stylesheet\">
</HEAD>
<BODY class=\"trial3\">" > $WEB_DIR/report.html
# Core
echo "<h2>Core Updates</h2>" >> $WEB_DIR/report.html
echo "<ul>" >> $WEB_DIR/report.html
    echo "<li>" >> $WEB_DIR/report.html
        cat core.txt >> $WEB_DIR/report.html
    echo "</li>" >> $WEB_DIR/report.html
echo "</ul>" >> $WEB_DIR/report.html

# Plugins
echo "<h2>Plugins</h2>" >> $WEB_DIR/report.html

## updated plugins
echo "<h3>Updated</h3>" >> $WEB_DIR/report.html
echo "<ul class=\"fa-ul\">" >> $WEB_DIR/report.html
while read updated
do 
    echo "<li>
            <span class=\"fa-li\"><i class=\"far fa-check-square\"></i></span>
            $updated 
        </li>" >>$WEB_DIR/report.html
done < updated-plugins.txt
echo "</ul>" >> $WEB_DIR/report.html

## skipped plugins
echo "<h3>Skipped</h3>" >> $WEB_DIR/report.html
echo "<ul class=\"skipped fa-ul\">" >> $WEB_DIR/report.html
while read skipped
do 
    echo "<li>
            <span class=\"fa-li\"><i class=\"far fa-minus-circle\"></i></span>
            $skipped 
        </li>" >>$WEB_DIR/report.html
done < skipped-plugins.txt
echo "</ul>" >> $WEB_DIR/report.html

# Themes
echo "<h2>Theme</h2>" >> $WEB_DIR/report.html
echo "<ul>" >> $WEB_DIR/report.html
    echo "<li>" >> $WEB_DIR/report.html
        cat theme.txt >> $WEB_DIR/report.html
    echo "</li>" >> $WEB_DIR/report.html
echo "</ul>" >> $WEB_DIR/report.html
