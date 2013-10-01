package nid.framework.ui.controls
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import nid.framework.utils.BitmapUtils;

	public class Button extends Sprite
	{
		public var title:TextField;
		internal var out:Bitmap;
		internal var over:Bitmap;
		internal var bg:Sprite;

		[Embed(source = '../../theme/dark/assets/ButtonFillOn.png')]
		private var ButtonFillOn:Class;

		public function Button(_label:String, _width:int)
		{
			graphics.beginFill(9474192);
			graphics.drawRect(0, 0, _width, 20);
			graphics.beginFill(16777215);
			graphics.drawRect(1, 1, _width - 2, 18);
			graphics.endFill();

			addEventListener(MouseEvent.MOUSE_OVER,  MouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT,  MouseOut, false, 0, true);
			
			out = new Bitmap(BitmapUtils.Desaturate(Bitmap(new ButtonFillOn()).bitmapData));
			over = new ButtonFillOn();
			
			over.y = 2;
			over.x = 2
			out.y = 2;
			out.x = 2;
			
			over.width = _width - 4;
			out.width = _width - 4;
			
			addChild( out);
			
			title = new TextField();
			title.y = 1;
			title.defaultTextFormat = new TextFormat("Arial, Helvetica, San-serif", 11, 0, false, false, false, null, null, "center");
			title.height = 18;
			title.width = _width;
			title.multiline = false;
			title.selectable = false;
			title.text =_label;
			addChild(title);
			return;
		}

		private function MouseOver(event:MouseEvent) : void
		{
			removeChildAt(0);
			addChildAt( over, 0);
			return;
		}

		private function MouseOut(event:MouseEvent) : void
		{
			removeChildAt(0);
			addChildAt( out, 0);
			return;
		}

	}
}

