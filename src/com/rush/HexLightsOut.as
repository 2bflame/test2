package com.rush
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import citrus.core.CitrusEngine;
	import citrus.view.CitrusView;
	
	import tiled.Main;
	
	/**
	 * Example applet which uses hexagonal grid. It's a hexagonal version of the
	 * "lights out" puzzle game: http://en.wikipedia.org/wiki/Lights_Out_(game)
	 *
	 * @author Ruslan Shestopalyuk
	 *
	 * Converted to AS3
	 */
	
	public class HexLightsOut extends MovieClip
	{
		private var game:MovieClip;
		
		static public const ORANGE:int = 0xFF5721;
		static public const GRAY:int = 0xCCCCCC;
		
		static private var serialVersionUID:Number;
		
		private var BOARD_WIDTH:int;
		private var BOARD_HEIGHT:int;

		static private const NUM_HEX_CORNERS:int = 6;
		private var CELL_RADIUS:int = 40;


		private var mCornersX:Array = [NUM_HEX_CORNERS];
		private var mCornersY:Array = [NUM_HEX_CORNERS];
		
		private var map_width:int;
		private var map_height:int;

		private var mCellMetrics:HexGridCell  = new HexGridCell(CELL_RADIUS);
		
		public function HexLightsOut(width:int,height:int)
		{
			map_width=width;
			map_height=height;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			stage.addEventListener( MouseEvent.MOUSE_UP, mouse_released );
			mCellMetrics = new HexGridCell(CELL_RADIUS);
			BOARD_WIDTH=map_width/mCellMetrics.SIDE;
			BOARD_HEIGHT=map_height/mCellMetrics.HEIGHT;
			paint();

		}

		public function paint():void
		{
			this.graphics.clear();
			this.graphics.lineStyle( 2, ORANGE, 0.9 );
			graphics.drawRect(0,0, 1280, 640);

			
			for ( var j:int = 0; j < BOARD_HEIGHT; j++ )
			{
				for ( var i:int = 0; i < BOARD_WIDTH; i++ )
				{
					
					mCellMetrics.setCellIndex(i, j);
					
					
						mCellMetrics.computeCorners(mCornersX, mCornersY);
						
						//this.graphics.beginFill( ( mCells[j][i] == L_ON ) ? ORANGE : GRAY, 1 );
						
						
						for ( var k:int = 0; k < mCornersX.length-1; k++ )
						{
							if( k == 0 ) this.graphics.moveTo( mCornersX[k], mCornersY[k] );
							
							this.graphics.lineTo( mCornersX[k + 1], mCornersY[k + 1] );
						}
						
						this.graphics.lineTo( mCornersX[0], mCornersY[0] );
						
						//this.graphics.endFill();

				}
			}
		}
		
		public function update():void
		{
			paint();
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
			mCellMetrics.setCellByPoint( mouseX, mouseY );
			
			var clickI:int = mCellMetrics.getIndexI();
			var clickJ:int = mCellMetrics.getIndexJ();

			
			paint();

		}
	}
}

