﻿package {
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ContextMenuEvent;
	import flash.events.IOErrorEvent;

	import flash.system.Security;
	import flash.system.System;

	import akdcl.utils.addContextMenu;

	import akdcl.manager.ExternalInterfaceManager;
	import akdcl.manager.RequestManager;

	public class DocClass extends MovieClip {
		protected static var instanceMap:Object = {};

		public static function getInstance(_key:String = "main"):DocClass {
			var _instance:DocClass;
			_instance = instanceMap[_key];
			return _instance;
		}

		public function DocClass(_key:String = "main"){
			stop();
			/*if (instanceMap[_key] != null){
			   throw new Error("ERROR:DocClass Singleton already constructed!");
			 }*/
			instanceMap[_key] = this;
			loaderInfo.addEventListener(Event.INIT, onInitHandler);
		}
		public var optionsXML:XML;
		public var onLoading:Function;
		public var onLoaded:Function;

		public var eiM:ExternalInterfaceManager;
		public var rM:RequestManager;

		protected var loadDelay:Number = 1;
		protected var optionsXMLPath:String;
		protected var optionsXMLPerLoad:Number = 0.1;
		protected var loadProgress:Number = 0;
		protected var xmlLoadProgress:Number = 0;

		private var isLoadComplete:Boolean;

		private var __flashVars:Object;

		public function set flashVars(_flashVars:Object):void {
			if (loaderInfo.parameters && __flashVars){
				return;
			}
			__flashVars = _flashVars;
		}

		public function get flashVars():Object {
			return __flashVars || loaderInfo.parameters;
		}
		
		private static const STAGE_ALIGN:Array = [
			[StageAlign.TOP_LEFT, StageAlign.TOP, StageAlign.TOP_RIGHT],
			[StageAlign.LEFT, "", StageAlign.RIGHT],
			[StageAlign.BOTTOM_LEFT, StageAlign.BOTTOM, StageAlign.BOTTOM_RIGHT]
		];
		
		public function setStageAlignAndScale(_alignX:int = 0, _alignY:int = 0 , _scale:int = -1):void {
			if (stage) {
				if (_alignX<0) {
					_alignX = -1;
				}else if (_alignX > 0) {
					_alignX = 1;
				}
				_alignX++;
				if (_alignY<0) {
					_alignY = -1;
				}else if (_alignY > 0) {
					_alignY = 1;
				}
				_alignY++;
				stage.align = STAGE_ALIGN[_alignY][_alignX];
				switch(_scale) {
					case 0:
						stage.scaleMode = StageScaleMode.NO_SCALE;
						break;
					case 1:
						stage.scaleMode = StageScaleMode.SHOW_ALL;
						break;
				}
			}
		}

		protected function onInitHandler(_evt:Event):void {
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			setStageAlignAndScale(0, -1, 1);
			if (stage) {
				stage.showDefaultContextMenu = false;
			}
			tabChildren = false;

			rM = RequestManager.getInstance();
			eiM = ExternalInterfaceManager.getInstance();
			eiM.objectID = flashVars.__objectID;
			eiM.addEventListener(ExternalInterfaceManager.CALL, onJSInterfaceHandler);

			if (onLoaded == null){
				onLoaded = function():void {
					if (currentFrame == 1){
						play();
					}
				}
			}
			optionsXMLPath = flashVars.xml || optionsXMLPath;
			if (optionsXMLPath){
				rM.load(optionsXMLPath, onXMLLoadedHandler, onXMLErrorHandler, onXMLLoadingHandler);
			}
			addEventListener(Event.ENTER_FRAME, onLoadingHandler);

			eiM.dispatchSWFEvent("load");
		}

		protected function onLoadingHandler(_evt:*):void {
			gotoAndStop(1);
			var _loaded:Number = (loaderInfo.bytesTotal > 0) ? (loaderInfo.bytesLoaded / loaderInfo.bytesTotal) : loadProgress;
			if (_loaded == 1 && !isLoadComplete){
				isLoadComplete = true;
				onLoadedHandler();
			}
			onLoadingStepFix(_loaded);
			if (onLoading != null){
				onLoading(loadProgress);
			}
			if (loadProgress == 1 && onLoaded != null){
				removeEventListener(Event.ENTER_FRAME, onLoadingHandler);
				onLoaded();
			}
		}

		protected function onLoadedHandler():void {
			AuthorInformation.setFileBytes(loaderInfo.bytes);

			addContextMenu(this, "Size: " + loaderInfo.width + " X " + loaderInfo.height, onSizeMenuHandler);

			addContextMenu(this, AuthorInformation.getVersion(), onVersionMenuHandler);

			eiM.dispatchSWFEvent("loadComplete");
		}

		protected function onLoadingStepFix(_loaded:Number):void {
			if (optionsXMLPath){
				_loaded = _loaded * (1 - optionsXMLPerLoad) + xmlLoadProgress * optionsXMLPerLoad;
			}
			var _dV:Number = _loaded - loadProgress;
			if (_dV > 0.01){
				loadProgress += _dV * loadDelay;
			} else {
				loadProgress = _loaded;
			}
		}

		protected function onXMLLoadingHandler(_evt:ProgressEvent):void {
			xmlLoadProgress = (_evt.bytesTotal > 0) ? (_evt.bytesLoaded / _evt.bytesTotal) : xmlLoadProgress;
		}

		protected function onXMLLoadedHandler(_xml:XML, _url:String):void {
			var _str:String = "ERROR:XML语法错误!\n" + _url;
			if (_xml){
				optionsXML = _xml;
				xmlLoadProgress = 1;
				optionsXMLPath = _url;
			} else if (eiM.isAvailable){
				eiM.debugMessage(_str);
			} else {
				throw new Error(_str);
			}
		}

		protected function onXMLErrorHandler(_evt:IOErrorEvent, _url:String):void {
			var _str:String;
			if (_evt is IOErrorEvent){
				_str = "ERROR:读取XML失败，请检查XML地址是否正确!\n" + _url;
			} else {
				_str = "ERROR:安全沙箱冲突，无法跨域读取XML!\n" + _url;
			}
			if (eiM.isAvailable){
				eiM.debugMessage(_str);
			} else {
				throw new Error(_str);
			}
		}

		protected function onSizeMenuHandler(_evt:ContextMenuEvent):void {
			var _url:String = decodeURI(this.loaderInfo.url);
			var _ary:Array = _url.split("/");
			_url = _ary.pop();
			_url = _ary.pop() + "/" + _url;
			var _str:String = "addSWF('" + _url + "','containerID'," + loaderInfo.width + "," + loaderInfo.height + ");";
			_str = "<script src='http://www.wanmei.com/public/js/swfobject.js' type='text/javascript'></script>\r\n\r\n<script type='text/javascript'>\r\n	" + _str;
			_str = _str + "\r\n</script>";
			System.setClipboard(_str);
		}

		protected function onVersionMenuHandler(_evt:ContextMenuEvent):void {
			System.setClipboard(AuthorInformation.getInformation());
		}
		
		private static const JS_REQUEST:String = "jsRequest";
		private static const JS_REQUEST_ERROR:String = "jsRequestError";
		private static const JS_REQUEST_COMPLETE:String = "jsRequestComplete";
		protected function onJSInterfaceHandler(_e:Event):void {
			if (eiM.eventType == JS_REQUEST) {
				rM.load(eiM.eventParams[0], onJSRequestHandler, onJSRequestHandler, null, eiM.eventParams[1]);
			}
		}

		protected function onJSRequestHandler(_dataOrEvent:*, _url:String, _params:Array):void {
			if (_dataOrEvent is IOErrorEvent){
				eiM.callInterface(_params[0]);
				eiM.dispatchSWFEvent(JS_REQUEST_ERROR, _params[0], JS_REQUEST_ERROR);
			} else {
				eiM.callInterface(_params[0], _dataOrEvent);
				eiM.dispatchSWFEvent(JS_REQUEST_COMPLETE, _params[0], _dataOrEvent);
			}
		}
	}
}