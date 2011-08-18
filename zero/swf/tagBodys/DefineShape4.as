﻿/***
DefineShape4 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 22:43:31 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DefineShape4
//DefineShape4 extends the capabilities of DefineShape3 by using a new line style record in the
//shape. LINESTYLE2 allows new types of joins and caps as well as scaling options and the
//ability to fill a stroke.
//DefineShape4 specifies not only the shape bounds but also the edge bounds of the shape.
//While the shape bounds are calculated along the outside of the strokes, the edge bounds are
//taken from the outside of the edges, as shown in the following diagram. The EdgeBounds
//field assists Flash Player in accurately determining certain layouts.
//In addition, DefineShape4 includes new hinting flags UsesNonScalingStrokes and
//UsesScalingStrokes. These flags assist Flash Player in creating the best possible area for
//invalidation.
//The minimum file format version is SWF 8.
//
//DefineShape4
//Field 					Type 			Comment
//Header 					RECORDHEADER 	Tag type = 83.
//ShapeId 					UI16 			ID for this character.
//ShapeBounds 				RECT 			Bounds of the shape.
//EdgeBounds 				RECT 			Bounds of the shape, excluding strokes.
//Reserved 					UB[5] 			Must be 0.
//UsesFillWindingRule 		UB[1] 			If 1, use fill winding rule. Minimum file format version is SWF 10
//UsesNonScalingStrokes 	UB[1] 			If 1, the shape contains at least one non-scaling stroke.
//UsesScalingStrokes 		UB[1] 			If 1, the shape contains at least one scaling stroke.
//Shapes 					SHAPEWITHSTYLE 	Shape information.
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.SHAPEWITHSTYLE;
	public class DefineShape4{
		public var id:int;								//UI16
		public var ShapeBounds:*;
		public var EdgeBounds:*;
		public var UsesFillWindingRule:Boolean;
		public var UsesNonScalingStrokes:Boolean;
		public var UsesScalingStrokes:Boolean;
		public var Shapes:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(_initByDataOptions){
			}else{
				_initByDataOptions=new Object();
			}
			_initByDataOptions.ColorUseRGBA=true;//20110813
			_initByDataOptions.LineStyleUseLINESTYLE2=true;//20110814
			
			id=data[offset++]|(data[offset++]<<8);
			var ShapeBoundsClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					ShapeBoundsClass=_initByDataOptions.classes["zero.swf.records.RECT"];
				}
			}
			ShapeBounds=new (ShapeBoundsClass||RECT)();
			offset=ShapeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			var EdgeBoundsClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					EdgeBoundsClass=_initByDataOptions.classes["zero.swf.records.RECT"];
				}
			}
			EdgeBounds=new (EdgeBoundsClass||RECT)();
			offset=EdgeBounds.initByData(data,offset,endOffset,_initByDataOptions);
			var ShapesClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					ShapesClass=_initByDataOptions.classes["zero.swf.records.shapes.SHAPEWITHSTYLE"];
				}
			}
			var flags:int=data[offset++];
			//Reserved=flags&0xf8;											//11111000
			UsesFillWindingRule=((flags&0x04)?true:false);					//00000100
			UsesNonScalingStrokes=((flags&0x02)?true:false);				//00000010
			UsesScalingStrokes=((flags&0x01)?true:false);					//00000001
			Shapes=new (ShapesClass||SHAPEWITHSTYLE)();
			return Shapes.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			
			if(_toDataOptions){
			}else{
				_toDataOptions=new Object();
			}
			_toDataOptions.ColorUseRGBA=true;//20110813
			
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(ShapeBounds.toData(_toDataOptions));
			data.writeBytes(EdgeBounds.toData(_toDataOptions));
			var offset:int=data.length;
			var flags:int=0;
			//flags|=Reserved												//11111000
			if(UsesFillWindingRule){
				flags|=0x04;												//00000100
			}
			if(UsesNonScalingStrokes){
				flags|=0x02;												//00000010
			}
			if(UsesScalingStrokes){
				flags|=0x01;												//00000001
			}
			data[offset++]=flags;
			data.position=offset;
			data.writeBytes(Shapes.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			
			if(_toXMLOptions){
			}else{
				_toXMLOptions=new Object();
			}
			_toXMLOptions.ColorUseRGBA=true;//20110813
			
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineShape4"
				id={id}
				UsesFillWindingRule={UsesFillWindingRule}
				UsesNonScalingStrokes={UsesNonScalingStrokes}
				UsesScalingStrokes={UsesScalingStrokes}
			/>;
			xml.appendChild(ShapeBounds.toXML("ShapeBounds",_toXMLOptions));
			xml.appendChild(EdgeBounds.toXML("EdgeBounds",_toXMLOptions));
			xml.appendChild(Shapes.toXML("Shapes",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			var ShapeBoundsXML:XML=xml.ShapeBounds[0];
			ShapeBounds=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[ShapeBoundsXML["@class"].toString()]||RECT)();
			ShapeBounds.initByXML(ShapeBoundsXML,_initByXMLOptions);
			var EdgeBoundsXML:XML=xml.EdgeBounds[0];
			EdgeBounds=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[EdgeBoundsXML["@class"].toString()]||RECT)();
			EdgeBounds.initByXML(EdgeBoundsXML,_initByXMLOptions);
			UsesFillWindingRule=(xml.@UsesFillWindingRule.toString()=="true");
			UsesNonScalingStrokes=(xml.@UsesNonScalingStrokes.toString()=="true");
			UsesScalingStrokes=(xml.@UsesScalingStrokes.toString()=="true");
			var ShapesXML:XML=xml.Shapes[0];
			Shapes=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[ShapesXML["@class"].toString()]||SHAPEWITHSTYLE)();
			Shapes.initByXML(ShapesXML,_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}