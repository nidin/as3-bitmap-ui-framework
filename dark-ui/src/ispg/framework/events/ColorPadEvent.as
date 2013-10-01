package ispg.framework.events
{
    import flash.events.*;

    public class ColorPadEvent extends Event
    {
        public var color:uint;
        public static const CHOOSE_COLOR:String = "cs";

        public function ColorPadEvent(param1:uint) : void
        {
            super(CHOOSE_COLOR);
            this.color = param1;
            return;
        }// end function

    }
}
