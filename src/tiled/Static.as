package tiled
{
	import citrus.core.CitrusObject;
	import flash.geom.Point;

	public class Static extends CitrusObject
	{
		public var _x:int;
		public var y:int;
		public var width:int;
		public var height:int;
		
		public function Static(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		public function within(point:Point):int
		{
			if(point.x>_x-width/2 && point.x<_x+width/2 && point.y>y-height/2 && point.y<y+height/2) return 1;
			return 0;
		}
		
		public function get x():int
		{
			return _x;
		}
		
		public function set x(v:int):void
		{
			_x=v;
		}

	}
}