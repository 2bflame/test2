package com.rush
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import starling.core.Starling;
	
	import structs.graphs.MyGraph;
	import structs.graphs.MyVertex;
	import structs.graphs.MyVertexData;
	
	/**
	 * Example applet which uses hexagonal grid. It's a hexagonal version of the
	 * "lights out" puzzle game: http://en.wikipedia.org/wiki/Lights_Out_(game)
	 *
	 * @author Ruslan Shestopalyuk
	 *
	 * Converted to AS3
	 */
	
	public class HexMap
	{	
		static public const ORANGE:int = 0xFF5721;
		static public const GRAY:int = 0xCCCCCC;
		
		public var BOARD_WIDTH:int;
		public var BOARD_HEIGHT:int;

		static private const NUM_HEX_CORNERS:int = 6;
		private var CELL_RADIUS:int = 40;


		private var mCornersX:Array = [NUM_HEX_CORNERS];
		private var mCornersY:Array = [NUM_HEX_CORNERS];
		
		private var width:int;
		private var height:int;

		private var mCellMetrics:HexGridCell  = new HexGridCell(CELL_RADIUS);
		private var display_object: MovieClip;
		
		public function HexMap(width:int,height:int)
		{
			this.width=width;
			this.height=height;
			mCellMetrics = new HexGridCell(CELL_RADIUS);
			BOARD_WIDTH=width/mCellMetrics.SIDE;
			BOARD_HEIGHT=height/mCellMetrics.HEIGHT;			
		}
		
		
		public function createGraph(graph:MyGraph):void
		{
			for ( var i:int = 0; i < BOARD_WIDTH; i++ )
			{
				for ( var j:int = 0; j < BOARD_HEIGHT; j++ )
				{
					mCellMetrics.setCellIndex(i, j);
					var vertex:MyVertex=new MyVertex(
							new MyVertexData(
								i,j,
								mCellMetrics.getCenterX(),
								mCellMetrics.getCenterY()
							)
						);
					vertex.id=i*BOARD_HEIGHT + j;
					graph.addVertex(vertex);
				}
			}
			
			for ( var i1:int = 0; i1 < BOARD_WIDTH; i1++ )
			{
				for ( var j1:int = 0; j1 < BOARD_HEIGHT; j1++ )
				{
					mCellMetrics.setCellIndex(i1, j1);
					for(var nid:int=0;nid<6;nid++){
						var ni:int = mCellMetrics.getNeighborI(nid);
						var nj:int = mCellMetrics.getNeighborJ(nid);
						if(ni<0 || ni>=BOARD_WIDTH || nj<0 || nj>= BOARD_HEIGHT)
							continue;
						graph.getIJ(i1,j1).addEdge(graph.getIJ(ni,nj),1);
					}
				}
			}
		}
		

		public function paint():void
		{
			var graphics:Graphics=display_object.graphics;
			graphics.clear();
			graphics.lineStyle( 2, ORANGE, 0.9 );
			graphics.drawRect(0,0, width, height);

			
			for ( var j:int = 0; j < BOARD_HEIGHT; j++ )
			{
				for ( var i:int = 0; i < BOARD_WIDTH; i++ )
				{
					
					mCellMetrics.setCellIndex(i, j);
					mCellMetrics.computeCorners(mCornersX, mCornersY);
					
					//this.graphics.beginFill( ( mCells[j][i] == L_ON ) ? ORANGE : GRAY, 1 );
					
					for ( var k:int = 0; k < mCornersX.length-1; k++ )
					{
						if( k == 0 ) graphics.moveTo( mCornersX[k], mCornersY[k] );
						
						graphics.lineTo( mCornersX[k + 1], mCornersY[k + 1] );
					}
					
					graphics.lineTo( mCornersX[0], mCornersY[0] );
					
						//this.graphics.endFill();

				}
			}
		}

		/**
		 * Returns true if cell is inside the game board.
		 *
		 * @param i cell's horizontal index
		 * @param j cell's vertical index
		 */
		private function isInsideBoard( i:int, j:int ):Boolean
		{
			return i >= 0 && i < BOARD_WIDTH && j >= 0 && j < BOARD_HEIGHT;
		}


		
		private function mouse_released( e:MouseEvent ):void
		{
			mCellMetrics.setCellByPoint( display_object.mouseX, display_object.mouseY );
			
			var clickI:int = mCellMetrics.getIndexI();
			var clickJ:int = mCellMetrics.getIndexJ();

			
			paint();

		}
		
		public function isVisible():Boolean
		{
			return display_object!=null;
		}		
		
		public function show(x:int, y:Number):void
		{
			display_object=new MovieClip();
			display_object.x=x;
			display_object.y=y;
			Starling.current.nativeStage.addChild(display_object);
			display_object.stage.addEventListener( MouseEvent.MOUSE_UP, mouse_released );
			paint();
		
		}
		
		public function hide():void
		{
			display_object.stage.removeEventListener( MouseEvent.MOUSE_UP, mouse_released );
			display_object.stage.removeChild(display_object);
			display_object=null;
		}
		
		
	}
}

