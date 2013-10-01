package ispg.framework.ui.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
	import ispg.framework.events.ScrollEvent;

    public class Scrollbar extends Sprite
    {
        private var size:int = 0;
        private var cs:Rectangle;
        private var holder:Sprite;
        private var home:Sprite;
        private var end:Sprite;
        private var drag:Sprite;
        private var bg:Sprite;
        private var dstart:Bitmap;
        private var dmiddle:Bitmap;
        private var dstop:Bitmap;
        private var dgrip:Bitmap;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarDown.png')]
		private var ScrollbarDown:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarHdrgGrip.png')]
		private var ScrollbarHdrgGrip:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarHdrgLeft.png')]
		private var ScrollbarHdrgLeft:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarHdrgMiddle.png')]
		private var ScrollbarHdrgMiddle:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarHdrgRight.png')]
		private var ScrollbarHdrgRight:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarLeft.png')]
		private var ScrollbarLeft:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarRight.png')]
		private var ScrollbarRight:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarUp.png')]
		private var ScrollbarUp:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarVdrgBottom.png')]
		private var ScrollbarVdrgBottom:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarVdrgGrip.png')]
		private var ScrollbarVdrgGrip:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarVdrgMiddle.png')]
		private var ScrollbarVdrgMiddle:Class;
		
		[Embed(source = '../../theme/dark/assets/scroller/ScrollbarVdrgTop.png')]
		private var ScrollbarVdrgTop:Class;
		
        public function Scrollbar(param1:Sprite, param2:Rectangle)
        {
            holder = param1;
            cs = param2;
            param1.scrollRect = param2;
            param1.addEventListener(MouseEvent.MOUSE_WHEEL, MouseScroll, false, 1, true);
            size = param2.height;
            Render();
            return;
        }

        public function SetContentHeight(param1:int, param2:Boolean = false) : void
        {
            cs.height = param1;
            SetSize( size, param2);
            return;
        }

        public function SetWidth(param1:int) : void
        {
            var _loc_2:* = holder.scrollRect;
            _loc_2.width = param1;
            holder.scrollRect = _loc_2;
            return;
        }

        public function SetSize(param1:int, param2:Boolean = false) : void
        {
            size = param1;
            var _loc_3:* = holder.scrollRect;
            _loc_3.height = param1 > cs.height ? ( cs.height) : (param1);
            if (_loc_3.height + _loc_3.y > cs.height || _loc_3.height < cs.height && param2)
            {
                _loc_3.y = cs.height - _loc_3.height;
            }
            holder.scrollRect = _loc_3;
            Recalculate();
            return;
        }

        public function Recalculate() : void
        {
            if ( cs.height > size)
            {
                if ( visible == false)
                {
                    visible = true;
                    dispatchEvent(new ScrollEvent(ScrollEvent.APPEARANCE));
                }
                dmiddle.height = size - 42 - ( cs.height - size) < 8 ? (8) : ( size - 42 - ( cs.height - size));
                dstop.y = dmiddle.y + dmiddle.height;
                dgrip.y = dmiddle.y + int( dmiddle.height / 2) - 3;
                end.y = size - 15;
                drag.y = Math.round( holder.scrollRect.y / ( cs.height - size) * ( size - drag.height - 32)) + 16;
            }
            else if ( visible == true)
            {
                drag.y = 16;
                visible = false;
                dispatchEvent(new ScrollEvent(ScrollEvent.APPEARANCE));
            }
            bg.height = size;
            return;
        }

        private function Render() : void
        {
            bg = new Sprite();
            bg.graphics.beginFill(15132390);
            bg.graphics.drawRect(0, 0, 16, 16);
            bg.graphics.endFill();
            bg.height = size;
            bg.alpha = 0.7;
            addChild(bg);
            home = new Sprite();
            home.addChild(new ScrollbarUp());
            home.addEventListener(MouseEvent.MOUSE_DOWN, UpClick, false, 1, true);
            home.y = 1;
            home.x = 1;
            addChild( home);
            end = new Sprite();
            end.addChild(new ScrollbarDown());
            end.addEventListener(MouseEvent.MOUSE_DOWN, DownClick, false, 1, true);
            end.x = 1;
            end.y = size - 14;
            addChild( end);
            drag = new Sprite();
            drag.addEventListener(MouseEvent.MOUSE_DOWN, DragMouseDown, false, 1, true);
            drag.addEventListener(MouseEvent.MOUSE_UP, DragMouseUp, false, 1, true);
            drag.x = 1;
            drag.y = 14;
            dstart = new ScrollbarVdrgTop();
            drag.addChild(dstart);
            dmiddle = new ScrollbarVdrgMiddle();
            dmiddle.y = 5;
            drag.addChild( dmiddle);
            dstop = new ScrollbarVdrgBottom();
            dstop.y = 15;
            drag.addChild( dstop);
            dgrip = new ScrollbarVdrgGrip();
            dgrip.y = 6;
            dgrip.x = 5;
            drag.addChild(dgrip);
            addChild(drag);
            Recalculate();
            return;
        }

        private function DragMove(... args) : void
        {
            var dragRect:Rectangle = holder.scrollRect;
            dragRect.y = Math.round(( cs.height - size) * (( drag.y - 16) / ( height - drag.height - 32)));
            holder.scrollRect = dragRect;
            return;
        }

        public function ScrollTo(param1:int) : void
        {
            var _loc_2:* = holder.scrollRect;
            if (param1 < _loc_2.y)
            {
                _loc_2.y = param1;
                holder.scrollRect = _loc_2;
                Recalculate();
            }
            if (_loc_2.y + _loc_2.height < param1)
            {
                _loc_2.y = param1 - _loc_2.height;
                holder.scrollRect = _loc_2;
                Recalculate();
            }
            return;
        }

        private function MouseScroll(event:MouseEvent) : void
        {
            drag.y = drag.y - event.delta * 3;
            if ( drag.y < 16)
            {
                drag.y = 16;
            }
            else if ( drag.y > size - drag.height - 16)
            {
                drag.y = size - drag.height - 16;
            }
            DragMove();
            return;
        }

        internal function UpClick(event:MouseEvent) : void
        {
            if ( drag.y - 10 > 16)
            {
                drag.y = drag.y - 10;
            }
            else
            {
                drag.y = 16;
            }
            DragMove();
            return;
        }

        internal function DownClick(event:MouseEvent) : void
        {
            if ( drag.y + 10 < size - drag.height - 16)
            {
                drag.y = drag.y + 10;
            }
            else
            {
                drag.y = size - drag.height - 16;
            }
            DragMove();
            return;
        }

        internal function DragMouseDown(event:MouseEvent) : void
        {
            drag.startDrag(false, new Rectangle(1, 16, 0, size - 32 - drag.height));
            stage.addEventListener(MouseEvent.MOUSE_MOVE, DragMove, false, 1, true);
            stage.addEventListener(MouseEvent.MOUSE_UP, DragMouseUp, true, 1, true);
            return;
        }

        internal function DragMouseUp(event:MouseEvent) : void
        {
            drag.stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, DragMove, true);
            stage.removeEventListener(MouseEvent.MOUSE_UP, DragMouseUp, true);
            return;
        }

    }
}
