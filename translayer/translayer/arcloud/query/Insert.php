<?php
include "library.php";
if(isset($_POST))
{
	$data= $_POST['data'];
	$data=json_decode($data);
	
	$location=$data->location;
//	echo $data->type;
	$place=new Places();
	$arra=$place->CreateArray($data->alt, $location,$data->name, $data->type, $data->tags, 'root' );
	$place->newPlace($arra);
}


?>
