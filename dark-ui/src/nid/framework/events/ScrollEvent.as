package nid.framework.events
{
    import flash.events.*;

    public class ScrollEvent extends Event
    {
        public var scrolled:Number;
        public static const SCROLL:String = "scroll";
        public static const APPEARANCE:String = "appearance";

        public function ScrollEvent(param1:String, param2:Number = 0)
        {
            super(param1);
            this.scrolled = param2;
            return;
        }

    }
}
