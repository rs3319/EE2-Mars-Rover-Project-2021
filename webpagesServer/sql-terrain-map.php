<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <body style="text-align: center;">
  <h2 class="text-center">Terrain Map</h2>
  <div id="regions_div" style="width: 900px; height: 500px;"></div>
    <script type="text/javascript">
      google.charts.load('current', {
        'packages':['corechart'],
        'mapsApiKey': 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY'
      });
      function drawRegionsMap() {
        var jsonData = $.ajax({
            url: "esp32-get-ping-pong.php",
            dataType:"json",
            async: false,
            success: function (data) {
                var arr = [['X','Y',{role: 'tooltip'},{role: 'style'}]];    // Define an array and assign columns for the chart.
                // Loop through each data and populate the array.
                $.each(data, function (index, value) {
                    arr.push([parseInt(value.X),parseInt(value.Y),value.Color,"color: " + value.Color.toLowerCase()]);
                    
                });
        var data = google.visualization.arrayToDataTable(arr);
        var options = {vAxis: {viewWindow: {min: -100, max: 100}},hAxis: {viewWindow: {min: -100, max: 100}}, legend: {position: 'none'},explorer: {
            keepInBounds: true,
            maxZoomIn: 4.0
          }
                        };
        var chart = new google.visualization.ScatterChart(document.getElementById('regions_div'));
        chart.draw(data, options);
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
                    setInterval(drawRegionsMap, 10000);
                    });
        </script>
  </head>
  </body>
</html>