package ispg.framework.ui.controls
{
    import flash.display.*;
    import flash.geom.*;
	import ispg.framework.events.ColorPadEvent;

    public class ColorPad extends Sprite
    {
        internal var pad:Bitmap;
        internal var half:Boolean;
        public var color:uint;

        public function ColorPad(param1:uint, param2:Boolean = false)
        {
            color = param1;
            half = param2;
            var _loc_3:* = param2 ? (19) : (29);
            graphics.beginFill(9474192);
            graphics.drawRect(0, 0, 30, _loc_3);
            graphics.beginFill(16777215);
            graphics.drawRect(1, 1, 28, _loc_3 - 2);
            graphics.endFill();
            pad = new Bitmap(new BitmapData(26, _loc_3 - 4, false, param1));
            var _loc_4:int = 2;
            pad.y = 2;
            pad.x = _loc_4;
            addChild(this.pad);
            return;
        } 

        public function set value(param1:uint) : void
        {
            Set(param1);
            return;
        } 

        public function get value() : uint
        {
            return GetColor();
        } 

        public function GetColor() : uint
        {
            return 255 << 24 | (this.color >>> 16 & 255) << 16 | (this.color >>> 8 & 255) << 8 | color & 255;
        } 

        public function Set(param1:uint) : void
        {
            color = param1;
            pad.bitmapData.fillRect(new Rectangle(0, 0, 26, height - 4), param1);
            dispatchEvent(new ColorPadEvent(this.GetColor()));
            return;
        } 

    }
}
