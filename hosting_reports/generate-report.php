<?php
/**
 * Monthly hosting report for Social Digital hosting updates
 * 
 * @version 1.2
 * 
 * @param site_info.txt
 * @param account-notices.txt
 * @param core.txt
 * @param updated-plugins.txt
 * @param skipped-plugins.txt
 * @param theme.txt
 * kinda....
 * 
 */

 function maybe_load_report( $report ) {
     if ( ! $report ) 
        return false;

    $report_override = $report . '-override.txt';
    $report = $report . '.txt';

    if ( file_exists( $report_override  ) ) {
        return file( $report_override );
    } else if ( file_exists( $report ) ) {
        return file( $report );
    } else {
        return false;
    }
 }

?>
<HTML>
    <head>
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
        <script src="https://kit.fontawesome.com/678246634d.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css?family=DM+Serif+Display|EB+Garamond|Merriweather+Sans|Montserrat|Open+Sans|Open+Sans+Condensed:300|Oswald|Playfair+Display|Raleway|Roboto+Condensed|Roboto+Slab|Source+Sans+Pro&display=swap" rel="stylesheet">

        <?php
        $style = "
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
    
                /* Trial 3 */
                .trial3 {
                    font-family: 'Merriweather Sans', sans-serif;
                    color: #3f3f3f;
    
                }
                .trial3 h1, .trial3 h2, .trial3 h3 {
                    font-family: 'Montserrat', sans-serif;
                }
        
                ul {
                    list-style-type: none;
                }

                ul.account-notices li {
                    margin-bottom: 0.8rem;
                }

                .fa-exclamation-triangle {
                    color: #E7C101;
                }
                .fa-check-square {
                    color: green;
                }
                .fa-minus-circle {
                    color: red;
                }
            </style>
        ";

        echo $style;
        ?>
        
    </head>

    <body class="trial3">

        <?php

        // create date label
        $month = date('F');
        $year = date('Y');

        // check for URL query parameters to be able to generate for another month
        if ( isset($_GET['month']) ){
            $date = $_GET['month'];
        } else {
            $date = "$month, $year";
        }

    // Site info
    if ( file_exists( 'site_info.txt' ) ) {

        $site = file('site_info.txt');  
        echo "<h1>" . $site[0] . " Updates - $date</h1>";

    }

    
    // account notices
    if ( file_exists( 'account-notices.txt' ) ) {

        $notices = file( 'account-notices.txt' );

        echo "<h2 style=\"text-transform: uppercase; text-decoration: underline;\">Account notices for the month</h2>";

        echo "<ul class=\"fa-ul account-notices\">";
        foreach ( $notices as $notice ) {

            echo "<li>";
                echo "<span class=\"fa-li\"><i class=\"far fa-exclamation-triangle\"></i></span>";
                echo $notice;
            echo "</li>";

        }

        echo "</ul>";

    }
    
    // Core
    if ( $core_updates = maybe_load_report('core') ) {

        if ( $core_updates ) {

            echo "<h2>Core Updates</h2>";

            echo "<ul class=\"blank\">";

            foreach ( $core_updates as $core_update ) {

                echo "<li>";
                    echo $core_update;
                echo "</li>";
                
            }

            echo "</ul>";

        }

    }

    echo "<h2>Plugins</h2>";
    // Updated plugins
    if ( $updated_plugins = maybe_load_report('updated-plugins') ) {

        if ( is_array( $updated_plugins ) ) {
    
            echo "<h3>Updated</h3>";
            echo "<ul class=\"fa-ul\">";
    
            foreach ( $updated_plugins as $plugin ) {
                echo "<li>";
                    echo "<span class=\"fa-li\"><i class=\"far fa-check-square\"></i></span>";
                    echo $plugin;
                echo "</li>";
            }
            echo "</ul>";
            
        }

    }

    //Skipped plugins
    if ( $skipped_plugins = maybe_load_report( 'skipped-plugins' ) ) {

        if ( is_array( $skipped_plugins ) ) {
    
            echo "<h3>Skipped</h3>";
            echo "<ul class=\"fa-ul\">";
    
            foreach ( $skipped_plugins as $plugin ) {
                echo "<li>";
                    echo "<span class=\"fa-li\"><i class=\"far fa-minus-circle\"></i></span>";
                    echo $plugin;
                echo "</li>";
            }
            echo "</ul>";
            
        } 

    }

    // Theme
    if ( $theme_updates = maybe_load_report( 'theme' ) ) {

        if ( $theme_updates ) {
    
            echo "<h2>Theme Updates</h2>";
            echo "<ul class=\"blank\">";
    
            foreach ( $theme_updates as $theme_update ) {
    
                echo "<li>";
                    echo $theme_update;
                echo "</li>";
                
            }
    
            echo "</ul>";
                
        }
        
    }
 ?>
    </body>
</html>