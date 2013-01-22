package tiled
{
	import feathers.controls.Button;
	import feathers.themes.AeonDesktopTheme;
	
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;

	public class GameBar extends Sprite
	{
		private var map_button:Button;
		private var graph_button:Button;
		
		private var stage:Stage;
		
		public function GameBar(stage:Stage)
		{
			stage.addChild(this);
			this.stage=stage;
			
			new AeonDesktopTheme(stage);
			
			var y:int=10;
			var x:int=100;
			var width:int=80;
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
			graph_button.label = "graph";
			graph_button.x = x;
			graph_button.y = y;
			graph_button.width= width;
			graph_button.addEventListener(Event.TRIGGERED, graphHandler);
			addChild(graph_button);
			x+=width+deltax;
			
			graph_button = new Button();
			graph_button.label = "objects";
			graph_button.x = x;
			graph_button.y = y;
			graph_button.width= width;
			graph_button.addEventListener(Event.TRIGGERED, drawObjectsHandler);
			addChild(graph_button);
		}
		
		protected function drawObjectsHandler(event:Event):void
		{
			MainGameState.getInstance().show_objects();
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