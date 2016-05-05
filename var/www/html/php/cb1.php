<?php
  header("Content-Type: text/plain");

  $myCluster = new CouchbaseCluster('couchbase://localhost');
  
  $myBucket = $myCluster->openBucket('beer-sample');

  $myCounter = 0;

  while (true) {
    $res = $myBucket->get('21st_amendment_brewery_cafe');
    echo 'Iteration ' . $myCounter . ' Value: ' . $res->value;
    echo '------------\n\n';  
    $myCounter++;

    // sleep(1);
    usleep(250000);

  }



?>

