package nid.framework.ui.controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import nid.framework.utils.BitmapUtils;
	
    public class IconButton extends Sprite
    {
        private var over:Bitmap;
        private var out:Bitmap;
		
        public function IconButton(param2:String, param3:BitmapData)
        {
			name = param2;
			over = new Bitmap(param3);
			out = new Bitmap(param3.clone());
			BitmapUtils.Desaturate( out.bitmapData);
			over.visible = false;
			addChild( out);
			addChild( over);
			addEventListener(MouseEvent.MOUSE_OVER,  MouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT,  MouseOut, false, 0, true);
            return;
        }

        private function MouseOver(event:MouseEvent) : void
        {
			out.visible = false;
			over.visible = true;
			return;
        }

        private function MouseOut(event:MouseEvent) : void
        {
			out.visible = true;
			over.visible = false;
			return;
        }

    }
}
