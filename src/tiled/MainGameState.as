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

		public function MainGameState() {
			super();
			
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Hero];
		}

		override public function initialize():void {

			super.initialize();
			y=100; 
			MyAssets.fromMap("mainMap");
//			for each(var obj:* in MyAssets.fromMap("mainMap")){
//				if(obj is CitrusSprite){
//					(obj as CitrusSprite).x+=20;					
//				}
//			}
			
			hero = getObjectByName("hero") as Hero;

			view.setupCamera(stage, new MathVector(stage.stageWidth / 2, stage.stageHeight/2), new Rectangle(0, 0, 1280, 1280));
			
			heroArt = view.getArt(hero) as DisplayObject;
			
			addEventListener(TouchEvent.TOUCH, handleHeroClick);
			// Pause button.
			var pauseButton:Button = new Button(MyAssets.getAtlas().getTexture("startButton"));
			pauseButton.x = pauseButton.width=100;
			pauseButton.y = 0;
			pauseButton.addEventListener(Event.TRIGGERED, handleHeroClick);
			stage.addChild(pauseButton);						
		}
		
		private function handleHeroClick(event:TouchEvent):void
		{
			var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.ENDED);
			if (touches.length == 1)
			{
				// one finger touching / one mouse curser moved
				var delta:Point = touches[0].getLocation(heroArt);
				hero.x += delta.x;
				hero.y += delta.y;

			}
		}
		
	}
}
