package tiled
{
	import feathers.controls.Button;
	import feathers.themes.AeonDesktopTheme;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	
	import vis.GGraph;
	import com.rush.HexLightsOut;

	public class GameBar extends Sprite
	{
		private var pauseButton:Button;
		private var stage:Stage;
		private var graph:GGraph=null;
		private var map:HexLightsOut=null;
		
		public function GameBar(stage:Stage)
		{
			stage.addChild(this);
			this.stage=stage;
			
			new AeonDesktopTheme(stage);
			
			pauseButton = new Button();
			pauseButton.label = "Click Me";
			pauseButton.x = 100;
			pauseButton.y = 10;
			pauseButton.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			addChild(pauseButton);
		}
		
		protected function button_triggeredHandler(event:Event):void
		{
//			if(graph==null){
//				graph = new GGraph();
//				Starling.current.nativeStage.addChild(graph);
//			}
//			else{
//				Starling.current.nativeStage.removeChild(graph);				
//				graph = null;
//			}
			if(map==null){
				map = new HexLightsOut();
				Starling.current.nativeStage.addChild(map);
			}
			else{
				Starling.current.nativeStage.removeChild(map);				
				map = null;
			}
			
		
		}
	}
}