package tiled {

	import com.rush.HexLightsOut;
	
	import flash.geom.Point;
	
	import citrus.core.starling.StarlingState;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import vis.GGraph;
	
	/**
	 * @author Aymeric
	 */
	public class MainGameState extends StarlingState {

		
		private var hero:Hero;
		private var heroArt:DisplayObject;
		private var bar:GameBar;
		private static var me:MainGameState;

		public function MainGameState() {
			super();
			me=this;
			
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Hero];
		}
		
		public static function getInstance():MainGameState{
			return me;	
		}

		override public function initialize():void {
			super.initialize();
			y=100;
			bar = new GameBar(stage);
			MyAssets.getMap("mainMap");
			
			hero = getObjectByName("hero") as Hero;

			view.setupCamera();
			
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

		private var graph:GGraph=null;
		private var map:HexLightsOut=null;
		
		public function show_graph():void
		{
			if(graph==null){
				graph = new GGraph();
				Starling.current.nativeStage.addChild(graph);
			}
			else{
				Starling.current.nativeStage.removeChild(graph);				
				graph = null;
			}
		}
		
		public function show_map():void
		{
			if(map==null){
				map = new HexLightsOut(width,height);
				map.y=y;

				Starling.current.nativeStage.addChild(map);
			}
			else{
				Starling.current.nativeStage.removeChild(map);				
				map = null;
			}
			
			
		}
		
		
	}
}
