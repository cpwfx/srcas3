/***
Fangdajing
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 14:36:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders.classic{
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	import zero.shaders.*;
	
	/**
	 * 
	 * 放大镜
	 * 
	 */	
	public class Fangdajing extends BaseShader{
		
		public static const nameV:Vector.<String>=new <String>["alpha","center","strength","radius"];
		//FangdajingCode//为了编译进来
		public static const byteV:Vector.<int>=new <int>[0xa5,0x01,0x00,0x00,0x00,0xa4,0x0a,0x00,0x46,0x61,0x6e,0x67,0x64,0x61,0x6a,0x69,0x6e,0x67,0xa0,0x0c,0x6e,0x61,0x6d,0x65,0x73,0x70,0x61,0x63,0x65,0x00,0x7a,0x65,0x72,0x6f,0x2e,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x2e,0x63,0x6c,0x61,0x73,0x73,0x69,0x63,0x00,0xa0,0x0c,0x76,0x65,0x6e,0x64,0x6f,0x72,0x00,0x5a,0xa7,0xa7,0xa7,0xc1,0xa1,0xe8,0x00,0xa0,0x08,0x76,0x65,0x72,0x73,0x69,0x6f,0x6e,0x00,0x02,0x00,0xa0,0x0c,0x64,0x65,0x73,0x63,0x72,0x69,0x70,0x74,0x69,0x6f,0x6e,0x00,0xb7,0xc5,0xb4,0xf3,0xbe,0xb5,0x00,0xa1,0x01,0x02,0x00,0x00,0x0c,0x5f,0x4f,0x75,0x74,0x43,0x6f,0x6f,0x72,0x64,0x00,0xa1,0x01,0x01,0x00,0x00,0x02,0x61,0x6c,0x70,0x68,0x61,0x00,0xa1,0x01,0x02,0x01,0x00,0x0c,0x63,0x65,0x6e,0x74,0x65,0x72,0x00,0xa1,0x01,0x01,0x00,0x00,0x01,0x73,0x74,0x72,0x65,0x6e,0x67,0x74,0x68,0x00,0xa1,0x01,0x01,0x01,0x00,0x02,0x72,0x61,0x64,0x69,0x75,0x73,0x00,0xa3,0x00,0x04,0x73,0x72,0x63,0x00,0xa1,0x02,0x04,0x02,0x00,0x0f,0x64,0x73,0x74,0x00,0x32,0x01,0x00,0x10,0x00,0x00,0x00,0x00,0x2a,0x01,0x00,0x10,0x00,0x00,0x80,0x00,0x1d,0x01,0x80,0x80,0x00,0x80,0x00,0x00,0x34,0x00,0x00,0x00,0x01,0x80,0x00,0x00,0x1d,0x03,0x00,0xc1,0x00,0x00,0x10,0x00,0x32,0x01,0x00,0x10,0x00,0x00,0x00,0x00,0x2a,0x01,0x00,0x10,0x01,0x00,0x80,0x00,0x1d,0x01,0x80,0x40,0x00,0x80,0x00,0x00,0x34,0x00,0x00,0x00,0x01,0x80,0x40,0x00,0x1d,0x01,0x00,0x10,0x03,0x00,0x00,0x00,0x02,0x01,0x00,0x10,0x01,0x00,0x00,0x00,0x1d,0x03,0x00,0x20,0x01,0x00,0xc0,0x00,0x1d,0x01,0x00,0x10,0x03,0x00,0x40,0x00,0x02,0x01,0x00,0x10,0x01,0x00,0x40,0x00,0x1d,0x03,0x00,0x10,0x01,0x00,0xc0,0x00,0x1d,0x01,0x00,0x10,0x03,0x00,0x80,0x00,0x03,0x01,0x00,0x10,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0xc0,0x00,0x03,0x04,0x00,0x80,0x03,0x00,0xc0,0x00,0x1d,0x04,0x00,0x40,0x01,0x00,0xc0,0x00,0x01,0x04,0x00,0x40,0x04,0x00,0x00,0x00,0x1d,0x01,0x00,0x10,0x04,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x01,0x00,0x80,0x00,0x03,0x04,0x00,0x80,0x01,0x00,0x80,0x00,0x2a,0x01,0x00,0x10,0x04,0x00,0x00,0x00,0x1d,0x01,0x80,0x20,0x00,0x80,0x00,0x00,0x34,0x00,0x00,0x00,0x01,0x80,0x80,0x00,0x16,0x04,0x00,0x80,0x01,0x00,0xc0,0x00,0x1d,0x01,0x00,0x10,0x04,0x00,0x00,0x00,0x32,0x04,0x00,0x80,0x3f,0x80,0x00,0x00,0x1d,0x04,0x00,0x40,0x04,0x00,0x00,0x00,0x02,0x04,0x00,0x40,0x00,0x00,0xc0,0x00,0x1d,0x04,0x00,0x80,0x00,0x00,0xc0,0x00,0x03,0x04,0x00,0x80,0x01,0x00,0xc0,0x00,0x04,0x04,0x00,0x20,0x01,0x00,0x80,0x00,0x03,0x04,0x00,0x20,0x04,0x00,0x00,0x00,0x1d,0x04,0x00,0x80,0x04,0x00,0x40,0x00,0x01,0x04,0x00,0x80,0x04,0x00,0x80,0x00,0x1d,0x01,0x00,0x10,0x04,0x00,0x00,0x00,0x1d,0x04,0x00,0x20,0x03,0x00,0x80,0x00,0x03,0x04,0x00,0x20,0x01,0x00,0xc0,0x00,0x1d,0x04,0x00,0x10,0x01,0x00,0x00,0x00,0x01,0x04,0x00,0x10,0x04,0x00,0x80,0x00,0x1d,0x04,0x00,0x80,0x04,0x00,0xc0,0x00,0x1d,0x04,0x00,0x20,0x03,0x00,0xc0,0x00,0x03,0x04,0x00,0x20,0x01,0x00,0xc0,0x00,0x1d,0x04,0x00,0x10,0x01,0x00,0x40,0x00,0x01,0x04,0x00,0x10,0x04,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x04,0x00,0xc0,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x02,0x00,0xf3,0x05,0x00,0x1b,0x00,0x35,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x30,0x04,0x00,0xf1,0x03,0x00,0x10,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x36,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x35,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x30,0x04,0x00,0xf1,0x03,0x00,0x10,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x36,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x02,0x00,0x10,0x00,0x00,0x80,0x00,0x35,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x32,0x02,0x00,0x80,0x00,0x00,0x00,0x00,0x32,0x02,0x00,0x40,0x00,0x00,0x00,0x00,0x32,0x02,0x00,0x20,0x00,0x00,0x00,0x00,0x32,0x02,0x00,0x10,0x00,0x00,0x00,0x00,0x36,0x00,0x00,0x00,0x00,0x00,0x00,0x00];
		
		/**
		 * 
		 * 透明度 （0~1） 默认 1
		 * 
		 */
		public var alpha:Number;
		
		/**
		 * 
		 * 坐标 默认 null
		 * 
		 */
		public var center:Float2;
		
		/**
		 * 
		 * 强度 （-1~1） 默认 0.5
		 * 
		 */
		public var strength:Number;
		
		/**
		 * 
		 * 半径 （0~2048） 默认 100
		 * 
		 */
		public var radius:Number;
		

		/**
		 * 
		 * 透明度 （0~1） 默认 1<br/>
		 * 坐标 默认 null<br/>
		 * 强度 （-1~1） 默认 0.5<br/>
		 * 半径 （0~2048） 默认 100<br/>
		 * 
		 */
		public function Fangdajing(_alpha:Number=1,_center:Float2=null,_strength:Number=0.5,_radius:Number=100){
			alpha=_alpha;
			(data.alpha as ShaderParameter).value=[];
			center=_center;
			(data.center as ShaderParameter).value=[];
			strength=_strength;
			(data.strength as ShaderParameter).value=[];
			radius=_radius;
			(data.radius as ShaderParameter).value=[];
		}
		
		override public function updateParams():void{
			(data.alpha as ShaderParameter).value[0]=alpha;
			(data.center as ShaderParameter).value[0]=center.x;
			(data.center as ShaderParameter).value[1]=center.y;
			(data.strength as ShaderParameter).value[0]=strength;
			(data.radius as ShaderParameter).value[0]=radius;
		}
		

	}
}