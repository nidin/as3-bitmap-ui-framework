package nid.framework.ui.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
	import nid.framework.events.NumberEvent;
	import nid.framework.ui.UIState;

    public class NumberInput extends Sprite
    {
        public var t:TextField;
        private var w:int;
        private var h:int;
        private var min:Number;
        private var max:Number;
        private var decimal:Boolean;
        internal var disable:Sprite;
		
		[Embed(source = '../../theme/dark/assets/InputBackground.png')]
		private var InputBackground:Class;
		
        public function NumberInput(param1:int, param2:Number, param3:Number = 0, param4:Number = 100, param5:Boolean = false, param6:Boolean = true, param7:int = 20)
        {
             min = param3;
             max = param4;
             decimal = param5;
             w = param1;
             h = param7;
            if (param6)
            {
                 graphics.beginFill(9474192);
                 graphics.drawRect(0, 0, param1, param7);
                 graphics.beginBitmapFill(Bitmap(new InputBackground()).bitmapData);
                 graphics.drawRect(1, 1, param1 - 2, param7 - 2);
                 graphics.endFill();
            }
             t = new TextField();
             t.x = 2;
             t.y = 2;
             t.defaultTextFormat = new TextFormat("Verdana, Helvetica, San-serif", 10, 3355443);
             t.type = TextFieldType.INPUT;
             t.width = param1 - 4;
             t.height = param7 - 4;
             t.maxChars = param4.toString().length;
            if (param3 < 0)
            {
                ( t.maxChars + 1);
            }
            if (param5)
            {
                 t.maxChars =  t.maxChars + 2;
            }
             t.restrict = "0-9 +-.";
            if (!param5)
            {
                 t.text = param2.toString();
            }
            else
            {
                 t.text = param2.toString() + ".0";
            }
             t.addEventListener(KeyboardEvent.KEY_UP,  Changed, false, 1, true);
             t.addEventListener(FocusEvent.FOCUS_OUT,  FocusOut, false, 1, true);
             t.addEventListener(FocusEvent.FOCUS_IN,  FocusIn, false, 1, true);
            addChild( t);
            return;
        } 

        public function Disable(param1:Boolean = true) : void
        {
            if ( disable == null)
            {
                 disable = new Sprite();
                 disable.visible = false;
                 disable.alpha = 0.3;
                 disable.graphics.beginFill(9474192);
                 disable.graphics.drawRect(0, 0, 10, 10);
                 disable.graphics.endFill();
                 disable.height =  height;
                 disable.width =  width;
                addChild( disable);
            }
             disable.visible = param1;
            if (param1)
            {
                 t.selectable = false;
                 t.type = TextFieldType.DYNAMIC;
            }
            else
            {
                 t.selectable = true;
                 t.type = TextFieldType.INPUT;
            }
            return;
        } 

        private function Changed(event:KeyboardEvent) : void
        {
            var _loc_2:* = Number( t.text);
            if (! decimal)
            {
                _loc_2 = Math.round(_loc_2);
            }
            if (_loc_2 <  min)
            {
                _loc_2 =  min;
            }
            else if (_loc_2 >  max)
            {
                _loc_2 =  max;
            }
            dispatchEvent(new NumberEvent(_loc_2));
            return;
        } 

        private function FocusOut(... args) : void
        {
            UIState.TextInteraction = false;
             ValidateData();
            return;
        } 

        private function FocusIn(event:FocusEvent) : void
        {
            UIState.TextInteraction = true;
            return;
        } 

        public function get value() : Number
        {
            return Number( t.text);
        } 

        public function set value(param1:Number) : void
        {
             t.text = param1.toString();
             ValidateData();
            return;
        } 

        private function ValidateData() : void
        {
            var _loc_1:Number = NaN;
            if ( t.text == "")
            {
                _loc_1 =  min;
            }
            else if (Number( t.text) <  min)
            {
                _loc_1 =  min;
            }
            else if (Number( t.text) >  max)
            {
                _loc_1 =  max;
            }
            else
            {
                _loc_1 = Number( t.text);
            }
            if (_loc_1.toString().indexOf(".") != -1 || ! decimal)
            {
                 t.text = Math.round(_loc_1).toString();
            }
            else
            {
                 t.text = _loc_1.toString() + ".0";
            }
            return;
        } 

    }
}
