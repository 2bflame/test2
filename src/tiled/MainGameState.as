package tiled {

	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.utils.objectmakers.ObjectMakerStarling;
	import citrus.view.starlingview.StarlingArt;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.events.TouchPhase;
	
	import tiled.Hero;
	import starling.events.Touch;
	import flash.geom.Point;
	
	/**
	 * @author Aymeric
	 */
	public class MainGameState extends StarlingState {
		/**
		 * Texture Atlas 
		 */
		[Embed(source="/../embed/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="/../embed/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		/**
		 * Returns the Texture atlas instance.
		 * @return the TextureAtlas instance (there is only oneinstance per app)
		 */
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas=new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new MainGameState[name]();
				gameTextures[name]=Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
		
		
		
		/*******/
		
		

		[Embed(source="/../embed/map-atlas.tmx", mimeType="application/octet-stream")]
		private const _Map:Class;

		[Embed(source="/../embed/test2-tiles-atlas.xml", mimeType="application/octet-stream")]
		private const _MapAtlasConfig:Class;

		[Embed(source="/../embed/test2-map.png")]
		private const _MapAtlasPng:Class;
		
		private var hero:Hero;
		private var heroArt:DisplayObject;

		public function MainGameState() {
			super();
			
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Hero];
		}

		override public function initialize():void {

			super.initialize();


			var bitmap:Bitmap = new _MapAtlasPng();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new _MapAtlasConfig());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);

			ObjectMakerStarling.FromTiledMap(XML(new _Map()), sTextureAtlas);

			hero = getObjectByName("hero") as Hero;

			view.setupCamera(stage, new MathVector(stage.stageWidth / 2, stage.stageHeight/2), new Rectangle(0, 0, 1280, 1280), new MathVector(.25, .05));

			(view.getArt(getObjectByName("foreground")) as StarlingArt).alpha = 0;
			
			heroArt = view.getArt(hero) as DisplayObject;
			
			stage.addEventListener(TouchEvent.TOUCH, handleHeroClick);
			// Pause button.
			var pauseButton:Button = new Button(getAtlas().getTexture("startButton"));
			pauseButton.x = pauseButton.width=100;
			pauseButton.y = pauseButton.height * 0.5;
			pauseButton.addEventListener(Event.TRIGGERED, handleHeroClick);
			this.addChild(pauseButton);						
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
