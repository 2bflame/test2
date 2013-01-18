package vis
{
	
	import __AS3__.vec.Vector;
	
	import structs.graphs.Dijkstra;
	import structs.graphs.Graph;
	import structs.graphs.Vertex;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	public class GGraph extends Sprite
	{

		private var _graph:Graph;
		private var _vertices:Vector.<GVertex>;
		private var _edges:GEdge;
		private var _items:uint;
		private var _src:Vertex;
		private var _dst:Vertex;
		private var _text:TextControls;
		private var _time:Number;
		
		public function GGraph()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ):void
		{
			_graph = new Graph();
			_edges = new GEdge();
			_vertices = new Vector.<GVertex>();
			
			addChild( _edges );
			_items = 0;
			
			var nodes:Array = [ [50, 200], [200, 125], [125, 100], [100, 300], 
								[200, 350], [225, 225], [400, 325], [340, 235], 
					   			[445, 125], [330, 70], [315, 345], [475, 350] ];
					   			
			var edges:Array = [ [0, 1], [0, 2], [1, 2], [0, 3], [3, 5], [3, 4], 
								[4, 7], [4, 5], [10, 6], [6, 11], [5, 9], [7, 6], 
					   			[7, 8], [8, 6], [5, 7], [1, 5], [5, 8], [8, 9], [1, 9] ];
			
			var vertex:GVertex;
			var edge:GEdge;
			for ( var i:int = 0; i < nodes.length; ++i )
			{
				addChild( vertex = new GVertex( "v" + i ) );
				vertex.x = nodes[ i ][ 0 ];
				vertex.y = nodes[ i ][ 1 ];
				_vertices.push( vertex );
				_graph.addVertex( new Vertex( "v" + i ) );
			}
			for ( i = 0; i < edges.length; ++i )
			{
				var w:int = 1 + Math.random() * 20; 
				_edges.connect( _vertices[ edges[ i ][ 0 ] ], _vertices[ edges[ i ][ 1 ] ], w );
				_graph.addEdge( _graph.vertices.getNode( edges[ i ][ 0 ] ).data, 
								_graph.vertices.getNode( edges[ i ][ 1 ] ).data, w );
			}
			
			addChild( _text = new TextControls() );
			_text.x = _text.y = 10;
			
			removeEventListener( Event.ADDED_TO_STAGE, init );
			addEventListener( MouseEvent.CLICK, selectVertex );
			buttonMode = true;
			useHandCursor = true;
		}
		
		private function reset():void
		{
			for ( var i:int = 0; i < _vertices.length; ++i )
			{
				_vertices[ i ].selected = false;
				_vertices[ i ].marked = false;
				_vertices[ i ].render();
			}
			_items = 0;	
		}
		
		private function selectVertex( e:MouseEvent ):void
		{
			if ( e.target is GVertex )
			{
				if ( _items == 0 )
				{
					_edges.reset();
					reset();
				}
				var id:int;
				var target:GVertex = e.target as GVertex;
				target.marked = true;
				target.render();
				if ( _items < 2 )
				{
					if ( _items == 0 )
					{
						_src = _graph.vertices.getNode( getChildIndex( target ) - 1 ).data;
						_text.setSourceName( _src.name );
					}
					else if ( _items == 1 )
					{
						_dst = _graph.vertices.getNode( getChildIndex( target ) - 1 ).data;
						_text.setDestName( _dst.name );
					}
					_items++;
				}
				if ( _items == 2 )
				{
					reset();
					getPath();
				}
			}
		}
		
		private function getPath():void
		{
			_time = getTimer();
			var d:Dijkstra = new Dijkstra( _graph, _src, _dst );
			var res:Vertex = d.search();
			var w:int = res.weight;
			while ( res )
			{
				if ( res.parent )
				{
					var rid:int = int( res.name.split( "v" )[ 1 ] );
					var pid:int = int( res.parent.name.split( "v" )[ 1 ] );
					_vertices[ rid ].selected = true;
					_vertices[ rid ].render();
					_vertices[ pid ].selected = true;
					_vertices[ pid ].render();
					_edges.connect( _vertices[ rid ], _vertices[ pid ], 0, true );
				}
				res = res.parent;
			}
			_text.setResult( String( w ) );
			_text.setExecTime( String( getTimer() - _time ) );
		}

	}
	
}