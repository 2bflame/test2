package vis
{
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.text.*;
	
	public class GVertex extends Sprite
	{
		
		private const RADIUS:int = 15;
		
		public var marked:Boolean;
		
		private var _name:String;
		private var _nField:TextField;
		private var _selected:Boolean;
		private var _hover:Boolean;
		
		public function GVertex( name:String )
		{
			_name = name;
			_selected = _hover = false;
			marked = false;
			addEventListener( MouseEvent.MOUSE_OVER, switchState );
			addEventListener( MouseEvent.MOUSE_OUT, switchState );
			initNameField();
			render();
		}
		
		public function set selected( selected:Boolean ):void
		{
			_selected = selected;
		}
			
		public function render():void
		{
			graphics.clear();
			if ( _selected )
			{
				graphics.beginFill( 0xF5F5F5 );
				graphics.lineStyle( 3, 0xA07F95 );
				_nField.textColor = 0x0;
			}
			else if ( _hover )
			{
				_nField.textColor = 0x999999;
				graphics.beginFill( 0xFFFFFF );
				graphics.lineStyle( 3, 0xB2BFCF );
			}
			else if ( marked )
			{
				_nField.textColor = 0x0;
				graphics.beginFill( 0xFFFFFF );
				graphics.lineStyle( 3, 0xB2BFCF );				
			}
			else
			{
				_nField.textColor = 0xCCCCCC;
				graphics.beginFill( 0xFFFFFF );
				graphics.lineStyle( 2, 0xB2BFCF );
			}
			graphics.drawCircle( 0, 0, RADIUS );
			graphics.endFill();
		}
		
		private function initNameField():void
		{
			_nField = new TextField();
			_nField.defaultTextFormat = new TextFormat( "Arial", 11, 0x0, true );
			_nField.text = _name;
			_nField.autoSize = TextFieldAutoSize.LEFT;
			_nField.selectable = false;
			_nField.mouseEnabled = false;
			addChild( _nField );
			_nField.x -= _nField.width * .5;
			_nField.y -= _nField.height * .5;
		}
		
		private function switchState( e:MouseEvent ):void
		{
			if ( e.type == MouseEvent.MOUSE_OVER )
				_hover = true;
			else if ( e.type == MouseEvent.MOUSE_OUT )
				_hover = false;
			render();
		}
		
	}
	
}