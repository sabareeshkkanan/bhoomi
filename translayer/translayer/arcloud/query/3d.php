<?php
include_once "library.php";

class __3d extends Database {
		private $collection;
		public function __construct() {
		parent::__construct();
		$this -> collection = $this -> db -> thirdDim;
	}
	public function CreateArray($name,$alt,$url,$user,$location)
	{
		$vid=array('alt'=>$alt,'name'=>$name,'type'=>'_3d','url'=>$url,'user'=>$user,'location'=>$location);
		return $vid;
	}
	public function new_3d($arr){
		$this->collection->insert($arr,true);
	}
	public function update($id,$name,$alt,$url){
		$newdata=array('$set'=>array('alt'=>$alt,'name'=>$name,'url'=>$url));
		$this->collection->update(array('_id'=>$id),$newdata);
	}
	public function delete($id){
		$this->collection->remove(array('_id'=>$id));
	}
	public function searchByUser($id){
		return $this->collection->find(array('user'=>$id));
	}
	public function searchById($id){
		return $this->collection->findone(array('_id'=>$id));
	}
	public function Query($near, $range) {
		$range=$range/6378.137;
		$cursor = $this -> db -> command(array('geoNear' => "thirdDim", 'near' => $near, 'num' => 20, 'maxDistance' => $range, 'includeLocs' => 'true', 'spherical' => 'true', 'uniqueDocs' => 'true'));
		return $cursor;
	}
	
	
}
?>