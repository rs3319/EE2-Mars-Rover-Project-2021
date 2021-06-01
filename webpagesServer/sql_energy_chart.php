
<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <body style="text-align: center;">
    <h2 class="text-center">Battery Life Chart</h2>

    <div id="regions_div" style="width: 900px; height: 500px;"></div>

    <script type="text/javascript">
      google.charts.load('current', {
        'packages':['corechart'],
        'mapsApiKey': 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY'
      });
      
      
      function drawRegionsMap() {
        var jsonData = $.ajax({
            url: "esp32-get-energy-array.php",
            dataType:"json",
            async: false,
            success: function (data) {
                var arr = [['id','BatteryLevel']];    // Define an array and assign columns for the chart.

                // Loop through each data and populate the array.
                $.each(data, function (index, value) {

                    arr.push([new Date(Date.parse(value.reading_time)),parseInt(value.BatteryLevel)]);
                });
        var data = google.visualization.arrayToDataTable(arr);


        var chart = new google.visualization.LineChart(document.getElementById('regions_div'));

        chart.draw(data);
            }
        
            
        });
      }
    </script>
    <script type="text/javascript" src="jQuery.js"></script>
        <script type="text/javascript">

                $(document).ready(function(){
                    // First load the chart once 
                    drawRegionsMap();
                    // Set interval to call the drawChart again
                    setInterval(drawRegionsMap, 1000);
                    });
        </script>
  </head>
  </body>
</html>
