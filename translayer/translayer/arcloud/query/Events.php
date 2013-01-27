<?php
include_once "library.php";

class Events extends Database {
	private $collection;
	public function __construct() {
		parent::__construct();
		$this -> collection = $this -> db -> events;
	}

	public function CreateArray($name, $alt, $media, $user, $info) {
		$vid = array('alt' => $alt, 'name' => $name, 'media' => $media, 'info' => $info, 'user' => $user);
		return $vid;
	}

	public function newEvent($arr) {
		$this -> collection -> insert($arr, true);
	}

	public function update($id, $name, $alt, $info) {
		$newdata = array('$set' => array('alt' => $alt, 'name' => $name, 'info' => $info));
		$this -> collection -> update(array('_id' => $id), $newdata);
	}

	public function addMedia($location, $media) {
		$this -> collection -> update(array('_id' => $location), array('$addToSet' => array('media' => $media)));

	}

	public function searchBy($arr) {
		return $this -> collection -> find($arr);
	}

	public function removeMedia($location, $mediaid) {
		$this -> collection -> update(array('_id' => $location), array('$pull' => array('media.id' => $mediaid)));
	}

	public function delete($id) {
		$this -> collection -> remove(array('_id' => $id));
	}

	public function searchByUser($id) {
		return $this -> collection -> find();
	}

	public function searchById($id) {
		return $this -> collection -> findone(array('_id' => $id));
	}

	public function populateWithMedia($id) {
		$event = $this -> searchById($id);
		if ($event) {

			$media = $this -> retrivemedia($event['media']);

			$event['media'] = $media;

			return $event;
		}

	}

	private function retrivemedia($mediaRef) {
		$result = array();
		foreach ($mediaRef as $value) {

			$type = $value['type'];
			$id = $value['id'];
			switch ($type) {
				case 'video' :
					$media = new Video();
					break;
				case 'image' :
					$media = new Image();
					break;
				case 'data' :
					$media = new data();
					break;
				case '_3d' :
					$media = new _3d();
					break;
				default :
					return;
					break;
			}

			array_push($result, $media -> searchById(new MongoID($id)));
		}
		return $result;
	}

}
?>