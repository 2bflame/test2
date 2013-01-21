package tiled
{
	import flash.geom.Point;

	public class MyVector
	{
		public var start:Point;
		public var end:Point;
		private var length:int;
		
		public function MyVector(start:Point,end:Point)			
		{
			this.start=start;
			this.end=end;
			init();
		}
		
		public static function fromStartDelta(x:int,y:int,deltax:int,deltay:int):MyVector{
			return new MyVector(new Point(x,y),new Point(x+deltax,y+deltay));
		}
		
		public static function fromStartEnd(x:int,y:int,x1:int,y1:int):MyVector{
			return new MyVector(new Point(x,y),new Point(x1,y1));
		}
		
		public function move(delta:int):int{
			if(delta>length) return 0;
			var ratio:Number=delta/length;
			start.x+=(end.x-start.x)*ratio;
			start.y+=(end.y-start.y)*ratio;
			length-=delta;
			return 1;
		}
		
		private function init():void{
			length=Math.sqrt(((end.x-start.x)*(end.x-start.x)+(end.y-start.y)*(end.y-start.y)));
		}
	}
}