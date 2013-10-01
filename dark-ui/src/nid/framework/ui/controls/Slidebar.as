package nid.framework.ui.controls
{
    import flash.display.*;
    import flash.text.*;
	import nid.framework.events.NumberEvent;
	import nid.framework.events.SliderEvent;

    public class Slidebar extends Sprite
    {
        var decimal:Boolean;
        var min:Number;
        var max:Number;
        var topic:Literal;
        var tb:NumberInput;
        var slider:Slider;
        var disable:Sprite;

        public function Slidebar(param1:String, param2:Number, param3:Number, param4:int, param5:Number = 100, param6:Boolean = false, param7:Boolean = false, param8:int = 40)
        {
             min = param2;
             max = param3;
             decimal = param7;
             slider = new Slider(param4, Math.round((param5 - param2) / (param3 - param2) * 100));
             slider.addEventListener(SliderEvent.DRAG,  SliderDrag, false, 1, true);
             slider.addEventListener(SliderEvent.RELEASE,  SliderRelease, false, 1, true);
            addChild( slider);
             topic = new Literal(param1);
            addChild( topic);
             tb = new NumberInput(param8, param5, param2, param3, param7, true, 18);
             tb.addEventListener(NumberEvent.CHANGE,  TextValueChange, false, 1, true);
            addChild( tb);
            if (param6)
            {
                 slider.y = -1;
                 topic.x = - topic.width - 2;
                 topic.y = 2;
                 tb.x = param4 + 7;
                 tb.y = 1;
            }
            else
            {
                 slider.y = 15;
                 topic.x = -2;
                 tb.x = param4 -  tb.width - 2;
                 tb.y = -1;
            }
            return;
        }

        public function Disable(param1:Boolean = true) : void
        {
            if ( disable == null)
            {
                 disable = new Sprite();
                 disable.visible = false;
                 disable.alpha = 0;
                 disable.graphics.beginFill(9474192);
                 disable.graphics.drawRect(0, 0, 10, 10);
                 disable.graphics.endFill();
                 disable.height =  height;
                 disable.width =  width;
                addChild( disable);
            }
             tb.t.type = param1 ? (TextFieldType.DYNAMIC) : (TextFieldType.INPUT);
             alpha = param1 ? (0.4) : (1);
             disable.visible = param1;
            return;
        }

        public function SliderDrag(event:SliderEvent) : void
        {
            var _loc_2:Number = NaN;
            if (!event.manual)
            {
                _loc_2 =  tb.value;
                 tb.value = event.percent * ( max -  min) +  min;
                if ( tb.value != _loc_2)
                {
                    dispatchEvent(new SliderEvent(SliderEvent.DRAG));
                }
            }
            return;
        }

        public function SliderRelease(event:SliderEvent) : void
        {
            dispatchEvent(new SliderEvent(SliderEvent.CHANGE,  value));
            return;
        }

        public function TextValueChange(event:NumberEvent) : void
        {
             slider.Set((event.val -  min) / ( max -  min));
            dispatchEvent(new SliderEvent(SliderEvent.CHANGE));
            dispatchEvent(new SliderEvent(SliderEvent.DRAG));
            return;
        }

        public function Set(param1:Number, param2:Boolean = false) : void
        {
             slider.Set((param1 -  min) / ( max -  min));
             tb.value = param1;
            return;
        }

        public function get value() : Number
        {
            return  tb.value;
        }

    }
}
