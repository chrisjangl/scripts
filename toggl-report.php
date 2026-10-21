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
  
  
// get the "from" date (since_date)
if ( isset( $_GET['since_date'] ) ) {
$since_date = $_GET['since_date'];
} else {
$since_date = date("Y-m-d");
}

//  get the "to" date (end_date)
if ( isset( $_GET['end_date'] ) ) {
    $end_date = $_GET['end_date'];
} else {
    $end_date = date("Y-m-d");
}


// $since_date = date("Y-m-d");
// $since_date = "2022-05-02";

// the workspace ID for the workspace we're using for this script
$workspace_name = $workspaces[$workspace]['name'];
$workspace_id = $workspaces[$workspace]['id'];

function get_report( $workspace_id, $since_date, $end_date, $api_token, $user_agent ) {

    $curl = curl_init();
    
    curl_setopt_array($curl, array(
    //   CURLOPT_URL => "https://api.track.toggl.com/reports/api/v2/summary?user_agent=$user_agent&workspace_id=$workspace_id&since=$since_date&until=$end_date&billable=yes",
      CURLOPT_URL => "https://api.track.toggl.com/reports/api/v2/summary?user_agent=$user_agent&workspace_id=$workspace_id&since=$since_date&until=$end_date",
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

    return $response;
}

function print_report( $response ) {

    if ( $response ) {
    
        $data = $response->data;
        
        foreach( $data as $project ) {
            
            echo '<div class="project">';
            
            $name = $project->title->project;
            $client = $project->title->client;
            $time_entries = $project->items;

            echo "<li><span class=\"client\">$client</span>: <span class=\"project\">$name</span> - ";
            echo "<span class=\"tasks\">";
            foreach ( $time_entries as $entry ) {
                echo $entry->title->time_entry . ", ";
            }

            echo " (<span class=\"time\">" . formatTime($project->time) . "</span>)</li>";
            
            echo '</div>';
                
        }
        
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

function round_time( $milliseconds ) {


    $seconds = time();
    $rounded_seconds = round($seconds / (15 * 60)) * (15 * 60);
    
    echo "Original: " . date('H:i', $seconds) . "\n";
    echo "Rounded: " . date('H:i', $rounded_seconds) . "\n";
    
}

function print_js() {
    ?>
    <script>
    // IIFE to avoid polluting the global scope
    (function() {
        // select the entire contents of the h3.date when clicked
        document.querySelectorAll('h3.date-range').forEach(item => {
            item.addEventListener('click', event => {
                var range = document.createRange();
                range.selectNodeContents(item);
                var selection = window.getSelection();
                selection.removeAllRanges();
                selection.addRange(range);
                document.execCommand('copy');
                selection.removeAllRanges();
            })
        })

        // Select the entire contents of a <li> when clicked
        document.querySelectorAll('li').forEach(item => {
            item.addEventListener('click', event => {
                var range = document.createRange();
                range.selectNodeContents(item);
                var selection = window.getSelection();
                selection.removeAllRanges();
                selection.addRange(range);
                document.execCommand('copy');
                selection.removeAllRanges();
            })
        })

        // Add event listener to the "Previous Week" button
        document.getElementById('previous-week').addEventListener('click', function() {
            // Get the current start date from the input field
            var sinceDateInput = document.getElementById('since_date');
            var currentSinceDate = new Date(sinceDateInput.value);
            // Subtract one week from the current start date
            currentSinceDate.setDate(currentSinceDate.getDate() - 7);
            // Update the start date input field
            sinceDateInput.value = currentSinceDate.toISOString().split('T')[0];

            // Get the current end date from the input field
            var endDateInput = document.getElementById('end_date');
            var currentEndDate = new Date(endDateInput.value);  
            // Subtract one week from the current end date
            currentEndDate.setDate(currentEndDate.getDate() - 7);
            // Update the end date input field
            endDateInput.value = currentEndDate.toISOString().split('T')[0];
        });

        // Add event listener to the "Next Week" button
        document.getElementById('next-week').addEventListener('click', function() {
            // Get the current start date from the input field
            var sinceDateInput = document.getElementById('since_date');
            var currentSinceDate = new Date(sinceDateInput.value);
            // Add one week to the current start date
            currentSinceDate.setDate(currentSinceDate.getDate() + 7);
            // Update the start date input field
            sinceDateInput.value = currentSinceDate.toISOString().split('T')[0];

            // Get the current end date from the input field
            var endDateInput = document.getElementById('end_date');
            var currentEndDate = new Date(endDateInput.value);
            // Add one week to the current end date
            currentEndDate.setDate(currentEndDate.getDate() + 7);
            // Update the end date input field
            endDateInput.value = currentEndDate.toISOString().split('T')[0];
        });
    })();
    </script>

    <?php
}
?>
<form action="toggl-report.php">

    <label for="since_date">Start date:</label>
    <input type="date" name="since_date" id="since_date" value="<?php echo $since_date; ?>" />
    
    <label for="end_date">End date:</label>
    <input type="date" name="end_date" id="end_date" value="<?php echo $end_date; ?>" />
    
    <!-- Submit button -->
    <input type="submit" value="Get Report" />

    <!-- button to get next week -->
    <button type="button" id="previous-week">Previous Week</button>
    <button type="button" id="next-week">Next Week</button>

</form>

<?php
$report = get_report( $workspace_id, $since_date, $end_date, $api_token, $user_agent );
$total_time = $report->total_grand;
$formatted_since_time = date("Y.m.d", strtotime($since_date));
$formatted_end_time = date("Y.m.d", strtotime($end_date));

echo "<hr>";
echo "<h2>$workspace_name</h2>";
echo "<h3 class=\"date-range\">$formatted_since_time - $formatted_end_time</h3>";
echo "<h4>Hours</h4>";
echo formatTime($total_time) . "<br>";


print_report( $report );

print_js();
