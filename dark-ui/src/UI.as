package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;

    public class UI extends Object
    {

        public function UI()
        {
            return;
        }// end function

        public static function AddToContext(param1:ContextMenu, param2:String, param3:Function, param4:Boolean = false) : void
        {
            return;
        }// end function

        public static function GetPart(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : BitmapData
        {
            var _loc_6:* = new BitmapData(param4, param5);
            new BitmapData(param4, param5).copyPixels(param1, new Rectangle(param2, param3, param4, param5), param1.rect.topLeft);
            return _loc_6;
        }// end function

        public static function Desaturate(param1:BitmapData) : BitmapData
        {
            var _loc_2:uint = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_7:int = 0;
            var _loc_6:int = 0;
            while (_loc_6 < param1.width)
            {
                
                _loc_7 = 0;
                while (_loc_7 < param1.height)
                {
                    
                    _loc_2 = param1.getPixel(_loc_6, _loc_7);
                    _loc_3 = _loc_2 >>> 16 & 255;
                    _loc_4 = _loc_2 >>> 8 & 255;
                    _loc_5 = _loc_2 & 255;
                    var _loc_8:* = 0.299 * _loc_3 + 0.587 * _loc_4 + 0.114 * _loc_5;
                    _loc_5 = 0.299 * _loc_3 + 0.587 * _loc_4 + 0.114 * _loc_5;
                    _loc_4 = _loc_8;
                    _loc_3 = _loc_8;
                    param1.setPixel(_loc_6, _loc_7, _loc_3 << 16 | _loc_4 << 8 | _loc_5);
                    _loc_7++;
                }
                _loc_6++;
            }
            return param1;
        }// end function
        public static function Combine(param1:BitmapData, param2:BitmapData, param3:int, param4:int) : BitmapData
        {
            var _loc_5:Rectangle = null;
            var _loc_6:BitmapData = null;
            if (param1.rect.containsRect(new Rectangle(param3, param4, param2.width, param2.height)))
            {
                param1.copyPixels(param2, param2.rect, new Point(param3, param4), null, null, true);
                return param1;
            }
            _loc_5 = param1.rect.union(new Rectangle(param3, param4, param2.width, param2.height));
            _loc_6 = new BitmapData(_loc_5.width, _loc_5.height, true, 16777215);
            _loc_6.copyPixels(param1, param1.rect, param1.rect.topLeft, null, null, true);
            _loc_6.copyPixels(param2, param2.rect, new Point(param3, param4), null, null, true);
            return _loc_6;
        }// end function

    }
}
