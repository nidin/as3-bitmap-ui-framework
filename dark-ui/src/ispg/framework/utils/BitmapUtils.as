package  ispg.framework.utils
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class BitmapUtils 
	{
		
		public function BitmapUtils() 
		{
			
		}
		public static function GetPart(src_bmp_data:BitmapData, param2:int, param3:int, param4:int, param5:int) : BitmapData
        {
            var bmp_data:BitmapData = new BitmapData(param4, param5);
            bmp_data.copyPixels(src_bmp_data, new Rectangle(param2, param3, param4, param5), src_bmp_data.rect.topLeft);
            return bmp_data;
        }
		
		public static function Desaturate(bmp_data:BitmapData) : BitmapData
        {
            var _loc_2:uint = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_7:int = 0;
            var _loc_6:int = 0;
            while (_loc_6 < bmp_data.width)
            {
                
                _loc_7 = 0;
                while (_loc_7 < bmp_data.height)
                {
                    
                    _loc_2 = bmp_data.getPixel(_loc_6, _loc_7);
                    _loc_3 = _loc_2 >>> 16 & 255;
                    _loc_4 = _loc_2 >>> 8 & 255;
                    _loc_5 = _loc_2 & 255;
                    var _loc_8:* = 0.299 * _loc_3 + 0.587 * _loc_4 + 0.114 * _loc_5;
                    _loc_5 = 0.299 * _loc_3 + 0.587 * _loc_4 + 0.114 * _loc_5;
                    _loc_4 = _loc_8;
                    _loc_3 = _loc_8;
                    bmp_data.setPixel(_loc_6, _loc_7, _loc_3 << 16 | _loc_4 << 8 | _loc_5);
                    _loc_7++;
                }
                _loc_6++;
            }
            return bmp_data;
        }
	}

}