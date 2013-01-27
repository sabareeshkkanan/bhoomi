<?php

?>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<link href="style.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?sensor=true"></script>
		<script src='json2.js'></script>
		<script src='init.js'></script>
	</head>
	<body onload="init()">
		<div id="panel">
			<label style="float: left">Panel</label>
			<div class="clear"></div>
		</div>
		<div id="map_canvas" style="width:100%; height:100%"></div>

	</body>
</html>