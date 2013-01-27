<?php
include_once "library.php";

class Image extends Database {
		private $collection;
		public function __construct() {
		parent::__construct();
		$this -> collection = $this -> db -> Image;
	}
	public function CreateArray($name,$alt,$url,$user)
	{
		$vid=array('alt'=>$alt,'name'=>$name,'type'=>'Image','url'=>$url,'user'=>user);
		return $vid;
	}
	public function newImage($arr){
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
	
}
?>