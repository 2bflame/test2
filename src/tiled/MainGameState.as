package tiled {

	import com.rush.HexMap;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.core.PopUpManager;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import vis.GGraph;
	
	/**
	 * @author Aymeric
	 */
	public class MainGameState extends StarlingState {
		private static var me:MainGameState;
		static public const ORANGE:int = 0xFF5721;
		
		private var hero:Hero;
		private var heroArt:DisplayObject;
		private var bar:GameBar;
		private var objects_container: MovieClip;

		public function MainGameState() {
			super();
			me=this;
			
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Hero,Static];
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
			map = new HexMap(width,height);
		}
		
		private function handleHeroClick(event:TouchEvent):void
		{
			var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.ENDED);
			if (touches.length == 1)
			{
				// one finger touching / one mouse curser moved
				var point:Point = touches[0].getLocation(this);
				var static:int=0;
				for each(var obj:Static in getObjectsByType(Static)){
					if(obj.within(point)){
						static=1;
						const label:Label = new Label();
						label.text = "Hello";
						showObjCallout(label,obj);
						break;
					}
				}
				if(!static){
					hero.moveToPoint(point);					
				}

			}
		}

		private var graph:GGraph=null;
		private var map:HexMap=null;
		
		public function showObjCallout(label:DisplayObject,obj:Static):void
		{
				var callout:Callout =Callout.defaultCalloutFactory();
				callout.content=label;
				callout.x=obj.x-obj.width/2;
				callout.y=obj.y+obj.height/2+5;
				function enterFrameHandler(event:EnterFrameEvent):void
				{
					callout.x=obj.x-callout.width/2;							
				}
				function callout_closeHandler(event:Event):void
				{
					callout.removeEventListener(EnterFrameEvent.ENTER_FRAME, enterFrameHandler);
					callout.removeEventListener(Event.CLOSE, callout_closeHandler);
				}
				callout.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrameHandler);
				callout.addEventListener(Event.CLOSE, callout_closeHandler);
				PopUpManager.popUp(callout,true,false);
				addChild(callout);
		}
		
		public function addNative(obj:flash.display.DisplayObject):void
		{
			Starling.current.nativeStage.addChild(obj);
		}
		
		public function removeNative(obj:flash.display.DisplayObject):void
		{
			Starling.current.nativeStage.removeChild(obj);				
		}
		
		public function show_graph():void
		{
			if(graph==null){
				graph = new GGraph(map);
				graph.y=y;
				Starling.current.nativeStage.addChild(graph);
			}
			else{
				Starling.current.nativeStage.removeChild(graph);				
				graph = null;
			}
		}
		
		public function show_map():void
		{
			if(map.isVisible()){
				map.hide();
			}
			else{
				map.show(0,y);
			}
		}		
		
		public function show_objects():void
		{
			if(objects_container==null){
				objects_container=new MovieClip();
				addNative(objects_container);
				objects_container.y=y;
				objects_container.graphics.lineStyle( 2, ORANGE, 0.9 );
				for each(var obj:* in getObjectsByType(CitrusObject)){
					try{
						objects_container.graphics.drawRect(obj.x-obj.width/2,obj.y-obj.height/2,obj.width,obj.height);						
					}catch(e:*){						
					}
				}
				
				
			}
			else{
				removeNative(objects_container);
				objects_container=null;
			}
		}
	}
}
