/***
ShowImages
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年5月7日 10:16:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import akdcl.media.MediaPlayer;
	
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.ui.*;
	
	public class ShowImages extends Sprite{
		
		public var xml:XML;
		
		public var btnPrev:Btn;
		public var btnNext:Btn;
		
		public var btnScrollPrev:Btn;
		public var btnScrollNext:Btn;
		
		public var img:Btn;
		private var player:MediaPlayer;
		public var skin:AutoFitMediaSkin;
		
		public var icons:Sprite;
		
		private var IconClass:Class;
		
		private var iconArea:Sprite;
		private var scrollMaskSp:Sprite;
		private var num:int;
		private var d:int;
		
		private var scrollId:int;
		public var currId:int;
		
		//private var info:String;
		//private var infoMenuItem:ContextMenuItem;
		
		private var direction:String;
		
		private var imgNodeName:String;
		
		private var img_align:String;
		
		private var tuijianImgXMLArr:Array;
		
		public var onClickIcon:Function;
		public var onClickImg:Function;
		
		public var currImgXML:XML;
		
		private var selectedIconEnabled:Boolean;
		
		public function ShowImages(_selectedIconEnabled:Boolean,mask_inflate_dx:int=4,mask_inflate_dy:int=4){
			
			selectedIconEnabled=_selectedIconEnabled;
			
			if(icons){
				IconClass=icons.getChildAt(0)["constructor"];
				switch(IconClass){
					case Shape:
					case Bitmap:
					case Sprite:
					case MovieClip:
						throw new Error("需要 IconClass");
					break;
				}
			}
			
			initImg(img);
			initSkin(skin);
			direction="横向";
			initIcons(icons,mask_inflate_dx,mask_inflate_dy);
			initBtns(btnScrollPrev,btnScrollNext,btnPrev,btnNext);
			
			if(skin){
				skin.visible=false;
			}
			if(img){
				img.visible=false;
			}
		}
		
		public function initImg(_img:Btn):void{
			img=_img;
			if(img){
				//var menu:ContextMenu=img.contextMenu;
				//if (menu&&menu.customItems) {
				//}else{
				//	menu=new ContextMenu();
				//}
				//menu.hideBuiltInItems();
				//info="大图："+Math.round(img.width)+"x"+Math.round(img.height);
				//if(icons){
				//	info+="，小图："+Math.round(icons.getChildAt(0).width)+"x"+Math.round(icons.getChildAt(0).height);
				//}
				//infoMenuItem=new ContextMenuItem(info);
				//menu.customItems.push(infoMenuItem);
				//infoMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,copyInfo);
				//this.contextMenu=menu;
				
				var b:Rectangle=img.getBounds(img);
				if(Math.round(b.x)==0){
					img_align=" left";
				}else if(Math.round(b.x)==-Math.round(b.width)){
					img_align=" right";
				}else{
					img_align=" center";
				}
				if(Math.round(b.y)==0){
					img_align+=" top";
				}else if(Math.round(b.y)==-Math.round(b.height)){
					img_align+=" bottom";
				}else{
					img_align+=" middle";
				}
				img_align=img_align.substr(1);
			}
		}
		public function initSkin(_skin:AutoFitMediaSkin):void{
			skin=_skin;
			if(skin){
				player = new MediaPlayer();
				player.repeat = 0;
				skin.setPlayer(player);
				skin.setSize(Math.round(img.width),Math.round(img.height));
			}
		}
		public function initIcons(_icons:Sprite,mask_inflate_dx:int,mask_inflate_dy:int):void{
			icons=_icons;
			if(icons){
				d=icons.getChildAt(1).x-icons.getChildAt(0).x;
				if(d*d<4){
					direction="纵向";
					d=icons.getChildAt(1).y-icons.getChildAt(0).y;
				}
				
				var b:Rectangle=icons.getBounds(icons);
				//向外扩展几像素
				b.inflate(mask_inflate_dx,mask_inflate_dy);
				
				num=icons.numChildren;
				
				var i:int=num;
				while(--i>=0){
					icons.removeChildAt(i);
				}
				
				iconArea=new Sprite();
				icons.addChild(iconArea);
				scrollMaskSp=new Sprite();
				icons.addChild(scrollMaskSp);
				scrollMaskSp.graphics.clear();
				scrollMaskSp.graphics.beginFill(0x000000);
				//scrollMaskSp.graphics.beginFill(0xff0000,0.3);trace("测试");
				scrollMaskSp.graphics.drawRect(b.x,b.y,b.width,b.height);
				scrollMaskSp.graphics.endFill();
				icons.mask=scrollMaskSp;
			}else{
				num=1;
			}
		}
		public function initBtns(...btns):void{
			for each(var btn:Btn in btns){
				if(btn){
					switch(btn.name){
						case "btnScrollPrev":
							btnScrollPrev=btn;
							btnScrollPrev.release=scrollPrev;
						break;
						case "btnScrollNext":
							btnScrollNext=btn;
							btnScrollNext.release=scrollNext;
						break;
						case "btnPrev":
							btnPrev=btn;
							btnPrev.release=prev;
						break;
						case "btnNext":
							btnNext=btn;
							btnNext.release=next;
						break;
					}
				}
			}
		}
		
		public function clear():void{
			clearIcons();
			
			IconClass=null;
			
			xml=null;
			
			if(img){
				(img["img"] as ImgLoader).clear();
			}
			
			//if(infoMenuItem){
			//	infoMenuItem.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,copyInfo);
			//	infoMenuItem=null;
			//}
			
			if(player){
				player.stop();
				player=null;
			}
			
			onClickIcon=null;
			onClickImg=null;
			
			currImgXML=null;
		}
		private function clearIcons():void{
			if(iconArea){
				var i:int=iconArea.numChildren;
				while(--i>=0){
					iconArea.getChildAt(i)["clear"]();
					iconArea.removeChildAt(i);
				}
			}
		}
		
		//private function copyInfo(event:ContextMenuEvent):void{
		//	System.setClipboard(info);
		//}
		
		public function init(_xml:XML,_imgNodeName:String=null):void{
			
			clearIcons();
			
			xml=_xml;
			imgNodeName=_imgNodeName||"img";
			
			if(player){
				player.stop();
			}
			if(skin){
				skin.visible=false;
			}
			if(iconArea){
				iconArea.x=0;
				iconArea.y=0;
			}
			scrollId=0;
			currId=0;
			if(img){
				img.visible=false;
			}
			
			var imgXML:XML,i:int;
			
			if(iconArea){
				var pos:int=0;
				i=-1;
				for each(imgXML in xml[imgNodeName]){
					i++;
					var icon:Btn=new IconClass();
					iconArea.addChild(icon);
					switch(direction){
						case "横向":
							icon.x=pos;
						break;
						case "纵向":
							icon.y=pos;
						break;
					}
					icon["initXML"](imgXML,imgXML.@icon.toString()||imgXML.@src.toString(),clickIcon);
					pos+=d;
				}
			}
			
			tuijianImgXMLArr=new Array();
			
			i=-1;
			for each(imgXML in xml[imgNodeName]){
				i++;
				if(imgXML.@tuijian.toString()=="true"){
					tuijianImgXMLArr.push(imgXML);
				}
			}
			if(tuijianImgXMLArr.length){
			}else{
				i=-1;
				for each(imgXML in xml[imgNodeName]){
					i++;
					tuijianImgXMLArr.push(imgXML);
				}
			}
			
			currId=getImgXMLId(tuijianImgXMLArr[0]);
			
			if(iconArea&&iconArea.numChildren){
				selectIcon(iconArea.getChildAt(currId) as Btn);
			}else{
				selectImgXML(xml[imgNodeName][currId]);
			}
		}
		
		private function clickIcon(icon:Btn):void{
			if(onClickIcon==null){
				selectIcon(icon);
			}else{
				onClickIcon(icon);
			}
		}
		
		public function selectIcon(icon:Btn):void{
			selectImgXML(icon["xml"]);
			
			var i:int=-1;
			for each(var imgXML:XML in xml[imgNodeName]){
				i++;
				var _icon:Btn=iconArea.getChildAt(i) as Btn;
				if(icon==_icon){
					icon.selected=true;
					if(selectedIconEnabled){
					}else{
						icon.mouseEnabled=false;
					}
				}else{
					_icon.selected=false;
					if(selectedIconEnabled){
					}else{
						_icon.mouseEnabled=true;
					}
				}
			}
		}
		public function selectImgXML(imgXML:XML):void{
			
			currImgXML=imgXML;
			
			if(player){
				player.stop();
			}
			
			if(/^.*\.flv$/i.test(imgXML.@src.toString())&&player&&skin){
				if(player){
					player.load(imgXML.@src.toString());
					player.play();
				}
				if(skin){
					skin.visible=true;
				}
				if(img){
					img.visible=false;
				}
			}else{
				if(skin){
					skin.visible=false;
				}
				if(img){
					img.visible=true;
					(img["img"] as ImgLoader).load(<img src={imgXML.@src.toString()} align={img_align}/>);
				}
			}
			
			if(img){
				if(onClickImg==null){
					if(imgXML.@href.toString()||imgXML.@js.toString()){
						img.href=imgXML;
						img.mouseEnabled=true;
					}else{
						img.mouseEnabled=false;
					}
				}else{
					img.mouseEnabled=true;
					img.release=onClickImg;
				}
			}
			
			var i:int=-1;
			for each(var _imgXML:XML in xml[imgNodeName]){
				i++;
				if(imgXML===_imgXML){
					currId=i;
					break;
				}
			}
			
			//var depth:int=0;
			while(currId+1>scrollId+num){
				//trace("+++",currId+1,scrollId+num);
				//if(++depth>100){
				//	break;
				//}
				scrollNext();
			}
			//var depth:int=0;
			while(currId<scrollId){
				//trace("---",currId+1,scrollId+num);
				//if(++depth>100){
				//	break;
				//}
				scrollPrev();
			}
			
			updateBtns();
		}
		
		private function updateBtns():void{
			if(btnScrollPrev){
				if(scrollId>0){
					btnScrollPrev.alpha=1;
					btnScrollPrev.mouseEnabled=true;
				}else{
					btnScrollPrev.alpha=0.5;
					btnScrollPrev.mouseEnabled=false;
				}
			}
			if(btnScrollNext){
				if(scrollId<xml[imgNodeName].length()-num){
					btnScrollNext.alpha=1;
					btnScrollNext.mouseEnabled=true;
				}else{
					btnScrollNext.alpha=0.5;
					btnScrollNext.mouseEnabled=false;
				}
			}
			
			if(btnPrev){
				if(currId>getImgXMLId(tuijianImgXMLArr[0])){
					btnPrev.alpha=1;
					btnPrev.mouseEnabled=true;
				}else{
					btnPrev.alpha=0.5;
					btnPrev.mouseEnabled=false;
				}
			}
			if(btnNext){
				if(currId<getImgXMLId(tuijianImgXMLArr[tuijianImgXMLArr.length-1])){
					btnNext.alpha=1;
					btnNext.mouseEnabled=true;
				}else{
					btnNext.alpha=0.5;
					btnNext.mouseEnabled=false;
				}
			}
		}
		private function scrollPrev():void{
			//scrollId--;
			scrollId-=num;
			if(scrollId<0){
				scrollId=0;
			}
			scroll();
		}
		private function scrollNext():void{
			//scrollId++;
			scrollId+=num;
			if(scrollId+num>=xml[imgNodeName].length()){
				scrollId=xml[imgNodeName].length()-num;
				if(scrollId<0){
					scrollId=0;
				}
			}
			scroll();
		}
		private function scroll():void{
			if(iconArea){
				switch(direction){
					case "横向":
						TweenMax.to(iconArea,0.3,{x:-scrollId*d});
					break;
					case "纵向":
						TweenMax.to(iconArea,0.3,{y:-scrollId*d});
					break;
				}
			}
			
			updateBtns();
		}
		private function prev():void{
			var i:int=currId;
			while(--i>=0){
				var imgXML:XML=xml[imgNodeName][i];
				if(imgXML.@tuijian.toString()=="true"){
					select(i);
					return;
				}
			}
			select(--currId);
		}
		private function next():void{
			var i:int=currId;
			while(++i<xml[imgNodeName].length()){
				var imgXML:XML=xml[imgNodeName][i];
				if(imgXML.@tuijian.toString()=="true"){
					select(i);
					return;
				}
			}
			select(++currId);
		}
		public function select(id:int):void{
			currId=id;
			
			if(iconArea){
				selectIcon(iconArea.getChildAt(currId) as Btn);
			}else{
				selectImgXML(xml[imgNodeName][currId]);
			}
		}
		
		private function getImgXMLId(imgXML:XML):int{
			var i:int=-1;
			for each(var _imgXML:XML in xml[imgNodeName]){
				i++;
				if(imgXML===_imgXML){
					return i;
				}
			}
			throw new Error("getImgXMLId 找不到位置");
		}
	}
}