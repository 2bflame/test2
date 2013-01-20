package tiled
{
	import com.rush.HexLightsOut;
	
	import feathers.controls.Button;
	import feathers.themes.AeonDesktopTheme;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	
	import vis.GGraph;

	public class GameBar extends Sprite
	{
		private var map_button:Button;
		private var graph_button:Button;
		
		private var stage:Stage;
		private var graph:GGraph=null;
		private var map:HexLightsOut=null;
		
		public function GameBar(stage:Stage)
		{
			stage.addChild(this);
			this.stage=stage;
			
			new AeonDesktopTheme(stage);
			
			var y:int=10;
			var x:int=100;
			var width:int=100;
			var deltax:int=20;
			
			map_button = new Button();
			map_button.label = "map";
			map_button.x = x;
			map_button.y = y;
			map_button.width = width;
			map_button.addEventListener(Event.TRIGGERED, mapHandler);
			addChild(map_button);
			x+=width+deltax;
			
			graph_button = new Button();
			graph_button.label = "grap";
			graph_button.x = x;
			graph_button.y = y;
			graph_button.width= width;
			graph_button.addEventListener(Event.TRIGGERED, graphHandler);
			addChild(graph_button);
		}
		
		protected function graphHandler(event:Event):void
		{
			MainGameState.getInstance().show_graph();
		}
		
		protected function mapHandler(event:Event):void
		{
			MainGameState.getInstance().show_map();		
		
		}
	}
}