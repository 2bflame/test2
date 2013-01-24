package feathers.controls {
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.core.FeathersControl;
	import feathers.display.Scale9Image;
	import flash.geom.Rectangle;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author
	 */
	public class MainDialog extends FeathersControl {
		
		public function MainDialog() {
			super();
		}
		
		// PUBLIC STATIC PROPERTIES --------------------------------------------------------------------
		
		public static var defaultCenterTitle:Boolean = false;
		public static var defaultModalAlpha:Number = 0.5;
		
		// PUBLIC STATIC METHODS -----------------------------------------------------------------------
		
		/**
		 * Create and display a subclass of MainDialog.
		 * @param	ctlScreen		Screen to display the dialog on.
		 * @param	cDlg				Subclass of MainDialog to create and display.
		 * @param	nTop				Distance from top of screen to top of dialog (in pixels). Use negative
		 * values to set distance of dialog bottom from bottom of screen. In this case, the distance
		 * from the top will be determined by the height of the dialog. Defaults to 20 pixels from top
		 * of screen.
		 * @param	nWidth			Width of the dialog in pixels. Use negative values to set the width as a
		 * percentage of the screen width (ie. -80 = 80%). Defaults to 90% of screen width.
		 * @param	nAlpha			Alpha value for the modal mask. Defaults to 0.5.
		 * @return	Returns the instance of the class passed in the second parameter.
		 * @example
		 * <listing version="3.0">
		 * MainDialog.defaultModalAlpha = 0;						// modal mask is invisible
		 * MainDialog.show(this, NewAccountDlg, 80);		// NewAccountDlg is a subclass of MainDialog
		 * 																							// with a width which is 80% of the screen.
		 * 																							// Height of dialog determined by its content.
		 * </listing>
		 */
		public static function show(ctlScreen:Screen, cDlg:Class,
									nTop:Number=20, nWidth:Number=-90, nAlpha:Number=-1):MainDialog {
			var dlgRet:MainDialog;
			
			dlgRet = new cDlg();
			dlgRet._dialogTop = nTop;
			dlgRet._dialogWidth = nWidth;
			dlgRet._modalAlpha = (nAlpha >= 0) ? nAlpha : defaultModalAlpha;
			dlgRet._centerTitle = defaultCenterTitle;
			dlgRet.width = ctlScreen.width;
			dlgRet.height = ctlScreen.height;
			ctlScreen.addChild(dlgRet);
			
			return dlgRet;
		}
		
		// PUBLIC PROPERTIES ---------------------------------------------------------------------------
		
		// centerTitle Property	[r/w]
		public function get centerTitle():Boolean {
			return _centerTitle;
		}
		public function set centerTitle(bVal:Boolean):void {
			if (_centerTitle != bVal) {
				_centerTitle = bVal;
				invalidate(INVALIDATION_FLAG_STYLES);
			}
		}
		
		// headerPadding Property	[r/w]
		public function get headerPadding():Number {
			return _headerPadding;
		}
		public function set headerPadding(nVal:Number):void {
			if (_headerPadding != nVal) {
				_headerPadding = nVal;
				invalidate(INVALIDATION_FLAG_STYLES);
			}
		}
		
		// paddingBottom Property	[r/w]
		public function get paddingBottom():Number {
			return _paddingBottom;
		}
		public function set paddingBottom(nVal:Number):void {
			if (_paddingBottom != nVal) {
				_paddingBottom = nVal;
				invalidate(INVALIDATION_FLAG_STYLES);
			}
		}
		
		// paddingLeft Property	[r/w]
		public function get paddingLeft():Number {
			return _paddingLeft;
		}
		public function set paddingLeft(nVal:Number):void {
			if (_paddingLeft != nVal) {
				_paddingLeft = nVal;
				invalidate(INVALIDATION_FLAG_STYLES);
			}
		}
		
		// paddingRight Property	[r/w]
		public function get paddingRight():Number {
			return _paddingRight;
		}
		public function set paddingRight(nVal:Number):void {
			if (_paddingRight != nVal) {
				_paddingRight = nVal;
				invalidate(INVALIDATION_FLAG_STYLES);
			}
		}
		
		// paddingTop Property	[r/w]
		public function get paddingTop():Number {
			return _paddingTop;
		}
		public function set paddingTop(nVal:Number):void {
			if (_paddingTop != nVal) {
				_paddingTop = nVal;
				invalidate(INVALIDATION_FLAG_STYLES);
			}
		}
		
		// title Property	[r/w]
		public function get title():String {
			return _title;
		}
		public function set title(sVal:String):void {
			if (_title != sVal) {
				_title = sVal;
				invalidate(INVALIDATION_FLAG_STYLES);
			}
		}
		
		// titleMargin Property	[r/w]
		public function get titleMargin():Number {
			return _titleMargin;
		}
		public function set titleMargin(nVal:Number):void {
			if (_titleMargin != nVal) {
				_titleMargin = nVal;
				invalidate(INVALIDATION_FLAG_STYLES);
			}
		}
		
		// PUBLIC METHODS ------------------------------------------------------------------------------
		
		// PROTECTED PROPERTIES ------------------------------------------------------------------------
		
		protected var _background:Quad;
		protected var _bodyBounds:Rectangle;
		protected var _bodySkin:Scale9Image;
		protected var _centerTitle:Boolean;
		protected var _dialogTop:Number;
		protected var _dialogWidth:Number = -80;
		protected var _headerPadding:Number = 8;
		protected var _headerSkin:Scale9Image;
		protected var _modalAlpha:Number = 0.5;
		protected var _paddingBottom:Number = 10;
		protected var _paddingLeft:Number = 10;
		protected var _paddingRight:Number = 10;
		protected var _paddingTop:Number = 10;
		protected var _title:String;
		protected var _titleLabel:Label;
		protected var _titleMargin:Number = 20;
		
		// PROTECTED METHODS ---------------------------------------------------------------------------
		
		// draw()
		override protected function draw():void {
			var bSize:Boolean, bStyle:Boolean;
			var nGap:Number, nHdrH:Number, nW:Number, nX:Number, nY:Number;
			
			bSize = this.isInvalid(INVALIDATION_FLAG_SIZE);
			bStyle = this.isInvalid(INVALIDATION_FLAG_STYLES);
			
			if (bSize) {
				_background.width = actualWidth;
				_background.height = actualHeight;
			}
			
			if (bSize || bStyle) {
				nW = (_dialogWidth < 0) ? actualWidth * _dialogWidth / 100 * -1 : _dialogWidth;
				nX = (actualWidth - nW) / 2;
				
				_titleLabel.validate();
				_titleLabel.x = (_centerTitle) ? ((nW - _titleLabel.width) >> 1) + nX : nX + _titleMargin;
				_titleLabel.y = _dialogTop + _headerPadding;
				
				nHdrH = _titleLabel.height + (_headerPadding << 1);
				nY = nHdrH + _dialogTop;
				
				_headerSkin.x = nX;
				_headerSkin.y = _dialogTop;
				_headerSkin.width = nW;
				_headerSkin.height = nHdrH;
				
				_bodyBounds = new Rectangle(
					nX + _paddingLeft, nY + _paddingTop, nW - _paddingLeft - _paddingRight, 0);
				positionChildren();
				
				_bodySkin.x = nX;
				_bodySkin.y = nY;
				_bodySkin.width = nW;
				_bodySkin.height = _bodyBounds.height + _paddingBottom + _paddingTop;
			}
		}
		
		// initialize()
		override protected function initialize():void {
			super.initialize();
			
			_background = new Quad(16, 16, 0x808080);
			_background.alpha = _modalAlpha;
			addChild(_background);
			
//			_headerSkin = _mobile.getScale9Image(Game.MAIN_LIST_HEADER_SKIN);
//			addChild(_headerSkin);
//			
//			_bodySkin = _mobile.getScale9Image(Game.MAIN_LIST_BODY_SKIN);
//			addChild(_bodySkin);
//			
//			_titleLabel = new Label();
//			_titleLabel.nameList.add(PigskinTheme.MAIN_LIST_TITLE);
//			_titleLabel.text = _title;
//			addChild(_titleLabel);
		}
		
		// positionChildren()
		// Must be overridden to position children with bounds specified by the _bodyBounds property.
		// Override must set the height of _bodyBounds to the height needed to display children.
		protected function positionChildren():void {
			
		}
		
		// PRIVATE -------------------------------------------------------------------------------------
		
//		private var _mobile:MaxMobileController = MaxMobileController.instance;
		
		// PRIVATE STATIC ------------------------------------------------------------------------------
		
	}
	
}