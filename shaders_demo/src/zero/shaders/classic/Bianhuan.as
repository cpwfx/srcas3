/***
Bianhuan
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月03日 10:24:34
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
	 * 变换
	 * 
	 */	
	public class Bianhuan extends BaseShader{
		
		public static const nameV:Vector.<String>=new <String>["alpha","focalLength","center","center_z","scaleX","scaleY","skewX","skewY","rotationX","rotationY","rotationZ"];
		//BianhuanCode//为了编译进来
		public static const byteV:Vector.<int>=new <int>[0xa5,0x01,0x00,0x00,0x00,0xa4,0x08,0x00,0x42,0x69,0x61,0x6e,0x68,0x75,0x61,0x6e,0xa0,0x0c,0x6e,0x61,0x6d,0x65,0x73,0x70,0x61,0x63,0x65,0x00,0x7a,0x65,0x72,0x6f,0x2e,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x2e,0x63,0x6c,0x61,0x73,0x73,0x69,0x63,0x00,0xa0,0x0c,0x76,0x65,0x6e,0x64,0x6f,0x72,0x00,0x5a,0xa7,0xa7,0xa7,0xc1,0xa1,0xe8,0x00,0xa0,0x08,0x76,0x65,0x72,0x73,0x69,0x6f,0x6e,0x00,0x02,0x00,0xa0,0x0c,0x64,0x65,0x73,0x63,0x72,0x69,0x70,0x74,0x69,0x6f,0x6e,0x00,0xb1,0xe4,0xbb,0xbb,0x00,0xa1,0x01,0x02,0x00,0x00,0x0c,0x5f,0x4f,0x75,0x74,0x43,0x6f,0x6f,0x72,0x64,0x00,0xa1,0x01,0x01,0x00,0x00,0x02,0x61,0x6c,0x70,0x68,0x61,0x00,0xa1,0x01,0x01,0x00,0x00,0x01,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x31,0x00,0xa1,0x01,0x01,0x01,0x00,0x08,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x32,0x00,0xa1,0x01,0x01,0x01,0x00,0x04,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x33,0x00,0xa1,0x01,0x01,0x01,0x00,0x02,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x34,0x00,0xa1,0x01,0x01,0x01,0x00,0x01,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x35,0x00,0xa1,0x01,0x01,0x02,0x00,0x08,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x36,0x00,0xa1,0x01,0x01,0x02,0x00,0x04,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x37,0x00,0xa1,0x01,0x01,0x02,0x00,0x02,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x38,0x00,0xa1,0x01,0x01,0x02,0x00,0x01,0x74,0x72,0x61,0x6e,0x50,0x61,0x72,0x61,0x6d,0x39,0x00,0xa3,0x00,0x04,0x73,0x72,0x63,0x00,0xa1,0x02,0x04,0x03,0x00,0x0f,0x64,0x73,0x74,0x00,0x32,0x04,0x00,0x80,0x00,0x00,0x00,0x00,0x2a,0x04,0x00,0x80,0x00,0x00,0x80,0x00,0x1d,0x01,0x80,0x80,0x00,0x80,0x00,0x00,0x34,0x00,0x00,0x00,0x01,0x80,0x00,0x00,0x1d,0x04,0x00,0xc1,0x00,0x00,0x10,0x00,0x1d,0x04,0x00,0x20,0x01,0x00,0x00,0x00,0x03,0x04,0x00,0x20,0x04,0x00,0x00,0x00,0x1d,0x04,0x00,0x10,0x00,0x00,0xc0,0x00,0x01,0x04,0x00,0x10,0x04,0x00,0x80,0x00,0x1d,0x04,0x00,0x20,0x01,0x00,0x40,0x00,0x03,0x04,0x00,0x20,0x04,0x00,0x40,0x00,0x1d,0x05,0x00,0x80,0x04,0x00,0xc0,0x00,0x01,0x05,0x00,0x80,0x04,0x00,0x80,0x00,0x1d,0x04,0x00,0x20,0x05,0x00,0x00,0x00,0x1d,0x04,0x00,0x10,0x01,0x00,0xc0,0x00,0x03,0x04,0x00,0x10,0x04,0x00,0x00,0x00,0x1d,0x05,0x00,0x20,0x01,0x00,0x80,0x00,0x01,0x05,0x00,0x20,0x04,0x00,0xc0,0x00,0x1d,0x04,0x00,0x10,0x02,0x00,0x00,0x00,0x03,0x04,0x00,0x10,0x04,0x00,0x40,0x00,0x1d,0x05,0x00,0x10,0x05,0x00,0x80,0x00,0x01,0x05,0x00,0x10,0x04,0x00,0xc0,0x00,0x04,0x04,0x00,0x10,0x04,0x00,0x80,0x00,0x03,0x04,0x00,0x10,0x05,0x00,0xc0,0x00,0x1d,0x05,0x00,0x80,0x04,0x00,0xc0,0x00,0x1d,0x04,0x00,0x10,0x02,0x00,0x80,0x00,0x03,0x04,0x00,0x10,0x04,0x00,0x00,0x00,0x1d,0x05,0x00,0x20,0x02,0x00,0x40,0x00,0x01,0x05,0x00,0x20,0x04,0x00,0xc0,0x00,0x1d,0x04,0x00,0x10,0x02,0x00,0xc0,0x00,0x03,0x04,0x00,0x10,0x04,0x00,0x40,0x00,0x1d,0x05,0x00,0x10,0x05,0x00,0x80,0x00,0x01,0x05,0x00,0x10,0x04,0x00,0xc0,0x00,0x32,0x04,0x00,0x10,0x00,0x00,0x00,0x00,0x02,0x04,0x00,0x10,0x04,0x00,0x80,0x00,0x04,0x05,0x00,0x20,0x04,0x00,0xc0,0x00,0x03,0x05,0x00,0x20,0x05,0x00,0xc0,0x00,0x1d,0x05,0x00,0x40,0x05,0x00,0x80,0x00,0x30,0x06,0x00,0xf1,0x05,0x00,0x10,0x00,0x1d,0x03,0x00,0xf3,0x06,0x00,0x1b,0x00,0x03,0x03,0x00,0x10,0x00,0x00,0x80,0x00,0x35,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x32,0x03,0x00,0x80,0x00,0x00,0x00,0x00,0x32,0x03,0x00,0x40,0x00,0x00,0x00,0x00,0x32,0x03,0x00,0x20,0x00,0x00,0x00,0x00,0x32,0x03,0x00,0x10,0x00,0x00,0x00,0x00,0x36,0x00,0x00,0x00,0x00,0x00,0x00,0x00];
		
		/**
		 * 
		 * 透明度 （0~1） 默认 1
		 * 
		 */
		public var alpha:Number;
		
		/**
		 * 
		 * 视点到投影屏幕的距离 （0~2048） 默认 200
		 * 
		 */
		public var focalLength:Number;
		
		/**
		 * 
		 * 坐标 默认 null
		 * 
		 */
		public var center:Float2;
		
		/**
		 * 
		 * 坐标z （-1024~1024） 默认 0
		 * 
		 */
		public var center_z:Number;
		
		/**
		 * 
		 * scaleX （-4~4） 默认 1
		 * 
		 */
		public var scaleX:Number;
		
		/**
		 * 
		 * scaleX （-4~4） 默认 1
		 * 
		 */
		public var scaleY:Number;
		
		/**
		 * 
		 * skewX （-360~360） 默认 0
		 * 
		 */
		public var skewX:Number;
		
		/**
		 * 
		 * skewY （-360~360） 默认 0
		 * 
		 */
		public var skewY:Number;
		
		/**
		 * 
		 * rotationX （-360~360） 默认 0
		 * 
		 */
		public var rotationX:Number;
		
		/**
		 * 
		 * rotationY （-360~360） 默认 0
		 * 
		 */
		public var rotationY:Number;
		
		/**
		 * 
		 * rotationZ （-360~360） 默认 0
		 * 
		 */
		public var rotationZ:Number;
		
		private function updateTransform():void{
			o.x=srcSize.x*0.5;
			o.y=srcSize.y*0.5;
			
			//一左上角为（0,0）的图片 bmp，放到 mc1 里，bmp.x=-o.x，bmp.y=-o.y
			var m:Matrix3D=new Matrix3D(new <Number>[
				1,0,0,0,
				0,1,0,0,
				0,0,1,0,
				-o.x,-o.y,0,1
			]);
			
			//mc1 用于斜切和缩放
			m.append(new Matrix3D(new <Number>[
				scaleX*Math.cos(skewY*(Math.PI/180)),scaleX*Math.sin(skewY*(Math.PI/180)),0,0,
				-scaleY*Math.sin(skewX*(Math.PI/180)),scaleY*Math.cos(skewX*(Math.PI/180)),0,0,
				0,0,1,0,
				0,0,0,1
			]));
			
			//mc1 放 mc2 里，mc2 用于 rotationX
			var _c:Number=Math.cos(rotationX*(Math.PI/180));
			var _s:Number=Math.sin(rotationX*(Math.PI/180));
			m.append(new Matrix3D(new <Number>[
				1,0,0,0,
				0,_c,_s,0,
				0,-_s,_c,0,
				0,0,0,1
			]));
			
			//mc2 放 mc3 里，mc3 用于 rotationY
			_c=Math.cos(rotationY*(Math.PI/180));
			_s=Math.sin(rotationY*(Math.PI/180));
			m.append(new Matrix3D(new <Number>[
				_c,0,-_s,0,
				0,1,0,0,
				_s,0,_c,0,
				0,0,0,1
			]));
			
			//mc3 放 mc4 里，mc4 用于 rotationZ
			_c=Math.cos(rotationZ*(Math.PI/180));
			_s=Math.sin(rotationZ*(Math.PI/180));
			m.append(new Matrix3D(new <Number>[
				_c,_s,0,0,
				-_s,_c,0,0,
				0,0,1,0,
				0,0,0,1
			]));
			
			//mc4 放 mc5 里，mc5 用于位移
			m.append(new Matrix3D(new <Number>[
				1,0,0,0,
				0,1,0,0,
				0,0,1,0,
				center.x-o.x,center.y-o.y,center_z,1
			]));
			
			//=============================================================================================
			var a:Number=m.rawData[0];var b:Number=m.rawData[1];var c:Number=m.rawData[2];
			var d:Number=m.rawData[4];var e:Number=m.rawData[5];var f:Number=m.rawData[6];
			var g:Number=m.rawData[8];var h:Number=m.rawData[9];var i:Number=m.rawData[10];
			var tx:Number=m.rawData[12];var ty:Number=m.rawData[13];var tz:Number=m.rawData[14];
			
			//通过 x1,y1,z1(其实=0)，m 求 x3,y3：
			//p1*m=p2;
			//p2*fL=p3*(fl+z2);
			//var x1:Number=0;
			//var y1:Number=0;
			//var z1:Number=0;
			//var x2:Number=x1*a+y1*d+z1*g+tx;
			//var y2:Number=x1*b+y1*e+z1*h+ty;
			//var z2:Number=x1*c+y1*f+z1*i+tz;
			//var x3:Number=x2*focalLength/(focalLength+z2);
			//var y3:Number=y2*focalLength/(focalLength+z2);
			//x3+=o.x;
			//y3+=o.y;
			
			//通过 x3,y3 求 x1,y1：
			//x2=x1*a+y1*d+tx;
			//y2=x1*b+y1*e+ty;
			//z2=x1*c+y1*f+tz;
			//x3=x2*focalLength/(focalLength+z2)+xo;
			//y3=y2*focalLength/(focalLength+z2)+yo;
			//==>
			//x3=(x1*a+y1*d+tx)*focalLength/(focalLength+(x1*c+y1*f+tz))+xo;
			//y3=(x1*b+y1*e+ty)*focalLength/(focalLength+(x1*c+y1*f+tz))+yo;
			//==>
			//(x3-xo)*(focalLength+(x1*c+y1*f+tz))-(x1*a+y1*d+tx)*focalLength=0
			//(y3-yo)*(focalLength+(x1*c+y1*f+tz))-(x1*b+y1*e+ty)*focalLength=0
			//=>
			//+focalLength*x3+c*x1*x3+f*x3*y1+tz*x3-focalLength*xo-c*x1*xo-f*xo*y1-tz*xo-a*focalLength*x1-d*focalLength*y1-focalLength*tx=0
			//+focalLength*y3+c*x1*y3+f*y1*y3+tz*y3-focalLength*yo-c*x1*yo-f*y1*yo-tz*yo-b*focalLength*x1-e*focalLength*y1-focalLength*ty=0
			//=>
			//(c*x3-c*xo-a*focalLength)*x1 + (f*x3-f*xo-d*focalLength)*y1 + (focalLength*x3+tz*x3-focalLength*xo-tz*xo-focalLength*tx) = 0
			//(c*y3-c*yo-b*focalLength)*x1 + (f*y3-f*yo-e*focalLength)*y1 + (focalLength*y3+tz*y3-focalLength*yo-tz*yo-focalLength*ty) = 0
			//=>
			//(c*x3-c*xo-a*focalLength)*(f*y3-f*yo-e*focalLength)*x1 + (f*x3-f*xo-d*focalLength)*(f*y3-f*yo-e*focalLength)*y1 + (f*y3-f*yo-e*focalLength)*(focalLength*x3+tz*x3-focalLength*xo-tz*xo-focalLength*tx) = 0
			//(c*y3-c*yo-b*focalLength)*(f*x3-f*xo-d*focalLength)*x1 + (f*y3-f*yo-e*focalLength)*(f*x3-f*xo-d*focalLength)*y1 + (f*x3-f*xo-d*focalLength)*(focalLength*y3+tz*y3-focalLength*yo-tz*yo-focalLength*ty) = 0
			//=>
			//x1=((f*x3-f*xo-d*focalLength)*(focalLength*y3+tz*y3-focalLength*yo-tz*yo-focalLength*ty)-(f*y3-f*yo-e*focalLength)*(focalLength*x3+tz*x3-focalLength*xo-tz*xo-focalLength*tx))/((c*x3-c*xo-a*focalLength)*(f*y3-f*yo-e*focalLength)-(c*y3-c*yo-b*focalLength)*(f*x3-f*xo-d*focalLength))
			//y1=((c*x3-c*xo-a*focalLength)*(focalLength*y3+tz*y3-focalLength*yo-tz*yo-focalLength*ty)-(c*y3-c*yo-b*focalLength)*(focalLength*x3+tz*x3-focalLength*xo-tz*xo-focalLength*tx))/((f*x3-f*xo-d*focalLength)*(c*y3-c*yo-b*focalLength)-(c*x3-c*xo-a*focalLength)*(f*y3-f*yo-e*focalLength))
			//==>
			//x1=(-f*focalLength*ty*x3+f*focalLength*ty*xo-d*focalLength*focalLength*y3-d*focalLength*tz*y3+d*focalLength*focalLength*yo+d*focalLength*tz*yo+d*focalLength*focalLength*ty+f*focalLength*tx*y3-f*focalLength*tx*yo+e*focalLength*focalLength*x3+e*focalLength*tz*x3-e*focalLength*focalLength*xo-e*focalLength*tz*xo-e*focalLength*focalLength*tx)/(-c*e*focalLength*x3+c*e*focalLength*xo-a*f*focalLength*y3+a*f*focalLength*yo+a*e*focalLength*focalLength+c*d*focalLength*y3-c*d*focalLength*yo+b*f*focalLength*x3-b*f*focalLength*xo-b*d*focalLength*focalLength)
			//y1=(-c*focalLength*ty*x3+c*focalLength*ty*xo-a*focalLength*focalLength*y3-a*focalLength*tz*y3+a*focalLength*focalLength*yo+a*focalLength*tz*yo+a*focalLength*focalLength*ty+c*focalLength*tx*y3-c*focalLength*tx*yo+b*focalLength*focalLength*x3+b*focalLength*tz*x3-b*focalLength*focalLength*xo-b*focalLength*tz*xo-b*focalLength*focalLength*tx)/(-b*f*focalLength*x3+b*f*focalLength*xo-c*d*focalLength*y3+c*d*focalLength*yo+b*d*focalLength*focalLength+c*e*focalLength*x3-c*e*focalLength*xo+a*f*focalLength*y3-a*f*focalLength*yo-a*e*focalLength*focalLength)
			
			//var fL:Number=focalLength;
			//var x3:Number=123;
			//var y3:Number=456;
			//var xo:Number=o.x;
			//var yo:Number=o.y;
			//var x1:Number,y1:Number;
			//x1=((f*x3-f*xo-d*fL)*(fL*y3+tz*y3-fL*yo-tz*yo-fL*ty)-(f*y3-f*yo-e*fL)*(fL*x3+tz*x3-fL*xo-tz*xo-fL*tx))/((c*x3-c*xo-a*fL)*(f*y3-f*yo-e*fL)-(c*y3-c*yo-b*fL)*(f*x3-f*xo-d*fL))
			//y1=((c*x3-c*xo-a*fL)*(fL*y3+tz*y3-fL*yo-tz*yo-fL*ty)-(c*y3-c*yo-b*fL)*(fL*x3+tz*x3-fL*xo-tz*xo-fL*tx))/((f*x3-f*xo-d*fL)*(c*y3-c*yo-b*fL)-(c*x3-c*xo-a*fL)*(f*y3-f*yo-e*fL))
			//trace(x1,y1);
			//x1=(-f*fL*ty*x3+f*fL*ty*xo-d*fL*fL*y3-d*fL*tz*y3+d*fL*fL*yo+d*fL*tz*yo+d*fL*fL*ty+f*fL*tx*y3-f*fL*tx*yo+e*fL*fL*x3+e*fL*tz*x3-e*fL*fL*xo-e*fL*tz*xo-e*fL*fL*tx)/(-c*e*fL*x3+c*e*fL*xo-a*f*fL*y3+a*f*fL*yo+a*e*fL*fL+c*d*fL*y3-c*d*fL*yo+b*f*fL*x3-b*f*fL*xo-b*d*fL*fL)
			//y1=(-c*fL*ty*x3+c*fL*ty*xo-a*fL*fL*y3-a*fL*tz*y3+a*fL*fL*yo+a*fL*tz*yo+a*fL*fL*ty+c*fL*tx*y3-c*fL*tx*yo+b*fL*fL*x3+b*fL*tz*x3-b*fL*fL*xo-b*fL*tz*xo-b*fL*fL*tx)/(-b*f*fL*x3+b*f*fL*xo-c*d*fL*y3+c*d*fL*yo+b*d*fL*fL+c*e*fL*x3-c*e*fL*xo+a*f*fL*y3-a*f*fL*yo-a*e*fL*fL)
			//trace(x1,y1);
			//var xxx:Number=(c*e*xo+a*f*yo+a*e*fL-c*d*yo-b*f*xo-b*d*fL)+(b*f-c*e)*x3+(c*d-a*f)*y3;
			//x1=((f*ty*xo+d*fL*yo+d*tz*yo+d*fL*ty-f*tx*yo-e*fL*xo-e*tz*xo-e*fL*tx)+(e*fL+e*tz-f*ty)*x3+(f*tx-d*fL-d*tz)*y3)/xxx
			//y1=((c*ty*xo+a*fL*yo+a*tz*yo+a*fL*ty-c*tx*yo-b*fL*xo-b*tz*xo-b*fL*tx)+(b*fL+b*tz-c*ty)*x3+(c*tx-a*fL-a*tz)*y3)/-xxx
			//trace(x1,y1);
			
			ma=a;mb=b;mc=c;
			md=d;me=e;mf=f;
			mg=g;mh=h;mi=i;
			mtx=tx;mty=ty;mtz=tz;
			//trace("----------");
			//trace(ma,mb,mc,0);
			//trace(md,me,mf,0);
			//trace(mg,mh,mi,0);
			//trace(mtx,mty,mtz,1);
			//trace("----------");
			
			tranParam1=c*e*o.x+a*f*o.y+a*e*focalLength-c*d*o.y-b*f*o.x-b*d*focalLength;
			tranParam2=b*f-c*e;
			tranParam3=c*d-a*f;
			tranParam4=f*ty*o.x+d*focalLength*o.y+d*tz*o.y+d*focalLength*ty-f*tx*o.y-e*focalLength*o.x-e*tz*o.x-e*focalLength*tx;
			tranParam5=e*focalLength+e*tz-f*ty;
			tranParam6=f*tx-d*focalLength-d*tz;
			tranParam7=c*ty*o.x+a*focalLength*o.y+a*tz*o.y+a*focalLength*ty-c*tx*o.y-b*focalLength*o.x-b*tz*o.x-b*focalLength*tx;
			tranParam8=b*focalLength+b*tz-c*ty;
			tranParam9=c*tx-a*focalLength-a*tz;
			
			var tranParamKK:Number=tranParam1+tranParam2*center.x+tranParam3*center.y;
			cc.x=(tranParam4+tranParam5*center.x+tranParam6*center.y)/tranParamKK;
			cc.y=(tranParam7+tranParam8*center.x+tranParam9*center.y)/-tranParamKK;
			
			//var tranParamKK:Number=tranParam1+tranParam2*x3+tranParam3*y3;
			//x1=(tranParam4+tranParam5*x3+tranParam6*y3)/tranParamKK
			//y1=(tranParam7+tranParam8*x3+tranParam9*y3)/-tranParamKK
			//trace(x1,y1);
			//trace("===================");
			
			//=============================================================================================
			//m.invert();
			//a=m.rawData[0];b=m.rawData[1];c=m.rawData[2];
			//d=m.rawData[4];e=m.rawData[5];f=m.rawData[6];
			//g=m.rawData[8];h=m.rawData[9];i=m.rawData[10];
			//tx=m.rawData[12];ty=m.rawData[13];tz=m.rawData[14];
			
			//通过 x1,y1,z1(其实=0)，mT 求 x3,y3：
			//p1=p2*mT;
			//p2*fL=p3*(fl+z2);
			//x1=x2*a+y2*d+z2*g+tx;
			//y1=x2*b+y2*e+z2*h+ty;
			//z1=x2*c+y2*f+z2*i+tz;
			//x3=x2*focalLength/(focalLength+z2);
			//y3=y2*focalLength/(focalLength+z2);
			//x3+=o.x;
			//y3+=o.y;
			
			//通过 x3,y3 求 x1,y1：
			//x1=x2*a+y2*d+z2*g+tx;
			//y1=x2*b+y2*e+z2*h+ty;
			//0=x2*c+y2*f+z2*i+tz;
			//x3=x2*focalLength/(focalLength+z2)+xo;
			//y3=y2*focalLength/(focalLength+z2)+yo;
		}
		/**
		 * 
		 * 图片中心
		 * 
		 */
		private var o:Float2=new Float2(0,0);
		/**
		 * 
		 * 变换参数 ma
		 * 
		 */
		private var ma:Number;
		/**
		 * 
		 * 变换参数 mb
		 * 
		 */
		private var mb:Number;
		/**
		 * 
		 * 变换参数 mc
		 * 
		 */
		private var mc:Number;
		/**
		 * 
		 * 变换参数 md
		 * 
		 */
		private var md:Number;
		/**
		 * 
		 * 变换参数 me
		 * 
		 */
		private var me:Number;
		/**
		 * 
		 * 变换参数 mf
		 * 
		 */
		private var mf:Number;
		/**
		 * 
		 * 变换参数 mg
		 * 
		 */
		private var mg:Number;
		/**
		 * 
		 * 变换参数 mh
		 * 
		 */
		private var mh:Number;
		/**
		 * 
		 * 变换参数 mi
		 * 
		 */
		private var mi:Number;
		/**
		 * 
		 * 变换参数 mtx
		 * 
		 */
		private var mtx:Number;
		/**
		 * 
		 * 变换参数 mty
		 * 
		 */
		private var mty:Number;
		/**
		 * 
		 * 变换参数 mtz
		 * 
		 */
		private var mtz:Number;
		/**
		 * 
		 * 变换参数 tranParam1
		 * 
		 */
		private var tranParam1:Number;
		/**
		 * 
		 * 变换参数 tranParam2
		 * 
		 */
		private var tranParam2:Number;
		/**
		 * 
		 * 变换参数 tranParam3
		 * 
		 */
		private var tranParam3:Number;
		/**
		 * 
		 * 变换参数 tranParam4
		 * 
		 */
		private var tranParam4:Number;
		/**
		 * 
		 * 变换参数 tranParam5
		 * 
		 */
		private var tranParam5:Number;
		/**
		 * 
		 * 变换参数 tranParam6
		 * 
		 */
		private var tranParam6:Number;
		/**
		 * 
		 * 变换参数 tranParam7
		 * 
		 */
		private var tranParam7:Number;
		/**
		 * 
		 * 变换参数 tranParam8
		 * 
		 */
		private var tranParam8:Number;
		/**
		 * 
		 * 变换参数 tranParam9
		 * 
		 */
		private var tranParam9:Number;
		/**
		 * 
		 * center 经过变换后对应到的取样点
		 * 
		 */
		private var cc:Float2=new Float2(0,0);

		/**
		 * 
		 * 透明度 （0~1） 默认 1<br/>
		 * 视点到投影屏幕的距离 （0~2048） 默认 200<br/>
		 * 坐标 默认 null<br/>
		 * 坐标z （-1024~1024） 默认 0<br/>
		 * scaleX （-4~4） 默认 1<br/>
		 * scaleX （-4~4） 默认 1<br/>
		 * skewX （-360~360） 默认 0<br/>
		 * skewY （-360~360） 默认 0<br/>
		 * rotationX （-360~360） 默认 0<br/>
		 * rotationY （-360~360） 默认 0<br/>
		 * rotationZ （-360~360） 默认 0<br/>
		 * 
		 */
		public function Bianhuan(_alpha:Number=1,_focalLength:Number=200,_center:Float2=null,_center_z:Number=0,_scaleX:Number=1,_scaleY:Number=1,_skewX:Number=0,_skewY:Number=0,_rotationX:Number=0,_rotationY:Number=0,_rotationZ:Number=0){
			alpha=_alpha;
			(data.alpha as ShaderParameter).value=[];
			focalLength=_focalLength;
			center=_center;
			center_z=_center_z;
			scaleX=_scaleX;
			scaleY=_scaleY;
			skewX=_skewX;
			skewY=_skewY;
			rotationX=_rotationX;
			rotationY=_rotationY;
			rotationZ=_rotationZ;
			(data.tranParam1 as ShaderParameter).value=[];
			(data.tranParam2 as ShaderParameter).value=[];
			(data.tranParam3 as ShaderParameter).value=[];
			(data.tranParam4 as ShaderParameter).value=[];
			(data.tranParam5 as ShaderParameter).value=[];
			(data.tranParam6 as ShaderParameter).value=[];
			(data.tranParam7 as ShaderParameter).value=[];
			(data.tranParam8 as ShaderParameter).value=[];
			(data.tranParam9 as ShaderParameter).value=[];
		}
		
		override public function updateParams():void{
			(data.alpha as ShaderParameter).value[0]=alpha;
			updateTransform();
			(data.tranParam1 as ShaderParameter).value[0]=tranParam1;
			(data.tranParam2 as ShaderParameter).value[0]=tranParam2;
			(data.tranParam3 as ShaderParameter).value[0]=tranParam3;
			(data.tranParam4 as ShaderParameter).value[0]=tranParam4;
			(data.tranParam5 as ShaderParameter).value[0]=tranParam5;
			(data.tranParam6 as ShaderParameter).value[0]=tranParam6;
			(data.tranParam7 as ShaderParameter).value[0]=tranParam7;
			(data.tranParam8 as ShaderParameter).value[0]=tranParam8;
			(data.tranParam9 as ShaderParameter).value[0]=tranParam9;
		}
		

	}
}