package tiled {

	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * @author Aymeric
	 */
	public class MainGameState extends StarlingState {

		
		private var hero:Hero;
		private var heroArt:DisplayObject;
		private var bar:GameBar;

		public function MainGameState() {
			super();
			
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Hero];
		}

		override public function initialize():void {
			super.initialize();
			y=100;
			bar = new GameBar(stage);
			MyAssets.fromMap("mainMap");
			
			hero = getObjectByName("hero") as Hero;

			view.setupCamera(stage, new MathVector(stage.stageWidth / 2, stage.stageHeight/2), new Rectangle(0, 0, 1280, 1280));
			
			heroArt = view.getArt(hero) as DisplayObject;
			
			addEventListener(TouchEvent.TOUCH, handleHeroClick);
			// Pause button.
		}
		
		private function handleHeroClick(event:TouchEvent):void
		{
			var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.ENDED);
			if (touches.length == 1)
			{
				// one finger touching / one mouse curser moved
				var delta:Point = touches[0].getLocation(heroArt);
				hero.moveTo(delta);

			}
		}
		
	}
}
