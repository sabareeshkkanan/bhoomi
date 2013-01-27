<?php
include_once "library.php";
class Places extends DataBase {

	private $collection;
	public function __construct() {
		parent::__construct();
		$this -> collection = $this -> db -> places;
	}
public function searchBy($arr)
{
	return $this->collection->find($arr);
}
	public function Query($near, $range) {
		$range=$range/6378.137;
		$cursor = $this -> db -> command(array('geoNear' => "places", 'near' => $near, 'num' => 20, 'maxDistance' => $range, 'includeLocs' => 'true', 'spherical' => 'true', 'uniqueDocs' => 'true'));
		return $cursor;
	}

	public function newPlace($arr) {
		$this -> collection -> insert($arr);
		
	}

	public function addEvent($location, $event) {
		$this -> collection -> update(array('_id' => $location), array('$addToSet' => array('Events' => $event)));

	}



	public function removeEvent($location, $event) {
		$this -> collection -> update(array('_id' => $location), array('$pull' => array('Events' => $event)));
	}

	

	public function CreateArray($altname, $location,$name, $type, $tag, $user ) {
		$loc = array('AltName' => $altname, 'Location' => $location,'LocationName' => $name, 'LocationType' => $type,  'Tags' => $tag, 'user' => $user);
		return $loc;
	}
	public function populateWithEvents($near,$range){
		$cursor=$this->Query($near, $range);
		$results=array();
		
		foreach ($cursor['results'] as $result) {	
		$result['obj']['events']=$this->getEvents($result['obj']['events']);
		array_push($results,$result);	
		}
		$cursor['results']=$results;
		return $cursor;
	}
	private function getEvents($events){
		$Theevent=new Events();
		$result=array();
		foreach ($events as  $value) {
			array_push($result,$Theevent->populateWithMedia(new MongoID($value)));
		}
		return $result;
		
	}

}
?>