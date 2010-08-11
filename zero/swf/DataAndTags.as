﻿/***
DataAndTags 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年1月13日 14:42:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.utils.*;
	public class DataAndTags{
		public var data:ByteArray;
		public var FrameCount:int;
		public var tagV:Vector.<Tag>;
		
		public function initByData(_data:ByteArray,offset:int,endOffset:int):void{
			data=_data;
			FrameCount=data[offset++]|(data[offset++]<<8);//帧数是一个int, 在SWF里以 UI16(Unsigned 16-bit integer value, 16位无符号整数) 的结构保存
			//trace("FrameCount="+FrameCount);
			tagV=new Vector.<Tag>();
			var tag:Tag;
			var tagId:int=-1;
			while(offset<endOffset){
				tagV[++tagId]=tag=new Tag();
				tag.initByData(data,offset);
				offset=tag.bodyOffset+tag.bodyLength;
				//trace(TagType.typeArr[tag.type]);
			}
			//trace("---------------------------------------");
		}
		public function getData(newData:ByteArray,offset:int):void{
			//trace("FrameCount="+FrameCount);
			newData[offset++]=FrameCount;
			newData[offset++]=FrameCount>>8;
			newData.position=offset;
			for each(var tag:Tag in tagV){
				//trace(TagType.typeArr[tag.type]);
				newData.writeBytes(data,tag.headOffset,tag.bodyOffset-tag.headOffset+tag.bodyLength);
			}
			//trace("---------------------------------------");
		}
		
		public function forEachTag(fun:Function):void{
			var tagId:int=-1;
			for each(var tag:Tag in tagV){
				fun(data,tag,++tagId);
			}
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