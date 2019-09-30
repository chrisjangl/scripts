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
        ";

        echo $style;
        ?>
        
    </head>

    <body class="trial3">

        <?php
    // Site info
    $site = file('site_info.txt');  
    if ( $site ) {
        echo "<h1>" . $site[0] . " September Updates</h1>";
    }
    
    // Core
    $core_updates = file ('core.txt');
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

    echo "<h2>Plugins</h2>";
    // Updated plugins
    $updated_plugins = file('updated-plugins.txt');
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

    //Skipped plugins
    $skipped_plugins = file('skipped-plugins.txt');
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

    // Theme
    $theme_updates = file('theme.txt');
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
 ?>
    </body>
</html>