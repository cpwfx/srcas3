package akdcl.media {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.events.Event;

	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;

	import akdcl.manager.ElementManager;

	/**
	 * ...
	 * @author ...
	 */

	public class SoundItem {
		public static function setChannelVolume(_channel:SoundChannel, _volume:Number):void {
			var _soundTransform:SoundTransform = _channel.soundTransform;
			_soundTransform.volume = _volume;
			_channel.soundTransform = _soundTransform;
		}

		public var maxVolume:Number = 1;

		private var positionLast:uint = 0;
		private var sound:Sound;
		private var soundTransform:SoundTransform;
		private var channelNow:SoundChannel;
		private var channelList:Array;

		private var eM:ElementManager;


		public function get totalTime():uint {
			var _totalTime:uint;
			if (sound){
				_totalTime = sound.length / loadProgress;
			} else {
				_totalTime = 0;
			}
			return _totalTime;
		}

		public function get loadProgress():Number {
			var _loadProgress:Number;
			if (sound){
				_loadProgress = sound.bytesLoaded / sound.bytesTotal;
			} else {
				_loadProgress = 0;
			}
			return _loadProgress;
		}

		public function get playProgress():Number {
			var _playProgress:Number = position / totalTime;
			if (isNaN(_playProgress)){
				_playProgress = 0;
			}
			return _playProgress;
		}

		public function set playProgress(_playProgress:Number):void {
			position = _playProgress * totalTime;
		}

		public function get position():uint {
			if (channelNow && sound.length > 0){
				return channelNow.position;
			} else {
				return positionLast;
			}
		}

		public function set position(_position:uint):void {
			if (channelNow && sound.length > 0){
				//channelNow
				play(_position);
			} else {
				positionLast = _position;
			}
		}
		private var __volume:Number = 1;

		public function get volume():Number {
			return __volume * maxVolume;
		}

		public function set volume(_volume:Number):void {
			if (_volume < 0){
				_volume = 0;
			} else if (_volume > 1){
				_volume = 1;
			}
			__volume = _volume;
			if (channelNow){
				setChannelVolume(channelNow, __volume * maxVolume);
			}

		}

		public function SoundItem(_sound:Sound, _maxVolume:Number = 1) {
			maxVolume = _maxVolume;
			channelList = [];
			eM = ElementManager.getInstance();
			eM.register("TweenObject", TweenObject);
			sound = _sound;
			soundTransform = new SoundTransform(volume, 0);
		}

		public function play(_startTime:Number = -1, _loops:uint = 0, _tempVolume:Number = 1, _tweenIn:Number = 0, _tweenOut:Number = 0):SoundChannel {
			if (_startTime < 0){
				_startTime = 0;
			} else if (_startTime <= 1){
				//0~1（playProgress）
				if (_startTime > loadProgress){
					_startTime = loadProgress * 0.999;
				}
				_startTime = totalTime * _startTime;
			} else {
				//1~XX（playTime毫秒为单位）
				var _loadTime:uint = totalTime * loadProgress;
				if (_startTime > _loadTime){
					_startTime = _loadTime * 0.999;
				}
			}

			if (positionLast > 0){
				_startTime = positionLast;
			}
			positionLast = 0;

			try {
				soundTransform.volume = volume * _tempVolume;
				var _channel:SoundChannel = sound.play(_startTime, _loops, soundTransform);
				_channel.addEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
				channelList.push(_channel);
				channelNow = _channel;

				if (_tweenIn == 0){

				} else if (_tweenIn <= 1){
					(eM.getElement("TweenObject") as TweenObject).tweenChannel(this, channelNow, totalTime * _tweenIn * 0.001, 0, 1, _tempVolume);
				} else {
					(eM.getElement("TweenObject") as TweenObject).tweenChannel(this, channelNow, _tweenIn * 0.001, 0, 1, _tempVolume);
				}
				//
				if (_tweenOut == 0){

				} else if (_tweenOut <= 1){
					(eM.getElement("TweenObject") as TweenObject).tweenChannel(this, channelNow, totalTime * _tweenOut * 0.001, totalTime * (1 - _tweenOut) * 0.001, 0, _tempVolume);
				} else {
					(eM.getElement("TweenObject") as TweenObject).tweenChannel(this, channelNow, _tweenOut * 0.001, (totalTime - _tweenOut) * 0.001, 0, _tempVolume);
				}
			} catch (_error:*){

			}
			return _channel;
		}

		public function pause():void {
			positionLast = position;
			removeAllChannel();
		}

		public function stop():void {
			positionLast = 0;
			removeAllChannel();
		}

		private function removeAllChannel():void {
			for each (var _channel:SoundChannel in channelList){
				_channel.stop();
				_channel.removeEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
			}
			channelList = [];
			if (channelNow){
				channelNow.stop();
			}
		}

		private function onChannelCompleteHandler(_evt:Event):void {
			var _channel:SoundChannel = _evt.currentTarget as SoundChannel;
			_channel.removeEventListener(Event.SOUND_COMPLETE, onChannelCompleteHandler);
			var _id:int = channelList.indexOf(_channel);
			if (_id >= 0){
				channelList.splice(_id, 1);
			}
		}
	}
}
import flash.media.SoundChannel;

import com.greensock.easing.Sine;
import com.greensock.TweenLite;

import akdcl.media.SoundItem;

import akdcl.manager.ElementManager;

class TweenObject {
	public var volume:Number = 1;

	private var soundItem:SoundItem;
	private var channel:SoundChannel;
	private var tempVolume:Number = 1;
	private var tweenVars:Object = {volume: 1, overwrite: 0, delay: 0, ease: Sine.easeInOut, onUpdate: onTweenUpdate, onComplete: onTweenComplete};

	public function tweenChannel(_soundItem:SoundItem, _channel:SoundChannel, _tween:Number, _delay:Number = 0, _tweenVolume:Number = 0, _tempVolume:Number = 1):void {
		soundItem = _soundItem;
		channel = _channel;
		tempVolume = _tempVolume;
		tweenVars.delay = _delay;
		tweenVars.volume = _tweenVolume;
		if (_tweenVolume == 1){
			volume = 0;
			onTweenUpdate();
		} else {
			volume = soundItem.volume;
		}

		TweenLite.to(this, _tween, tweenVars);
	}

	private function onTweenUpdate():void {
		SoundItem.setChannelVolume(channel, soundItem.volume * tempVolume * volume);
	}

	private function onTweenComplete():void {
		TweenLite.killTweensOf(this);
		ElementManager.getInstance().recycle(this);
	}
}