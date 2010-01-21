﻿package akdcl.application
{
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import com.greensock.TweenMax;
	import akdcl.application.PicPlayer;
	import ui_2.ProgressBar;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class  PicPlayerSkin extends Sprite
	{
		public var bar_progress:ProgressBar;
		public var btn_0, btn_1, btn_2, btn_3, btn_4, btn_5, btn_6, btn_7, btn_8, btn_9:*;
		public var btn_info:*;
		public var btn_progress:*;
		public var btn_prev:*;
		public var btn_next:*;
		
		protected var btn_select:*;
		protected var btnList:Array;
		protected var picPlayer:PicPlayer;
		public function PicPlayerSkin() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		protected function added(_evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
			visible = false;
			alpha = 0;
		}
		protected function removed(_evt:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			picPlayer.removeEventListener(PicPlayer.LOADING, onPlayerLoadingHandle);
			picPlayer.removeEventListener(PicPlayer.STATE_CHANGE,onPlayerStateChangeHandle);
			picPlayer.removeEventListener(PicPlayer.LOADING,onPlayerLoadingHandle);
			picPlayer = null;
		}
		public function setPlayer(_picPlayer:PicPlayer):void {
			picPlayer = _picPlayer;
			picPlayer.addEventListener(PicPlayer.XML_LOADED, onPlayerXmlLoadedHandle);
			picPlayer.addEventListener(PicPlayer.STATE_CHANGE,onPlayerStateChangeHandle);
			picPlayer.addEventListener(PicPlayer.LOADING, onPlayerLoadingHandle);
			if (bar_progress) {
				bar_progress.mouseEnabled = false;
				bar_progress.mouseChildren = false;
			}
			if (btn_info) {
				btn_info.release = picPlayer.clickPic;
			}
			if (btn_prev) {
				btn_prev.release = function():void {
					picPlayer.id_pic--;
				}
			}
			if (btn_next) {
				btn_next.release =function():void {
					picPlayer.id_pic++;
				}
			}
			if (btn_progress) {
				//btn_progress
			}
		}
		private var __isRollOver:Boolean = false;
		public function get isRollOver():Boolean {
			return __isRollOver;
		}
		[Inspectable(defaultValue = false, type = "Boolean", name = "是否指向选择")]
		public function set isRollOver(_isRollOver:Boolean):void {
			__isRollOver = _isRollOver;
		}
		private var __against:Boolean = false;
		public function get against():Boolean {
			return __against;
		}
		[Inspectable(defaultValue = false, type = "Boolean", name = "标签是否逆向对齐")]
		public function set against(_against:Boolean):void {
			__against = _against;
		}
		private var __horizontal:Boolean = true;
		public function get horizontal():Boolean {
			return __horizontal;
		}
		[Inspectable(defaultValue = true, type = "Boolean", name = "标签是否水平排布")]
		public function set horizontal(_horizontal:Boolean):void {
			__horizontal = _horizontal;
		}
		private var __btnDistance:uint = 25;
		public function get btnDistance():uint {
			return __btnDistance;
		}
		[Inspectable(defaultValue = 25, type = "uint", name = "标签间距")]
		public function set btnDistance(_btnDistance:uint):void {
			__btnDistance = _btnDistance;
		}
		protected function onPlayerXmlLoadedHandle(_evt:Event):void {
			TweenMax.to(this, picPlayer.timeTween, { autoAlpha:1 } );
			if (!btn_0) {
				return;
			}
			btnList = [];
			var _startX:uint = btn_0.x;
			var _startY:uint = btn_0.y;
			var _BtnClass:Class = btn_0.constructor as Class;
			var _btn:*;
			var _i:uint;
			var _label:String;
			for (_i = 0; _i < 10; _i++ ) {
				_btn = this["btn_" + _i];
				if (!_btn) {
					break;
				}
				btnList[_i] = _btn;
			}
			for (_i = 0; _i < picPlayer.picLength; _i++ ) {
				_btn = btnList[_i];
				if (!_btn) {
					_btn = new _BtnClass();
					addChild(_btn);
					btnList[_i] = _btn;
				}
				if (horizontal) {
					_btn.y = _startY;
					if (against) {
						_btn.x = _startX + (_i-picPlayer.picLength+1) * btnDistance;
					}else {
						_btn.x = _startX + _i * btnDistance;
					}
				}else {
					_btn.x = _startX;
					if (against) {
						_btn.y = _startY + (_i-picPlayer.picLength+1) * btnDistance;
					}else {
						_btn.y = _startY + _i * btnDistance;
					}
					_btn.y = _startY + _i * (against? -btnDistance:btnDistance);
				}
				_label = String(picPlayer.getPicXML(_i).@label);
				_btn.label = _label || String(_i + 1);
				_btn.autoSize = "center";
				_btn.userData = { id:_i };
				_btn.release = function():void {
					picPlayer.id_pic = this.userData.id;
				}
				if (isRollOver) {
					_btn.rollOver = _btn.release;
				}
			}
		}
		protected function onPlayerLoadingHandle(_evt:ProgressEvent):void{
			if (!bar_progress) {
				return;
			}
			var _value:Number = _evt.bytesLoaded / _evt.bytesTotal;
			bar_progress.value=_value;
			if(bar_progress.value==1){
				TweenMax.to(bar_progress,picPlayer.timeTween,{autoAlpha:0});
			}else if(!bar_progress.visible){
				TweenMax.to(bar_progress,picPlayer.timeTween,{autoAlpha:1});
			}
		}
		protected function onPlayerStateChangeHandle(_evt:Event):void {
			switch (picPlayer.state) {
				case PicPlayer.LOADED:
				case PicPlayer.RELOADED:
					if (btn_info) {
						btn_info.label = picPlayer.getPicXML(picPlayer.id_pic).@info;
					}
					if (btn_progress) {
						btn_progress.label = (picPlayer.id_pic + 1) + " / " + picPlayer.picLength;
					}
					btn_select = btnList[picPlayer.id_pic];
					btn_select.select = true;
					break;
				case PicPlayer.TWEENED:
					mouseChildren = true;
					mouseEnabled = true;
					break;
				case PicPlayer.LOAD:
				case PicPlayer.RELOAD:
					mouseChildren = false;
					mouseEnabled = false;
					if (btn_select) {
						btn_select.select = false;
					}
					break;
			}
		}
	}
}