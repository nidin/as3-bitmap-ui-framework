package nid.framework.ui.controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;


	public class SelectItem extends Sprite
	{
		internal var selected:Boolean;
		internal var index:int = 0;
		internal var bg:Sprite;
		internal var title:TextField;
		internal var icon:Bitmap;
		
		public var data:Object;

		public function SelectItem(_text:String, _name:String, _width:int,_data:Object=null, bmp_data:BitmapData = null)
		{
			name = _name;
			data = _data;
			var _mat:Matrix = new Matrix();
			_mat.createGradientBox(198, 20, 90 / (180 / Math.PI), 0, 0);
			bg = new Sprite();
			bg.graphics.beginGradientFill("linear", [3449586, 34534], [1, 1], [0, 255], _mat);
			bg.graphics.drawRect(0, 0, _width - 2, 20);
			bg.graphics.endFill();
			bg.alpha = 0;
			addChild( bg);
			if (bmp_data != null)
			{
				icon = new Bitmap(bmp_data);
				icon.x = 3;
				icon.y = 2;
				addChild( icon);
			}
			title = new TextField();
			title.defaultTextFormat = new TextFormat("Arial, Helvetica, San-serif",11,0,false,false,false,null,null,"left");
			title.multiline = false;
			title.selectable = false;
			title.autoSize = TextFieldAutoSize.LEFT;
			title.height = 16;
			title.text = _text;
			title.x =  icon != null ? (22) : (2);
			title.y = 2;
			addChild( title);
			addEventListener(MouseEvent.ROLL_OVER,  MouseOver, false, 1, true);
			addEventListener(MouseEvent.ROLL_OUT,  MouseOut, false, 1, true);
			return;
		}

		public function get text():String
		{
			return title.text;
		}

		public function set text(param1:String):void
		{
			title.text = param1;
			return;
		}

		public function Select(param1:Boolean = true):void
		{
			selected = param1;
			if (param1)
			{
				bg.alpha = 1;
				title.textColor = 16777215;
			}
			else
			{
				bg.alpha = 0;
				title.textColor = 0;
			}
			return;
		}

		private function MouseOver(event:MouseEvent):void
		{
			if (! selected)
			{
				bg.alpha = 0.9;
				title.textColor = 16777215;
			}
			return;
		}

		private function MouseOut(event:MouseEvent):void
		{
			if (! selected)
			{
				bg.alpha = 0;
				title.textColor = 0;
			}
			return;
		}

	}
}