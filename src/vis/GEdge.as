package vis
{
	
	import __AS3__.vec.Vector;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;

	public class GEdge extends Sprite
	{
		
		private var _selected:Boolean;
		private var _connections:Vector.<Array>;
		private var _index:uint;
		private var _wf:TextField;
		
		public function GEdge()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		public function connect( u:GVertex, v:GVertex, weight:int, selected:Boolean = false ):void
		{
			_selected = selected;
			_connections[ _index ] = [];
			_connections[ _index ][ 0 ] = u;
			_connections[ _index ][ 1 ] = v;
			_index++;
			drawConnection( u, v );
			if ( weight )
				setWeightField( weight, u, v );
		}
		
		public function reset():void
		{
			graphics.clear();
			_selected = false;
			for ( var i:int = 0; i < _index; ++i )
			{
				drawConnection( _connections[ i ][ 0 ],
						 		_connections[ i ][ 1 ] );	
			}
		}
		
		private function init( e:Event ):void
		{
			_connections = new Vector.<Array>();
			_index = 0;
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function drawConnection( u:GVertex, v:GVertex ):void
		{
			if ( _selected )
				graphics.lineStyle( 2, 0xA07F95 );
			else
				graphics.lineStyle( 2, 0xD5DFEF );
			graphics.moveTo( u.x, u.y );
			graphics.lineTo( v.x, v.y );			
		}
		
		private function setWeightField( w:int, u:GVertex, v:GVertex ):void
		{
			var dx:int = ( u.x + v.x ) * .5;
			var dy:int = ( u.y + v.y ) * .5;
			
			_wf = new TextField();
			_wf.autoSize = TextFieldAutoSize.LEFT;
			_wf.selectable = false;
			_wf.defaultTextFormat = new TextFormat( "Arial", 10, 0xFF6666 );
			_wf.x = dx - 4;
			_wf.y = ( u.y > v.y ) ? dy : dy + 4;;
			_wf.text = String( w );
			addChild( _wf );
		}
		
	}
	
}