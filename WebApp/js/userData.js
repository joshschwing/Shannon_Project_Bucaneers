'use strict'

var highHeartRateDataUser1 = [
  [5,110],
  [10,150],
  [15,170],
  [20,105],
  [25,90],
  [30,118],
  [35,126],
  [40,190],
  [45,177],
  [50,105]
];

var currentHeartRate1 = [
  [5,65],
  [10,70],
  [15,73],
  [20,73],
  [25,82],
  [30,90],
  [35,82],
  [40,80],
  [45,76],
  [50,70],
  [55,78],
  [60,75]
];

// low heart rate of current
var lowHeartRate = [
  [5,45],
  [10,50],
  [15,47],
  [20,50],
  [25,52],
  [30,46],
  [35,42],
  [40,45],
  [45,49],
  [50,61],
  [60,65],
];

var highHeartRateDataUser1 = [
  [5,110],
  [10,150],
  [15,170],
  [20,105],
  [25,90],
  [30,118],
  [35,126],
  [40,190],
  [45,177],
  [50,105]
];

function bgFlotData(num,val) {
  var data = [];
  for (var i = 0; i < num; ++i) {
    data.push([i, val]);
  }
  return data;
}
