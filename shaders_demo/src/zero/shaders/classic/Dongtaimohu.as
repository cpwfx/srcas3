/***
Dongtaimohu
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月06日 15:04:41
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
	 * 动态模糊
	 * 
	 */	
	public class Dongtaimohu extends BaseShader{
		
		public static const nameV:Vector.<String>=new <String>["alpha","center","k"];
		//DongtaimohuCode//为了编译进来
		public static const byteV:Vector.<int>=new <int>[0xa5,0x01,0x00,0x00,0x00,0xa4,0x0b,0x00,0x44,0x6f,0x6e,0x67,0x74,0x61,0x69,0x6d,0x6f,0x68,0x75,0xa0,0x0c,0x6e,0x61,0x6d,0x65,0x73,0x70,0x61,0x63,0x65,0x00,0x7a,0x65,0x72,0x6f,0x2e,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x2e,0x63,0x6c,0x61,0x73,0x73,0x69,0x63,0x00,0xa0,0x0c,0x76,0x65,0x6e,0x64,0x6f,0x72,0x00,0x5a,0xa7,0xa7,0xa7,0xc1,0xa1,0xe8,0x00,0xa0,0x08,0x76,0x65,0x72,0x73,0x69,0x6f,0x6e,0x00,0x02,0x00,0xa0,0x0c,0x64,0x65,0x73,0x63,0x72,0x69,0x70,0x74,0x69,0x6f,0x6e,0x00,0xb6,0xaf,0xcc,0xac,0xc4,0xa3,0xba,0xfd,0x00,0xa1,0x01,0x02,0x00,0x00,0x0c,0x5f,0x4f,0x75,0x74,0x43,0x6f,0x6f,0x72,0x64,0x00,0xa1,0x01,0x01,0x00,0x00,0x02,0x61,0x6c,0x70,0x68,0x61,0x00,0xa1,0x01,0x02,0x01,0x00,0x0c,0x63,0x65,0x6e,0x74,0x65,0x72,0x00,0xa1,0x01,0x01,0x00,0x00,0x01,0x6b,0x00,0xa3,0x00,0x04,0x73,0x72,0x63,0x00,0xa1,0x02,0x04,0x02,0x00,0x0f,0x64,0x73,0x74,0x00,0x32,0x01,0x00,0x20,0x00,0x00,0x00,0x00,0x2a,0x01,0x00,0x20,0x00,0x00,0x80,0x00,0x1d,0x01,0x80,0x80,0x00,0x80,0x00,0x00,0x34,0x00,0x00,0x00,0x01,0x80,0x00,0x00,0x1d,0x01,0x00,0x31,0x00,0x00,0x10,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x80,0x00,0x02,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x1d,0x03,0x00,0x40,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0xc0,0x00,0x02,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x1d,0x03,0x00,0x20,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x02,0x00,0xf3,0x05,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x03,0x00,0x40,0x00,0x00,0xc0,0x00,0x03,0x03,0x00,0x20,0x00,0x00,0xc0,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x00,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x40,0x00,0x1d,0x04,0x00,0x80,0x03,0x00,0x00,0x00,0x1d,0x03,0x00,0x80,0x01,0x00,0x40,0x00,0x01,0x03,0x00,0x80,0x03,0x00,0x80,0x00,0x1d,0x04,0x00,0x40,0x03,0x00,0x00,0x00,0x30,0x05,0x00,0xf1,0x04,0x00,0x10,0x00,0x1d,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x01,0x04,0x00,0xf3,0x05,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x32,0x03,0x00,0x80,0x41,0x20,0x00,0x00,0x04,0x04,0x00,0xf3,0x03,0x00,0x00,0x00,0x03,0x04,0x00,0xf3,0x02,0x00,0x1b,0x00,0x1d,0x02,0x00,0xf3,0x04,0x00,0x1b,0x00,0x03,0x02,0x00,0x10,0x00,0x00,0x80,0x00,0x35,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x32,0x02,0x00,0x80,0x00,0x00,0x00,0x00,0x32,0x02,0x00,0x40,0x00,0x00,0x00,0x00,0x32,0x02,0x00,0x20,0x00,0x00,0x00,0x00,0x32,0x02,0x00,0x10,0x00,0x00,0x00,0x00,0x36,0x00,0x00,0x00,0x00,0x00,0x00,0x00];
		
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
		 * 系数 （0~2） 默认 1
		 * 
		 */
		public var k:Number;
		

		/**
		 * 
		 * 透明度 （0~1） 默认 1<br/>
		 * 坐标 默认 null<br/>
		 * 系数 （0~2） 默认 1<br/>
		 * 
		 */
		public function Dongtaimohu(_alpha:Number=1,_center:Float2=null,_k:Number=1){
			alpha=_alpha;
			(data.alpha as ShaderParameter).value=[];
			center=_center;
			(data.center as ShaderParameter).value=[];
			k=_k;
			(data.k as ShaderParameter).value=[];
		}
		
		override public function updateParams():void{
			(data.alpha as ShaderParameter).value[0]=alpha;
			(data.center as ShaderParameter).value[0]=center.x;
			(data.center as ShaderParameter).value[1]=center.y;
			(data.k as ShaderParameter).value[0]=k;
		}
		

	}
}