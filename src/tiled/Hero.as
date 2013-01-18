package tiled
{
	import flash.geom.Point;
	
	import citrus.objects.CitrusSprite;
	
	public class Hero extends CitrusSprite
	{
		public function Hero(name:String, params:Object=null)
		{
			super(name, params);
			_animation="walk";
		}
		
		override public function update(timeDelta:Number):void {
			
			_updateAnimation();
		}
		
		private function _updateAnimation():void {
			//var v:StarlingArt=view.getArt() as StarlingArt;
		}
		
		
		
		
		public function moveTo(delta:Point):void
		{
			x += delta.x;
			y += delta.y;
		}
	}
}