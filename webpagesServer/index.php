<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <title>ESP32 Mars Rover </title>
        <style>
    body{font-family:Arial,Helvetica,sans-serif;background:#181818;color:#efefef;font-size:16px}h2{font-size:18px}section.main{display:flex}#menu,section.main{flex-direction:column}#menu{display:none;flex-wrap:nowrap;min-width:340px;background:#363636;padding:8px;border-radius:4px;margin-top:-10px;margin-right:10px}#content{display:flex;flex-wrap:wrap;align-items:stretch}figure{padding:0;margin:0;-webkit-margin-before:0;margin-block-start:0;-webkit-margin-after:0;margin-block-end:0;-webkit-margin-start:0;margin-inline-start:0;-webkit-margin-end:0;margin-inline-end:0}figure img{display:block;width:100%;height:auto;border-radius:4px;margin-top:8px}@media (min-width:800px) and (orientation:landscape){#content{display:flex;flex-wrap:nowrap;align-items:stretch}figure img{display:block;max-width:100%;max-height:calc(100vh - 40px);width:auto;height:auto}figure{padding:0;margin:0;-webkit-margin-before:0;margin-block-start:0;-webkit-margin-after:0;margin-block-end:0;-webkit-margin-start:0;margin-inline-start:0;-webkit-margin-end:0;margin-inline-end:0}}section #buttons{display:flex;flex-wrap:nowrap;justify-content:space-between}#nav-toggle{cursor:pointer;display:block}#nav-toggle-cb{outline:0;opacity:0;width:0;height:0}#nav-toggle-cb:checked+#menu{display:flex}.input-group{display:flex;flex-wrap:nowrap;line-height:22px;margin:5px 0}.input-group>label{display:inline-block;padding-right:10px;min-width:47%}.input-group input,.input-group select{flex-grow:1}.range-max,.range-min{display:inline-block;padding:0 5px}button{display:block;margin:5px;padding:5px 12px;border:0;line-height:28px;cursor:pointer;color:#fff;background:#035806;border-radius:5px;font-size:16px;outline:0;width:100px}.button2{background-color:#008cba;width:100px}.button3{background-color:#f44336;width:100px}.button4{background-color:#e7e7e7;color:#000;width:120px}.button5{background-color:#555;width:100px}.button6{visibility:hidden;width:100px}button:hover{background:#ff494d}button:active{background:#f21c21}button.disabled{cursor:default;background:#a0a0a0}input[type=range]{-webkit-appearance:none;width:100%;height:22px;background:#363636;cursor:pointer;margin:0}input[type=range]:focus{outline:0}input[type=range]::-webkit-slider-runnable-track{width:100%;height:2px;cursor:pointer;background:#efefef;border-radius:0;border:0 solid #efefef}input[type=range]::-webkit-slider-thumb{border:1px solid rgba(0,0,30,0);height:22px;width:22px;border-radius:50px;background:#ff3034;cursor:pointer;-webkit-appearance:none;margin-top:-11.5px}input[type=range]:focus::-webkit-slider-runnable-track{background:#efefef}input[type=range]::-moz-range-track{width:100%;height:2px;cursor:pointer;background:#efefef;border-radius:0;border:0 solid #efefef}input[type=range]::-moz-range-thumb{border:1px solid rgba(0,0,30,0);height:22px;width:22px;border-radius:50px;background:#ff3034;cursor:pointer}input[type=range]::-ms-track{width:100%;height:2px;cursor:pointer;background:0 0;border-color:transparent;color:transparent}input[type=range]::-ms-fill-lower{background:#efefef;border:0 solid #efefef;border-radius:0}input[type=range]::-ms-fill-upper{background:#efefef;border:0 solid #efefef;border-radius:0}input[type=range]::-ms-thumb{border:1px solid rgba(0,0,30,0);height:22px;width:22px;border-radius:50px;background:#ff3034;cursor:pointer;height:2px}input[type=range]:focus::-ms-fill-lower{background:#efefef}input[type=range]:focus::-ms-fill-upper{background:#363636}.switch{display:block;position:relative;line-height:22px;font-size:16px;height:22px}.switch input{outline:0;opacity:0;width:0;height:0}.slider{width:50px;height:22px;border-radius:22px;cursor:pointer;background-color:grey}.slider,.slider:before{display:inline-block;transition:.4s}.slider:before{position:relative;content:"";border-radius:50%;height:16px;width:16px;left:4px;top:3px;background-color:#fff}input:checked+.slider{background-color:#ff3034}input:checked+.slider:before{-webkit-transform:translateX(26px);transform:translateX(26px)}select{border:1px solid #363636;font-size:14px;height:22px;outline:0;border-radius:5px}.image-container{position:absolute;top:50px;left:50%;margin-right:-50%;transform:translate(-50%,-50%);min-width:160px}.control-container{position:relative;top:400px;left:50%;margin-right:-50%;transform:translate(-50%,-50%)}.slider-container{position:relative;top:750px;right:36%;margin-left:-50%;transform:translate(-50%,-50%)}.close{position:absolute;right:5px;top:5px;background:#ff3034;width:16px;height:16px;border-radius:100px;color:#fff;text-align:center;line-height:18px;cursor:pointer}.hidden{display:none}.rotate90{-webkit-transform:rotate(270deg);-moz-transform:rotate(270deg);-o-transform:rotate(270deg);-ms-transform:rotate(270deg);transform:rotate(270deg)}
</style>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    </head>
    <body>
    


        <section class="main">
        
    <h2 class="text-center" align="center">Rover Position</h2>
    <style>
        .chart_box {
        display: inline-block;
        margin: 0 auto;
    }
    </style>
    <div id="regions_div" class = "chart_box"  style="width: 600px; height: 350px;"></div>
    
    
    <script type="text/javascript">
      google.charts.load('current', {
        'packages':['corechart'],
        'mapsApiKey': 'AIzaSyD-9tSrke72PouQMnMX-a7eZSW0jkFMBWY'
      });
      
      
      function drawRegionsMap() {
        var jsonData = $.ajax({
            url: "esp32-get-position-array.php",
            dataType:"json",
            async: false,
            success: function (data) {
                var arr = [['X','Rover Path']];    // Define an array and assign columns for the chart.

                // Loop through each data and populate the array.
                $.each(data, function (index, value) {

                    arr.push([parseInt(value.PositionX),parseInt(value.PositionY)]);
                });
        var data = google.visualization.arrayToDataTable(arr);

        var options = {vAxis: {viewWindow: {min: -100, max: 100}},hAxis: {viewWindow: {min: -100, max: 100}}, legend:'none'};
        var chart = new google.visualization.LineChart(document.getElementById('regions_div'));

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
                    setInterval(drawRegionsMap, 2000);
                    });
        </script>
            <section class="display: inline-block" id="buttons">
            <style>
                section {
                    padding: 0;
                    margin: 0;
                    align-items:center;
                }
            </style>
                <div id="controls" class="control-container" align="center">
                  <table>
                  <tr><td align="center"><button class="button button6" id="get-still">Image</button></td><td align="center"><button id="toggle-stream">Start</button></td><td></td></tr>
                  <tr><td></td><td align="center"><button class="button button2" id="forward" >FORWARD</button></td><td></td></tr>
                  <tr><td align="center"><button class="button button2" id="turnleft" >LEFT</button></td><td align="center"></td><td align="center"><button class="button button2" id="turnright" >RIGHT</button></td></tr>
                  <tr><td></td><td align="center"><button class="button button2" id="backward" >REVERSE</button></td><td></td></tr>
                  <tr><td align="center"><button onclick="location.href='http://esp32-mars-rover.000webhostapp.com/sql_energy_chart.php'" type="button"> View Energy Status</button></td><td></td><td align="center"><button onclick="location.href='http://esp32-mars-rover.000webhostapp.com/sql-position-plot.php'" type="button">
         View Position Plot</button></td></tr>
                  </table>
                </div>
            </section> 
            <p align ="right">
                    Move to coordinate:
                    <br>
                    <br>
                     <label for="spinnerX">X:</label>
                     <input id="spinnerX" name="value" />
                     <br>
                     <br>
                     <label for="spinnerY">Y:</label>
                     <input id="spinnerY" name="value" />
                     <br>
                     <br>
                     <button class ="button button2" id="ManualMove" >Move</button>
                </p>
        <p>
          <i class="fas fa-lightbulb" style="color:#059e8a;"></i> 
          <span class="dht-labels">Energy</span> 
          <span id="energyvalue">%ENERGY%</span>
        </p>     
        <p>
          <i class="fas fa-map-marker-alt" style="color:#059e8a;"></i> 
          <span class="dht-labels">Position</span> 
          <span id="positionvalue">%POSITION%</span>
        </p>  
        <p>
          <i class="fas fa-tachometer-alt" style="color:#059e8a;"></i> 
          <span class="dht-labels">Speed</span> 
          <span id="speedvalue">%SPEED%</span>
        </p>  
  
        </section>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>

        <script>

          $( "#spinnerX" ).spinner();
          $( "#spinnerY" ).spinner();
          document.getElementById("forward").onclick = DriveForward;
          document.getElementById("turnleft").onclick = DriveLeft;
          document.getElementById("turnright").onclick = DriveRight;
          document.getElementById("backward").onclick = DriveReverse;
          document.getElementById("ManualMove").onclick = ManualMove;
          setInterval(function(){
            $.get("sql-query-latest.php",{api_key: "EXAMPLEKEY2000",database : "energy"},function(data,status){document.getElementById("energyvalue").innerHTML = data})
            $.get("sql-query-latest.php",{api_key: "EXAMPLEKEY2000",database : "position"},function(data,status){document.getElementById("positionvalue").innerHTML = data})
            $.get("sql-query-latest.php",{api_key: "EXAMPLEKEY2000",database : "speed"},function(data,status){document.getElementById("speedvalue").innerHTML = data})
            
          },5000)

          function DriveLeft(){
            $.post("esp-post-command.php",{api_key: "EXAMPLEKEY2000",name : "tl", param1: 20, param2: 0});
          }

          function DriveForward(){
            $.post("esp-post-command.php",{api_key: "EXAMPLEKEY2000", name : "fw", param1: 10, param2: 0});
          }
          function DriveRight(){
            $.post("esp-post-command.php",{api_key: "EXAMPLEKEY2000",name : "tr", param1: 20, param2: 0})
          }
          function DriveReverse(){
            $.post("esp-post-command.php",{api_key: "EXAMPLEKEY2000",name : "rv", param1: 10, param2: 0})
          }
          function ManualMove(){
 
            $.post("esp-post-command.php",{api_key: "EXAMPLEKEY2000",name : "mv", param1: document.getElementById("spinnerX").value, param2: document.getElementById("spinnerY").value }) 
          }
          
        </script>
    </body>
</html>
