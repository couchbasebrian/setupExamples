<!DOCTYPE html>
<html>

<head>
 <script src="Chart.js"></script>

  <script>
    var myChart = new Chart()
  </script>
</head>

<?php

  $cluster = new CouchbaseCluster('http://localhost:8091');
  $bucket = $cluster->openBucket('beer-sample');

  $bucket->enableN1ql(array('http://localhost:8093/'));

  $query = CouchbaseN1qlQuery::fromString('select substr(updated,0,10) as UPDATED, count(1) as NUMUPDATED from `beer-sample` group by substr(updated,0,10) order by substr(updated,0,10);');
  $res = $bucket->query($query);
  // var_dump($res);

  $json = json_encode($res);

?>

<body>
This is the body

<canvas id="myChart" width="100" height="100"></canvas>

<script>

  var jsJson = <?php echo $json ?>;

  var resultLength = jsJson.length;
  var listOfLabels = [ ];
  var listOfData = [ ];
  for (var i = 0; i < resultLength; i++) {
     listOfLabels.push(jsJson[i].UPDATED);
     listOfData.push(jsJson[i].NUMUPDATED);
  }
  console.log(listOfLabels.length);
  console.log(listOfLabels);
  console.log(listOfData.length);
  console.log(listOfData);

  var ctx = document.getElementById("myChart");
  var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: listOfLabels,
        datasets: [{
            label: '# of Documents Updated',
            data: listOfData 
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>

</body>

</html>
