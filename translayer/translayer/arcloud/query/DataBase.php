<?php
class Database{
	protected $m;
	protected $db;
	public function __construct() {
		$this -> m = new Mongo();
		$this -> db = $this -> m -> AGReality;
	}
}
?>