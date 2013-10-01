package nid.framework.ui.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
	import nid.framework.events.SliderEvent;

    public class Slider extends Sprite
    {
        internal var drag:Sprite;
        internal var size:int = 100;
		
		[Embed(source = '../../theme/dark/assets/slider/SlidebarDragOut.png')]
		private var SlidebarDragOut:Class;
		
		
        public function Slider(param1:int, param2:int = 100)
        {
             size = param1;
             drag = new IconButton("", Bitmap(new SlidebarDragOut()).bitmapData);
             graphics.beginFill(14935011);
             graphics.drawRect(1, 10, (param1 - 1), 4);
             graphics.beginFill(9079434);
             graphics.drawRect(0, 10, (param1 - 1), 3);
             graphics.beginFill(13882323);
             graphics.drawRect(1, 11, param1 - 2, 2);
             graphics.endFill();
             addEventListener(MouseEvent.MOUSE_DOWN,  MiddleMouseDown, false, 1, true);
             drag.y = 3;
             drag.x = Math.round(param1 * (param2 / 100) - 4);
             drag.addEventListener(MouseEvent.MOUSE_DOWN,  DragMouseDown, false, 0, true);
            addChild( drag);
            return;
        } 

        public function Get() : Number
        {
            return ( drag.x + 4) /  size;
        } 

        public function Add(param1:Number) : void
        {
             drag.x = Math.round( drag.x + param1 *  size);
            if ( drag.x >  size - 4)
            {
                 drag.x =  size - 4;
            }
             DragMouseMove(null);
            return;
        } 

        public function Remove(param1:Number) : void
        {
             drag.x = Math.round( drag.x - param1 *  size);
            if ( drag.x < -4)
            {
                 drag.x = -4;
            }
             DragMouseMove(null);
            return;
        } 

        public function Set(param1:Number, param2:Boolean = true) : void
        {
            if (param1 < 0)
            {
                param1 = 0;
            }
            else if (param1 > 1)
            {
                param1 = 1;
            }
             drag.x = Math.round( size * param1 - 4);
            if (param2)
            {
                 DragMouseMove(null);
            }
            return;
        } 

        private function DragMouseMove(event:Event) : void
        {
            dispatchEvent(new SliderEvent(SliderEvent.DRAG, ( drag.x + 4) /  size, event == null));
            return;
        } 

        internal function DragMouseDown(event:MouseEvent) : void
        {
             drag.startDrag(false, new Rectangle(-4, 3,  size, 0));
            stage.addEventListener(MouseEvent.MOUSE_MOVE,  DragMouseMove, false, 1, true);
            stage.addEventListener(MouseEvent.MOUSE_UP,  DragMouseUp, false, 1, true);
            return;
        } 

        internal function DragMouseUp(event:MouseEvent) : void
        {
             drag.stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,  DragMouseMove, false);
            stage.removeEventListener(MouseEvent.MOUSE_UP,  DragMouseUp, false);
            dispatchEvent(new SliderEvent(SliderEvent.DRAG, ( drag.x + 4) /  size, event == null));
            dispatchEvent(new SliderEvent(SliderEvent.RELEASE, ( drag.x + 4) /  size));
            return;
        } 

        private function MiddleMouseDown(event:MouseEvent) : void
        {
            if ( mouseX > 0 &&  mouseX <  size)
            {
                 drag.x = Math.round( mouseX - 4);
                 DragMouseDown(null);
            }
            return;
        } 

    }
}
