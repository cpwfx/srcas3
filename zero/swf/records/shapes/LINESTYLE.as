﻿/***
LINESTYLE 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 21:46:22 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A line style has two parts, an unsigned 16-bit integer indicating the width of a line in twips,
//and a color. Here is the file description:
//LINESTYLE
//Field 			Type 					Comment
//Width 			UI16 					Width of line in twips
//Color 			RGB (Shape1 or Shape2)
//					RGBA (Shape3)			Color value including alpha channel information for Shape3
//The color in this case is a 24-bit RGB, but if we were doing a DefineShape3, it would be a 32-
//bit RGBA where alpha is the opacity of the color.
package zero.swf.records.shapes{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class LINESTYLE{
		public var Width:int;							//UI16
		public var Color:uint;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			Width=data[offset++]|(data[offset++]<<8);
			if(_initByDataOptions&&_initByDataOptions.ColorUseRGBA){//20110813
				Color=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			}else{
				Color=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=Width;
			data[1]=Width>>8;
			if(_toDataOptions&&_toDataOptions.ColorUseRGBA){//20110813
				data[2]=Color>>16;
				data[3]=Color>>8;
				data[4]=Color;
				data[5]=Color>>24;
			}else{
				data[2]=Color>>16;
				data[3]=Color>>8;
				data[4]=Color;
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.records.shapes.LINESTYLE"
				Width={Width}
			/>;
			if(_toXMLOptions&&_toXMLOptions.ColorUseRGBA){//20110813
				xml.@Color="0x"+BytesAndStr16._16V[(Color>>24)&0xff]+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff];
			}else{
				xml.@Color="0x"+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff];
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			Width=int(xml.@Width.toString());
			Color=uint(xml.@Color.toString());
		}
		}//end of CONFIG::USE_XML
	}
}
