package vis
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	
	public class TextControls extends Sprite
	{
		
		private var _tf:TextField;
		
		public function TextControls()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		public function setSourceName( name:String ):void
		{
			_tf.text = "Source node: " + name + "\nDest node: ";
		}
		
		public function setDestName( name:String ):void
		{
			_tf.appendText( name );
		}
		
		public function setResult( res:String ):void
		{
			_tf.appendText( "\nPath weight: " + res );
		}
		
		public function setExecTime( time:String ):void
		{
			_tf.appendText( "\nExec time: " + time );
		}
		
		private function init( e:Event ):void
		{
			addChild( _tf = new TextField() );
			_tf.selectable = false;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.multiline = true;
			_tf.defaultTextFormat = new TextFormat( "Tahoma", 11 );
			_tf.text = "Source node: ";	
		}

	}
	
}