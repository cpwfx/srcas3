﻿package akdcl.manager {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.system.Security;


	/**
	 * ...
	 * @author Akdcl
	 */

	/// @eventType	ExternalInterfaceManager.CALL
	[Event(name="call",type="ExternalInterfaceManager")]

	final public class ExternalInterfaceManager extends EventDispatcher {
		private static const ERROR:String = "ExternalInterfaceManager Singleton already constructed!";
		private static var instance:ExternalInterfaceManager;
		private static var lM:LoggerManager = LoggerManager.getInstance();

		public static function getInstance():ExternalInterfaceManager {
			if (instance){
			} else {
				instance = new ExternalInterfaceManager();
			}
			return instance;
		}

		public function ExternalInterfaceManager(){
			if (instance){
				lM.fatal(ExternalInterfaceManager, ERROR);
				throw new Error("[ERROR]:" + ERROR);
			}
			instance = this;

			if (Security.sandboxType == Security.LOCAL_WITH_FILE){
				__isAvailable = false;
			} else {
				try {
					ExternalInterface.call("window.location.href.toString");
					__isAvailable = true;
				} catch (_e:Error){
					__isAvailable = false;
				}
			}
			if (isAvailable){
				ExternalInterface.addCallback(CALL, swfInterface);
			}
			
			lM.info(ExternalInterfaceManager, "init isAvailable:{0} objectID:{1}", null, isAvailable, objectID);
		}

		public static const CALL:String = "call";

		public static const EXTERNAL_LISTENER:String = "swfEventHandler";

		public var eventParams:Array;

		private var swfInterFaceEvent:Event = new Event(CALL);

		private var __isAvailable:Boolean = false;

		public function get isAvailable():Boolean {
			return __isAvailable;
		}

		private var __eventType:String = null;

		public function get eventType():String {
			return __eventType;
		}

		private var __objectID:String;

		public function get objectID():String {
			return ExternalInterface.objectID || __objectID;
		}

		public function set objectID(_str:String):void {
			__objectID = _str;
		}

		public function hasInterface(_funName:String):Boolean {
			if (isAvailable){
				//ExternalInterface.call("eval", _funName + "!=" + "null");
				return Boolean(objectID);
			}
			return false;
		}

		public function callInterface(_funName:String, ... args):* {
			lM.info(ExternalInterfaceManager, "callInterface(funName:{2}, args:{3}) isAvailable:{0} objectID:{1}", null, isAvailable, objectID, _funName, args);
			if (isAvailable && hasInterface(_funName)){
				if (args){
					return ExternalInterface.call.apply(ExternalInterface, [_funName].concat(args));
				}
				return ExternalInterface.call(_funName);
			}
		}

		//广播as调用js的事件
		public function dispatchSWFEvent(_type:String, ... args):void {
			if (isAvailable){
				if (args){
					callInterface.apply(ExternalInterfaceManager, [EXTERNAL_LISTENER, objectID, _type].concat(args));
				} else {
					callInterface(EXTERNAL_LISTENER, objectID, _type);
				}
			}
		}

		public function debugMessage(... args):void {
			callInterface("alert", "[" + objectID + "]:" + args);
		}

		//广播js调用as的事件
		//addEventListener(ExternalInterfaceManager.CALL);
		//addEventListener(__eventType);
		private function swfInterface(_type:String, ... args):void {
			__eventType = _type;
			if (args){
				eventParams = args;
			} else {
				eventParams = null;
			}
			
			lM.info(ExternalInterfaceManager, "接收外部事件(type:{2}, args:{3}) isAvailable:{0} objectID:{1}", null, isAvailable, objectID, __eventType, args);
			
			if (hasEventListener(CALL)) {
				dispatchEvent(swfInterFaceEvent);
			}
			if (hasEventListener(__eventType)){
				var _event:Event = new Event(__eventType);
				dispatchEvent(_event);
			}
		}
	}
}