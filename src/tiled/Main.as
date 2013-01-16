package tiled {

	import citrus.core.starling.StarlingCitrusEngine;

	[SWF(width="900",height="700",backgroundColor="#000000", frameRate="60")]

	/**
	* @author Aymeric
	*/
	public class Main extends StarlingCitrusEngine {

		public function Main() {
			
			setUpStarling(true);

			state = new MainGameState();
		}
	}
}