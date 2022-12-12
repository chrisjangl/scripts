<?php
/**
 * some config variables
 */

/**
 * User Agent value
 * 
 * app name or email address
 * 
 * @see https://github.com/toggl/toggl_api_docs/blob/master/reports.md#request-parameters | `user_agent`
 */
$user_agent = "vendors@digitallycultured.com";

/**
 * Your API token
 * 
 * Token can be found in Toggl profile
 * 
 * @see https://github.com/toggl/toggl_api_docs#api-token
 */
$api_token = "a2a78fd1cbcfb92eebcf31062cefc6cd";

/**
 * Workspace key we'll be working with here.
 * 
 * The key for the workspace array defined below
 * Note: this is unique to this script - see the $workspaces array below for more info
 */
$workspace = "socialco";

/**
 * An array of workspaces, their pretty names & IDs for ease of use below when making request and printing values
 * 
 * If you have more than one workspace you'd like to store, duplicate $workspaces['main_workspace'] index and give a unique name.
 * 
 * $workspace['main_workspace']['name'] is only used in this script as a heading, and doesn't have to correspond to the name of the Workspace in Toggl.
 * $workspace['main_workspace']['id'] MUST correspond to an actual workspace ID in Toggl for the script to work properly
 * 
 * @see https://github.com/toggl/toggl_api_docs/blob/master/reports.md#request-parameters | `workspace_id`
 */
$workspaces = [
    'socialco' => [
        'name'  =>  'Social Co',
        'id'    =>  '5250345',
    ],
];

/**
 * some helper variables
 */

 /**
  * Since date
  * 
  * By default, we're using today's date, but this value can be adjusted to use any other date in the "Y-m-d" format.
  */
$since_date = date("Y-m-d");
$since_date = "2022-05-02";

// the workspace ID for the workspace we're using for this script
$workspace_name = $workspaces[$workspace]['name'];
$workspace_id = $workspaces[$workspace]['id'];

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => "https://api.track.toggl.com/reports/api/v2/summary?user_agent=$user_agent&workspace_id=$workspace_id&since=$since_date&billable=yes",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'GET',
  // @see https://github.com/toggl/toggl_api_docs/blob/master/reports.md#authentication
  CURLOPT_HTTPHEADER => array(
    'Authorization: Basic ' . base64_encode($api_token.':api_token')
  ),
));

$response = json_decode( curl_exec( $curl ) );
curl_close($curl);

if ( $response ) {

    $data = $response->data;
    
    echo "<h2>$workspace_name</h2>";
    foreach( $data as $project ) {
        
        echo '<div class="project">';
        
        $name = $project->title->project;
        echo "<h3>$name</h3> (" . formatTime($project->time) . ")";
        
        $time_entries = $project->items;
        
        foreach ( $time_entries as $entry ) {
            echo $entry->title->time_entry . ", ";
        }

        echo '</div>';
            
    }
    
}

function formatTime($milliseconds) {
    $seconds = floor($milliseconds / 1000);
    $minutes = floor($seconds / 60);
    $hours = floor($minutes / 60);
    $milliseconds = $milliseconds % 1000;
    $seconds = $seconds % 60;
    $minutes = $minutes % 60;

    $format = '%u:%02u:%02u.%03u';
    $time = sprintf($format, $hours, $minutes, $seconds, $milliseconds);
    return rtrim($time, '0');
}