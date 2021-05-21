// Get current sensor readings when the page loads 

window.addEventListener('load', getReadings);

// Create energy chart

var chartT = new Highcharts.Chart({
 chart:{
 renderTo:'chart-energy'
 },
 series: [
 {
 name: 'Energy'
 }
 ],
 title: {
 text: undefined
 },
 plotOptions: {
 line: {
 animation: false,
 dataLabels: {
 enabled: true
 }
 }
 },
 xAxis: {
 type: 'datetime',
 dateTimeLabelFormats: { second: '%H:%M:%S' }
 },
 yAxis: {
 title: {
 text: 'Energy Status'
 }
 },
 credits: {
 enabled: true
 }
});
 
// Create position chart

var chartH = new Highcharts.Chart({
 chart:{
 renderTo:'chart-position'
 },
 series: [{
 name: 'Position'
 }],
 title: {
 text: undefined
 }, 
 plotOptions: {
 line: {
 animation: false,
 dataLabels: {
 enabled: true
 }
 },
 series: {
 color: '#50b8b4'
 }
 },
 xAxis: {
 type: 'datetime',
 dateTimeLabelFormats: { second: '%H:%M:%S' }
 },
 yAxis: {
 title: {
 text: 'Position Map'
 }
 },
 credits: {
 enabled: false
 }
});
//Plot Energy in the Energy chart
function plotEnergy(value) {
 var x = (new Date()).getTime()
 var y = Number(value);
 if(chartT.series[0].data.length > 40) {
 chartT.series[0].addPoint([x, y], true, true, true);
 } else {
 chartT.series[0].addPoint([x, y], true, false, true);
 }
}
//Plot Position in the Position chart
function plotPosition(value) {
 var x = (new Date()).getTime()
 var y = Number(value);
 if(chartH.series[0].data.length > 40) {
 chartH.series[0].addPoint([x, y], true, true, true);
 } else {
 chartH.series[0].addPoint([x, y], true, false, true);
 }
}
// Function to get current readings on the web page when it loads
function getReadings() {
 var xhr = new XMLHttpRequest();
 xhr.onreadystatechange = function() {
 if (this.readyState == 4 && this.status == 200) {
 var myObj = JSON.parse(this.responseText);
 console.log(myObj);
 var energy = myObj.energy;
 var position = myObj.position;
 plotEnergy(energy);
 plotPosition(position);
 }
 };
 xhr.open("GET", "/readings", true);
 xhr.send();
}
if (!!window.EventSource) {
 var source = new EventSource('/events');
 
 source.addEventListener('open', function(e) {
 console.log("Events Connected");
 }, false);
 source.addEventListener('error', function(e) {
 if (e.target.readyState != EventSource.OPEN) {
 console.log("Events Disconnected");
 }
 }, false);
 
 source.addEventListener('message', function(e) {
 console.log("message", e.data);
 }, false);
 
 source.addEventListener('new_readings', function(e) {
 console.log("new_readings", e.data);
 var myObj = JSON.parse(e.data);
 console.log(myObj);
 plotEnergy(myObj.energy);
 plotPosition(myObj.position);
 }, false);
}