package tiled
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import citrus.utils.objectmakers.ObjectMakerStarling;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class MyAssets
	{
		/**
		 * Texture Atlas 
		 */
		[Embed(source="/../embed/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="/../embed/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasTextureGameXml:Class;		
		
		[Embed(source="/../embed/test2-map.png")]
		private static const mainMapAtlas:Class;
		
		[Embed(source="/../embed/test2-tiles-atlas.xml", mimeType="application/octet-stream")]
		private static const mainMapAtlasXml:Class;
		
		[Embed(source="/../embed/map-atlas.tmx", mimeType="application/octet-stream")]
		private static const mainMapTmx:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameAtlases:Dictionary = new Dictionary();
		private static var mapObjects:Dictionary = new Dictionary();
		
		
		public static function getAtlas():TextureAtlas
		{			
			return atlas("AtlasTextureGame");
		}
		
		public static function atlas(name:String):TextureAtlas
		{
			if (gameAtlases[name] == null)
			{
				var texture:Texture = getTexture(name);
				var xml:XML = XML(new MyAssets[name+"Xml"]());
				gameAtlases[name]=new TextureAtlas(texture, xml);
			}
			
			return gameAtlases[name];
		}
		
		public static function fromMap(name:String):Array
		{
			mapObjects[name]=ObjectMakerStarling.FromTiledMap(XML(new MyAssets[name+"Tmx"]), MyAssets.atlas(name + "Atlas"));
			return mapObjects[name];
		}
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new MyAssets[name]();
				gameTextures[name]=Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
		
	}
}