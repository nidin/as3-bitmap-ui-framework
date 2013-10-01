package ispg.framework.ui.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
	import ispg.framework.ui.UIState;

    public class TextInput extends Sprite
    {
        public var t:TextField;
        private var w:int;
        private var h:int;
        internal var disable:Sprite;
		
		[Embed(source='../../theme/dark/assets/InputBackground.png')]
		private var text_input_bmp:Class;
		
		public function set bold(value:Boolean):void
		{
			var f:TextFormat = t.getTextFormat();
			f.bold = value;
			t.setTextFormat(f);
		}
		public function set italic(value:Boolean):void
		{
			var f:TextFormat = t.getTextFormat();
			f.italic = value;
			t.setTextFormat(f);
		}
		public function set size(value:int):void
		{
			var f:TextFormat = t.getTextFormat();
			f.size = value;
			t.setTextFormat(f);
		}
        public function TextInput(_width:int, _maxChars:int = 0, _text:String = "", _height:int = 20)
        {
           w = _width;
           h = _height;
           graphics.beginFill(9474192);
           graphics.drawRect(0, 0, _width, _height);
           graphics.beginFill(16777215);
           graphics.drawRect(1, 1, _width - 2, _height - 2);
           graphics.beginBitmapFill(Bitmap(new text_input_bmp()).bitmapData);
           graphics.drawRect(1, 1, _width - 2, _height > 22 ? (20) : (_height - 2));
           graphics.endFill();
           t = new TextField();
           t.x = 2;
           t.y = 2;
           t.defaultTextFormat = new TextFormat("Verdana, Helvetica, San-serif", 10, 3355443);
           t.multiline = true;
           t.wordWrap = true;
           t.type = TextFieldType.INPUT;
           t.maxChars = _maxChars;
           t.text = _text;
           t.width = _width - 4;
           t.height = _height - 4;
           t.addEventListener(FocusEvent.FOCUS_OUT,FocusOut, false, 1, true);
           t.addEventListener(FocusEvent.FOCUS_IN,FocusIn, false, 1, true);
           addChild(t);
            
        }

        public function Disable(value:Boolean = true) : void
        {
            if ( disable == null)
            {
               disable = new Sprite();
               disable.visible = false;
               disable.alpha = 0.3;
               disable.graphics.beginFill(9474192);
               disable.graphics.drawRect(0, 0, 10, 10);
               disable.graphics.endFill();
               disable.height =height;
               disable.width =width;
               addChild( disable);
            }
           disable.visible = value;
            if (value)
            {
               t.selectable = false;
               t.type = TextFieldType.DYNAMIC;
            }
            else
            {
               t.selectable = true;
               t.type = TextFieldType.INPUT;
            }
            
        }

        private function FocusOut(event:FocusEvent) : void
        {
            UIState.TextInteraction = false;
            
        }

        private function FocusIn(event:FocusEvent) : void
        {
            UIState.TextInteraction = true;
            
        }

        public function set text(value:String) : void
        {
           t.text = value;
            
        }

        public function get text() : String
        {
            return t.text;
        }

        public function set value(value:String) : void
        {
           t.text = value;
            
        }

        public function get value() : String
        {
            return t.text;
        }

    }
}
