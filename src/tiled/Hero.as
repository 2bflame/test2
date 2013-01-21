package tiled
{
	import flash.geom.Point;
	
	import citrus.objects.CitrusSprite;
	
	public class Hero extends CitrusSprite
	{
		private var velocity:int=270;
		private var move:MyVector=null;
		public function Hero(name:String, params:Object=null)
		{
			super(name, params);
			_animation="walk";
		}
		
		override public function update(timeDelta:Number):void {
			if(move!=null){
				if(move.move(timeDelta*velocity)){
					x=move.start.x;
					y=move.start.y;
				}
				else{
					x=move.end.x;
					y=move.end.y;
					move=null;
				}
			}
			
		}
		
		public function moveTo(delta:Point):void
		{
			if(move==null){
				move=MyVector.fromStartDelta(x,y,delta.x,delta.y);
			}
		}
		public function moveToPoint(p:Point):void
		{
			if(move==null){
				move=MyVector.fromStartEnd(x,y,p.x,p.y);
			}
		}
	}
}