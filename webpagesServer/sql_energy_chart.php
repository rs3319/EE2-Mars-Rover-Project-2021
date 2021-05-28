<?php
    include "sql-query-latest.php";
?>
<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    
  <body style="text-align: center;">
    <h2 class="text-center">Battery Life Chart</h2>

    <div id="regions_div" style="width: 900px; height: 500px;"></div>

    <script type="text/javascript">
      google.charts.load('current', {
        'packages':['corechart'],
        'mapsApiKey': 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY'
      });
      google.charts.setOnLoadCallback(drawRegionsMap);

      function drawRegionsMap() {
        var data = google.visualization.arrayToDataTable([
             ['BatteryLevel'],
            <?php
                while($row = mysqli_fetch_assoc($chartQueryRecords)){
                    echo "['".$row['BatteryLevel']."'],";
                }
            ?>
        ]);

        var options = {
        };

        var chart = new google.visualization.LineChart(document.getElementById('regions_div'));

        chart.draw(data, options);
      }
    </script>
  </head>
  </body>
</html>