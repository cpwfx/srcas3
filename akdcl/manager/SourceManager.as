package akdcl.manager {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	/**
	 * ...
	 * @author ...
	 */
	public class SourceManager {
		private static var instance:SourceManager;

		public static function getInstance():SourceManager {
			if (instance){
			} else {
				instance = new SourceManager();
			}
			return instance;
		}

		private var sourceGroup:Object;

		public function SourceManager(){
			if (instance){
				throw new Error("ERROR:SourceManager Singleton already constructed!");
			}
			instance = this;
			sourceGroup = {};
		}

		public function addGroup(_groupID:String):void {
			if (sourceGroup[_groupID]){

			} else {
				sourceGroup[_groupID] = {};
			}
		}

		public function getGroup(_groupID:String):Object {
			return sourceGroup[_groupID];
		}

		public function removeGroup(_groupID:String):void {
			var _group:Object = getGroup[_groupID];
			for (var _i:String in _group){
				removeSource(_groupID, _i);
			}
			delete sourceGroup[_groupID];
		}

		public function addSource(_groupID:String, _sourceID:String, _source:*):void {
			addGroup(_groupID);
			var _group:Object = getGroup(_groupID);
			if (_group[_sourceID]){

			}
			_group[_sourceID] = _source;
		}

		public function getSource(_groupID:String, _sourceID:String):* {
			return getGroup(_groupID)[_sourceID];
		}

		public function removeSource(_groupID:String, _sourceID:String):void {
			var _group:Object = getGroup(_groupID);
			var _source:* = _group[_sourceID];
			if (_source){
				if (_source is BitmapData){
					_source.dispose();
				} else if (_source is DisplayObject){
					if (_source.parent){
						_source.parent.removeChild(_source);
					}
				}
				delete _group[_sourceID];
			}
		}
	}

}