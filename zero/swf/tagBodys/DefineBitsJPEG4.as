﻿/***
DefineBitsJPEG4 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 16:01:28 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//This tag defines a bitmap character with JPEG compression. This tag extends
//DefineBitsJPEG3, adding a deblocking parameter. While this tag also supports PNG and
//GIF89a data, the deblocking filter (和 cs4 里的 "启用jpeg解块"有关?) is not applied to such data.
//The minimum file format version for this tag is SWF 10.
//
//DefineBitsJPEG4
//Field 				Type 					Comment
//Header 				RECORDHEADER (long) 	Tag type = 90.
//CharacterID 			UI16 					ID for this character.
//AlphaDataOffset 		UI32 					Count of bytes in ImageData.
//DeblockParam 			UI16 					Parameter to be fed into the deblocking filter. The parameter describes a relative strength of the deblocking filter from 0-100% expressed in a normalized 8.8 fixed point format.
//ImageData 			UI8[data size] 			Compressed image data in either JPEG, PNG, or GIF89a format.
//BitmapAlphaData 		UI8[alpha data size] 	ZLIB compressed array of alpha data. Only supported when tag contains JPEG data. One byte per pixel. Total size after decompression must equal (width * height) of JPEG image.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineBitsJPEG4{
		public var id:int;								//UI16
		
		public var DeblockParam:Number;					//FIXED8
		public var ImageData:BytesData;
		public var BitmapAlphaData:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			var AlphaDataOffset:int=data[offset+2]|(data[offset+3]<<8)|(data[offset+4]<<16)|(data[offset+5]<<24);
			DeblockParam=data[offset+6]/256+data[offset+7];
			offset+=8;
			ImageData=new BytesData();
			offset=ImageData.initByData(data,offset,offset+AlphaDataOffset-2);
			
			BitmapAlphaData=new BytesData();
			return BitmapAlphaData.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			var AlphaDataOffset:int=ImageData.dataLength+2;
			data[2]=AlphaDataOffset;
			data[3]=AlphaDataOffset>>8;
			data[4]=AlphaDataOffset>>16;
			data[5]=AlphaDataOffset>>24;
			data[6]=DeblockParam*256;
			data[7]=DeblockParam;
			data.position=8;
			data.writeBytes(ImageData.toData());
			data.writeBytes(BitmapAlphaData.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineBitsJPEG4"
				id={id}
				DeblockParam={DeblockParam}
			/>;
			
			xml.appendChild(ImageData.toXML("ImageData"));
			xml.appendChild(BitmapAlphaData.toXML("BitmapAlphaData"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			
			DeblockParam=Number(xml.@DeblockParam.toString());
			ImageData=new BytesData();
			ImageData.initByXML(xml.ImageData[0]);
			BitmapAlphaData=new BytesData();
			BitmapAlphaData.initByXML(xml.BitmapAlphaData[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
