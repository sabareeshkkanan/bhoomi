<?php
include_once "library.php";

class Video extends Database {
		private $collection;
		public function __construct() {
		parent::__construct();
		$this -> collection = $this -> db -> Video;
	}
	public function CreateArray($name,$alt,$url,$user)
	{
		$vid=array('alt'=>$alt,'name'=>$name,'type'=>'Video','url'=>$url,'user'=>user);
		return $vid;
	}
	public function newVideo($arr){
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