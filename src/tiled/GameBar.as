package tiled
{
	import starling.display.Button;
	import starling.events.Event;
	import starling.display.Stage;

	public class GameBar
	{
		public function GameBar(stage:Stage)
		{
			var pauseButton:Button = new Button(MyAssets.getAtlas().getTexture("startButton"));
			pauseButton.x = pauseButton.width=100;
			pauseButton.y = 0;
			//pauseButton.addEventListener(Event.TRIGGERED, handleHeroClick);
			stage.addChild(pauseButton);						
			
		}
	}
}