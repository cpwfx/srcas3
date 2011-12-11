package akdcl.media {
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import akdcl.display.UISprite;
	import akdcl.events.MediaEvent;
	import akdcl.utils.setProgressClip;
	import akdcl.media.providers.MediaProvider;

	/**
	 * ...
	 * @author Akdcl
	 */
	public class PlayerSkin extends UISprite {
		protected static function complexTime(_position:uint, _totalTime:uint):String {
			var _timePlayed:String;
			var _timeTotal:String;
			_timePlayed = formatTime(_position * 0.001);
			_timeTotal = formatTime(_totalTime * 0.001);
			return _timePlayed + " / " + _timeTotal;
		}

		//格式化时间
		protected static function formatTime(_n:uint):String {
			var minutes:uint;
			var seconds:uint;
			if (_n < 60){
				minutes = 0;
				seconds = _n;
			} else if (_n < 3600){
				minutes = Math.floor(_n / 60);
				seconds = _n % 60;
			}
			var s_m:String = minutes < 10 ? "0" + String(minutes) : String(minutes);
			var s_s:String = seconds < 10 ? "0" + String(seconds) : String(seconds);
			return s_m + ":" + s_s;
		}

		public var btnPlay:InteractiveObject;
		public var btnPause:InteractiveObject;
		public var btnStop:InteractiveObject;
		public var btnPlayPause:InteractiveObject;
		public var btnPlayStop:InteractiveObject;
		public var btnPrev:InteractiveObject;
		public var btnNext:InteractiveObject;
		public var btnVolume:InteractiveObject;
		
		public var barVolume:*;
		public var barPlayProgress:*;
		public var txtPlayProgress:*;
		public var loadProgressClip:*;
		public var bufferProgressClip:*;
		
		protected var player:MediaProvider;
		
		override protected function onAddedToStageHandler(_evt:Event):void 
		{
			super.onAddedToStageHandler(_evt);
			addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		override protected function onRemoveHandler():void 
		{
			super.onRemoveHandler();
			setPlayer(null);
		}
		
		protected function onClickHandler(_e:Event):void {
			if (player == null) {
				return
			}
			var _target:InteractiveObject = _e.target as InteractiveObject;
			switch(_target) {
				case btnPlay:
					player.play();
					break;
				case btnPause:
					player.pause();
					break;
				case btnStop:
					player.stop();
					break;
				case btnPlayPause:
					playOrPause();
					break;
				case btnPlayStop:
					playOrPause();
					break;
				case btnPrev:
					(player as MediaPlayer).prev();
					break;
				case btnNext:
					(player as MediaPlayer).next();
					break;
				case btnVolume:
					player.mute = !player.mute;
					break;
			}
		}

		public function setPlayer(_player:MediaProvider):void {
			removePlayerEvent();
			if (_player == null) {
				player = null;
				return;
			}
			player = _player;
			onVolumeChangeHandler(null);
			
			if (barVolume){
				barVolume.maximum = 1;
				barVolume.snapInterval = 0.004;
				barVolume.change = onVolumeCtrlHandler;
			}
			if (barPlayProgress){
				if (barPlayProgress.track && "value" in barPlayProgress.track) {
					loadProgressClip = barPlayProgress.track;
				} else if (barPlayProgress.progressClip){
					loadProgressClip = barPlayProgress.progressClip;
				}
				if (txtPlayProgress){
					barPlayProgress.txt = txtPlayProgress; 
				}
				barPlayProgress.maximum = 1;
				barPlayProgress.snapInterval = 0.004;
				barPlayProgress.labelFunction = timeLabelFunction;
				barPlayProgress.setStyle();
				barPlayProgress.release = onProgressCtrlHandler;
			}
			
			if (loadProgressClip && "maximum" in loadProgressClip) {
				loadProgressClip.maximum = 1;
				loadProgressClip.snapInterval = 0.004;
				loadProgressClip.enabled = false;
				loadProgressClip.value = 0;
			}
			addPlayerEvent();
			onStateChangeHandler(null);
		}
		
		private function onVolumeCtrlHandler(_value:Number):void {
			if (player) {
				player.volume = _value;
			}
		}
		
		private function onProgressCtrlHandler():void 
		{
			if (player) {
				player.playProgress = barPlayProgress.value * 0.999;
			}
		}
		
		protected function addPlayerEvent():void {
			if (player){
				player.addEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
				player.addEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
				player.addEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
				player.addEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				player.addEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				player.addEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
			}
		}
		
		protected function removePlayerEvent():void {
			if (player){
				player.removeEventListener(MediaEvent.STATE_CHANGE, onStateChangeHandler);
				player.removeEventListener(MediaEvent.VOLUME_CHANGE, onVolumeChangeHandler);
				player.removeEventListener(MediaEvent.PLAY_PROGRESS, onPlayProgressHandler);
				player.removeEventListener(MediaEvent.LOAD_PROGRESS, onLoadProgressHandler);
				player.removeEventListener(MediaEvent.BUFFER_PROGRESS, onBufferProgressHandler);
				player.removeEventListener(MediaEvent.LOAD_COMPLETE, onLoadCompleteHandler);
			}
		}

		protected function playOrPause():void {
			if (player) {
				if (player.isPlaying){
					player.pause();
				} else {
					player.play();
				}
			}
		}

		protected function playOrStop():void {
			if (player) {
				if (player.isPlaying){
					player.stop();
				} else {
					player.play();
				}
			}
		}

		//
		protected function timeLabelFunction(_value:Number):String {
			var _totalTime:uint = player.totalTime;
			var _str:String = complexTime(_totalTime * _value, _totalTime);
			return _str;
		}

		private static const BTN_SELECTED:String = "selected";
		//
		protected function onStateChangeHandler(_evt:MediaEvent):void {
			if (btnPlay && BTN_SELECTED in btnPlay) {
				btnPlay[BTN_SELECTED] = player.isPlaying;
			}
			if (btnPlayPause && BTN_SELECTED in btnPlayPause){
				btnPlayPause[BTN_SELECTED] = player.isPlaying;
			}
			if (btnPlayStop && BTN_SELECTED in btnPlayStop){
				btnPlayStop[BTN_SELECTED] = player.isPlaying;
			}
			if (btnPause && BTN_SELECTED in btnPause){
				btnPause[BTN_SELECTED] = player.playState == PlayState.PAUSE;
			}
			/*
			if (btnStop && BTN_SELECTED in btnStop){
				btnStop[BTN_SELECTED] = player.playState == PlayState.STOP;
			}
			*/
			onLoadProgressHandler(null);
			onBufferProgressHandler(null);
			onPlayProgressHandler(null);
		}

		protected function onVolumeChangeHandler(_evt:MediaEvent):void {
			if (btnVolume) {
				if (BTN_SELECTED in btnVolume) {
					btnVolume[BTN_SELECTED] = player.mute;
				}
				if ("valueClip" in btnVolume) {
					if (player.mute) {
						btnVolume["valueClip"].gotoAndStop(1);
					} else {
						btnVolume["valueClip"].gotoAndStop(1 + 1 + int(player.volume * (btnVolume["valueClip"].totalFrames - 2)));
					}
				}
			}
			if (barVolume){
				barVolume.value = player.volume;
			}
		}

		protected function onPlayProgressHandler(_evt:MediaEvent):void {
			if (barPlayProgress && !barPlayProgress.isHold){
				barPlayProgress.value = player.playProgress;
			}
		}

		protected function onLoadProgressHandler(_evt:MediaEvent):void {
			setProgressClip(loadProgressClip, player.loadProgress);
		}

		protected function onBufferProgressHandler(_evt:MediaEvent):void {
			setProgressClip(bufferProgressClip, player.bufferProgress, true);
		}
		
		protected function onLoadCompleteHandler(_evt:MediaEvent):void {
			onLoadProgressHandler(null);
			onBufferProgressHandler(null);
			onPlayProgressHandler(null);
		}
	}

}