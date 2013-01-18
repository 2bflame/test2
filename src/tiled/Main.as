package tiled {

	import citrus.core.starling.StarlingCitrusEngine;
	
	import vis.GGraph;

	[SWF(width="1280",height="740",backgroundColor="#000000", frameRate="60")]

	/**
	* @author Aymeric
	*/
	public class Main extends StarlingCitrusEngine {

		public function Main() {
			
			setUpStarling(true);

			state = new MainGameState();
			
			//var graph:GGraph = new GGraph();
			//addChild( graph );			
		}
	}
}