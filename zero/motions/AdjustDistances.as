﻿/***
AdjustDistances 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月3日 09:39:51
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.motions{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	
	public class AdjustDistances extends Sprite{//就为了有个 enterframe 事件扩展 Sprite - -
		private var dspObjArr:Array;
		private var left:Number;
		private var right:Number;
		public function AdjustDistances(..._dspObjArr){
			dspObjArr=_dspObjArr;
			var rect:Rectangle=new Rectangle(0,0,0,0);
			for each(var dspObj:DisplayObject in dspObjArr){
				rect=rect.union(dspObj.getBounds(dspObj.parent));
			}
			
			left=rect.left;
			right=rect.right;
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		public function clear():void{
			dspObjArr=null;
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			var widSum:Number=0;
			var dspObj:DisplayObject;
			var rect:Rectangle;
			for each(dspObj in dspObjArr){
				rect=dspObj.getBounds(dspObj.parent);
				widSum+=rect.width;
			}
			var d:Number=((right-left)-widSum)/(dspObjArr.length-1);
			var x:int=left;
			for each(dspObj in dspObjArr){
				rect=dspObj.getBounds(dspObj.parent);
				dspObj.x+=x-rect.x;
				x+=rect.width+d;
			}
			
			//最右边的有些振动，调一下：
			dspObj=dspObjArr[dspObjArr.length-1];
			rect=dspObj.getBounds(dspObj.parent);
			dspObj.x+=right-rect.right;
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/