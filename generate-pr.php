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
 * @param compatibility-issues.txt
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
        echo "# " . $site[0] . " Updates - $date<br>";

    }

    
    // account notices
    if ( file_exists( 'account-notices.txt' ) ) {

        $notices = file( 'account-notices.txt' );

        echo "## ***Account notices for the month***<br>";

        foreach ( $notices as $notice ) {

            echo "- ";
            echo $notice . "<br>";

        }
    }
    
    // Core
    if ( $core_updates = maybe_load_report('core') ) {

        if ( $core_updates ) {

            echo "## Core Updates<br>";

            foreach ( $core_updates as $core_update ) {

                echo "- ";
                echo $core_update . "<br>";
                
            }
        }

    }

    echo "## Plugins <br>";
    // Updated plugins
    if ( $updated_plugins = maybe_load_report('updated-plugins') ) {

        if ( is_array( $updated_plugins ) ) {
    
            echo "### Updated <br>";
    
            foreach ( $updated_plugins as $plugin ) {
                echo "- ";
                    echo $plugin . "<br>";
            }
            
        }

    }

    //Skipped plugins
    if ( $skipped_plugins = maybe_load_report( 'skipped-plugins' ) ) {

        if ( is_array( $skipped_plugins ) ) {
    
            echo "### Skipped <br>";
    
            foreach ( $skipped_plugins as $plugin ) {
                echo "- ";
                echo $plugin . "<br>";
            }
            
        } 

    }

    // Theme
    if ( $theme_updates = maybe_load_report( 'theme' ) ) {

        if ( $theme_updates ) {
    
            echo "## Theme Updates <br>";
    
            foreach ( $theme_updates as $theme_update ) {
    
                echo "- ";
                    echo $theme_update . "<br>";
                
            }                
        }
        
    }


    // Issues
    if ( $compatibility_issues = maybe_load_report( 'compatibility-issues' ) ) {
        if ( $compatibility_issues ) {
            echo "## Compatibility Issues <br>";

            foreach ( $compatibility_issues as $issue ) {
                echo $issue . "<br>";
            }
            
        }
    }
    ?>

    <style>
        footer {
            font-size: 0.85em;
            width: 100%;
            text-align: center;
            margin: 3rem auto;
        }

        footer a, footer a:visited {
            color: #3e7fe3;
        }
    </style>
    <footer>
        Performed by <a href="https://digitallycultured.com">Digitally Cultured</a>
    </footer>

    </body>
</html>
