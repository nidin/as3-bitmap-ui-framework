package ispg.framework.ui.controls
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextFieldType;
	import ispg.framework.events.NumberEvent;
	import ispg.framework.events.SliderEvent;
	
	
    public class Dropslider extends Sprite
    {
        private var min:int = 0;
        private var max:int = 100;
        private var tb:NumberInput;
        private var slider:Slider;
        private var click:IconButton;
        private var holder:Sprite;
        private var disable:Sprite;
        private var dropShadow:DropShadowFilter;
		
		[Embed(source = '../../theme/dark/assets/dropdown/DropdownOver.png')]
		private var DropdownOver:Class;
		
        public function Dropslider(param1:int, param2:int, param3:int, param4:int = 100)
        {
             dropShadow = new DropShadowFilter(2, 45, 0, 0.2, 3, 3, 1, 2);
             min = param2;
             max = param3;
             holder = new Sprite();
             click = new IconButton("", Bitmap(new DropdownOver()).bitmapData);
             tb = new NumberInput(param1 -  click.width, param4, param2, param3);
             tb.addEventListener(NumberEvent.CHANGE,  NumberChange, false, 1, true);
            addChild( tb);
             click.addEventListener(MouseEvent.MOUSE_DOWN,  ClickMouseDown, false, 0, true);
             click.x =  tb.x +  tb.width;
            addChild( click);
             DrawSlider(param4);
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
                 disable.height =  tb.height;
                 disable.width =  tb.width +  click.width;
                addChild( disable);
            }
             tb.t.type = param1 ? (TextFieldType.DYNAMIC) : (TextFieldType.INPUT);
             disable.visible = param1;
            return;
        } 

        public function Set(param1:int) : void
        {
             slider.Set(param1 /  max, false);
             tb.value = param1;
            return;
        } 

        private function DrawSlider(param1:int) : void
        {
             holder.visible = false;
             holder.filters = [ dropShadow];
             holder.x =  click.x - 96;
             holder.y = 18;
             holder.graphics.beginFill(9474192);
             holder.graphics.drawRect(0, 0, 117, 23);
             holder.graphics.beginFill(13225424);
             holder.graphics.drawRect(1, 1, 115, 21);
             holder.graphics.endFill();
             slider = new Slider(100);
             slider.addEventListener(SliderEvent.DRAG,  SliderDrag, false, 1, true);
             slider.addEventListener(SliderEvent.RELEASE,  SliderRelease, false, 1, true);
             slider.x = 8;
             slider.y = 1;
             slider.Set( tb.value /  max);
             holder.addChild( slider);
            addChild( holder);
            return;
        } 

        internal function NumberChange(event:NumberEvent) : void
        {
             slider.Set(event.val /  max);
            dispatchEvent(new SliderEvent(SliderEvent.DRAG, event.val));
            dispatchEvent(new SliderEvent(SliderEvent.CHANGE, event.val));
            return;
        } 

        internal function SliderDrag(event:SliderEvent) : void
        {
            if (!event.manual)
            {
                 tb.value = Math.round(event.percent * ( max -  min) +  min);
                dispatchEvent(new SliderEvent(SliderEvent.DRAG));
            }
            else
            {
                dispatchEvent(new SliderEvent(SliderEvent.DRAG));
                dispatchEvent(new SliderEvent(SliderEvent.CHANGE));
            }
            return;
        } 

        internal function SliderRelease(event:SliderEvent) : void
        {
            dispatchEvent(new SliderEvent(SliderEvent.CHANGE));
            return;
        } 

        private function ClickMouseDown(event:MouseEvent) : void
        {
             holder.visible = ! holder.visible;
            if ( holder.visible)
            {
                stage.addEventListener(MouseEvent.MOUSE_DOWN,  ClickOutside, true);
            }
            else
            {
                stage.removeEventListener(MouseEvent.MOUSE_DOWN,  ClickOutside, true);
            }
            return;
        } 

        private function ClickOutside(event:MouseEvent) : void
        {
            if (! holder.hitTestPoint(event.stageX, event.stageY) && ! click.hitTestPoint(event.stageX, event.stageY))
            {
                stage.removeEventListener(MouseEvent.MOUSE_DOWN,  ClickOutside, true);
                 holder.visible = false;
            }
            return;
        } 

        public function get value() : int
        {
            return  tb.value;
        } 

    }
}
