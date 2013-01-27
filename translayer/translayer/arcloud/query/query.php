<?php
error_reporting(NULL);
if (isset($_POST)) {
	include "library.php";
	$handle = fopen('php://input','r');
                $json = fgets($handle);
	$json=json_decode($json);
	$src=$json->Location;
	$range = 6;
	$place = new Places();
	$cursor = $place -> populateWithEvents($src, $range);
	$thirdDim=new __3d();
	$d3results=$thirdDim->Query($src, $range);
	$cursor['threeD']=$d3results;
	if($cursor){
		$cursor = json_encode($cursor);
	echo $cursor;
	}
	

} 
?>
