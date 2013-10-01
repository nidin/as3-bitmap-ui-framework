package nid.framework.theme.dark
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import nid.framework.ui.controls.IconButton;
	import nid.framework.utils.BitmapUtils;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Box extends Sprite
    {
        public var close:IconButton;
		public var closeHandler:Function;
        private var drag:Sprite;
        private var t:TextField;
        private var tl:Bitmap;
        private var tm:Bitmap;
        private var tr:Bitmap;
        private var ml:Bitmap;
        private var mm:Bitmap;
        private var mr:Bitmap;
        private var bl:Bitmap;
        private var bm:Bitmap;
        private var br:Bitmap;
		
		//[Embed(source='assets/BoxBg.png')]
		//private var bg_bmp:Class;		
		
		[Embed(source='assets/BoxBg_blue.png')]
		private var bg_bmp:Class;
		
		[Embed(source='assets/CloseOn.png')]
		private var close_bmp:Class;
		
		
        public function Box(title:String, _width:int, _height:int)
        {
            filters = [new DropShadowFilter(0, 45, 0, 0.4, 10, 10, 1, 3, false)];
			
            var bg_bmp_data:BitmapData = Bitmap(new bg_bmp()).bitmapData;
			
			
			/** TOP LEFT **/
            var tl_bmp_data:BitmapData = new BitmapData(24, 50, true, 16777215);
			tl_bmp_data.copyPixels(bg_bmp_data, new Rectangle(0, 0, 24, 18), new Point(0, 0));
            tl_bmp_data.copyPixels(bg_bmp_data, new Rectangle(0, 27, 24, 32), new Point(0, 18));
            tl = new Bitmap(tl_bmp_data);
            addChild(tl);
			
			/** TOP MIDDLE **/
            var tm_bmp_data:BitmapData = new BitmapData(2, 50, true, 16777215)
			tm_bmp_data.copyPixels(bg_bmp_data, new Rectangle(24, 0, 2, 18), new Point(0, 0));
            tm_bmp_data.copyPixels(bg_bmp_data, new Rectangle(24, 27, 2, 32), new Point(0, 18));
            tm = new Bitmap(tm_bmp_data);
            addChild(tm);
			
			/** TOP RIGHT **/
            var tr_bmp_data:BitmapData = new BitmapData(24, 50, true, 16777215);
			tr_bmp_data.copyPixels(bg_bmp_data, new Rectangle(26, 0, 24, 18), new Point(0, 0));
            tr_bmp_data.copyPixels(bg_bmp_data, new Rectangle(26, 27, 24, 32), new Point(0, 18));
            tr = new Bitmap(tr_bmp_data);
            addChild(tr);
			
			/** MIDDLE LEFT **/
            ml = new Bitmap(BitmapUtils.GetPart(bg_bmp_data, 0, 55, 24, 2));
            addChild(ml);
			/** MIDDLE MIDDLE **/
            mm = new Bitmap(BitmapUtils.GetPart(bg_bmp_data, 24, 55, 2, 2));
            addChild(mm);
			/** MIDDLE RIGHT **/
            mr = new Bitmap(BitmapUtils.GetPart(bg_bmp_data, 26, 55, 24, 2));
            addChild(mr);
			/** BOTTOM LEFT **/
            bl = new Bitmap(BitmapUtils.GetPart(bg_bmp_data, 0, 57, 24, 10));
            addChild(bl);
			/** BOTTOM MIDDLE **/
            bm = new Bitmap(BitmapUtils.GetPart(bg_bmp_data, 24, 57, 2, 10));
            addChild(bm);
			
			/** BOTTOM RIGHT **/
            br = new Bitmap(BitmapUtils.GetPart(bg_bmp_data, 26, 57, 24, 10));
            addChild(br);
			
            bg_bmp_data.dispose();
            bg_bmp_data = null;
			
			/** TITLE TEXT **/
            t = new TextField();
			t.defaultTextFormat = new TextFormat("Arial,Helvetica,San-serif", 11, 16777215, false, false, false, null, null, "center");
            t.selectable = false;
            t.multiline = false;
            t.height = 18;
            t.text = title;
            addChild( t);
			
			drag = new Sprite();
			drag.graphics.beginFill(9474192);
			drag.graphics.drawRect(0, 0, 100, 100);
			drag.graphics.endFill();
			drag.y = 1;
			drag.x = 1;
			drag.height = 17;
			drag.alpha = 0;
            addChild(drag);
			drag.addEventListener(MouseEvent.MOUSE_DOWN, DragMouseDown, false, 0, true);
			
            close = new IconButton("rm_close", Bitmap(new close_bmp()).bitmapData);
            addChild(close);
			close.addEventListener(MouseEvent.MOUSE_UP, CloseClick, false, 0, true);
			
			Resize(_width, _height);
        }
		public function Resize(_width:int, _height:int) : void
        {
            if (_width < 50)
            {
                _width = 50;
            }
            if (_height < 60)
            {
                _height = 60;
            }
			bm.width = _width - 48;
			mm.width = _width - 48;
			tm.width = _width - 48;
			mr.height = _height - 60;
			mm.height = _height - 60;
			ml.height = _height - 60;
			bm.x = 24;
			mm.x = 24;
			tm.x = 24;
			br.x =  tm.width + 24;
			mr.x = tm.width + 24;
			tr.x = tm.width + 24;
			mr.y = 50;
			mm.y = 50;
			ml.y =50;
			bl.y =  mm.height + 50;
			bm.y = mm.height + 50;
			br.y = mm.height + 50;
			t.width = _width;
			drag.width = _width - 2;
			close.y = 4;
			close.x = _width - 17;
            return;
        }
		
        public function CloseClick(event:MouseEvent):void
        {
			if (closeHandler != null) closeHandler(event);
            visible = false;
            return;
        }
        internal function DragMouseDown(event:MouseEvent):void
        {
            //startDrag(false, new Rectangle((- width) / 2, 40, stage.stageWidth, stage.stageHeight + 1000));
            startDrag(false);
            stage.addEventListener(MouseEvent.MOUSE_UP,  DragMouseUp, true, 0, true);
            return;
        }
        internal function DragMouseUp(event:MouseEvent):void
        {
            stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_UP,  DragMouseUp, true);
            return;
        }

        public function set title(param1:String):void
        {
            t.text = param1;
            return;
        }
    }
}
