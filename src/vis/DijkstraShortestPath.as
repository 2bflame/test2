package vis
{
	
	import flash.display.*;

	[SWF(backgroundColor="#FCFCFC", width=550, height=400)]
	public class DijkstraShortestPath extends Sprite
	{
		
		public function DijkstraShortestPath()
		{
			init();
		}
		
		private function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			var graph:GGraph = new GGraph();
			addChild( graph );
		}
		
	}
	
}