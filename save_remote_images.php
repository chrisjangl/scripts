<?php

function save_image() {
    
    $url = 'http://journeymangroup.com/';
    
    //use cURL functions to "open" page
    //load $page as source code for target page
    $html = file_get_contents( $url );

    $dom = new domDocument;
    $dom->loadHTML($html);
    $dom->preserveWhiteSpace = false;
    $images = $dom->getElementsByTagName('img');
    foreach ($images as $image) {
        $source = $image->getAttribute('src');
        $tgt = 'C:\MAMP\htdocs\ugh';
        if(copy($source, $tgt)) {
            echo 'copied ' . $image->getAttribute('src');
        }
    
    }
}


//Download image from each page
// for($i=1; $i<=20; $i++) {
save_image();
// }

