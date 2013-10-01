package nid.framework.events
{
    import flash.events.*;

    public class SliderEvent extends Event
    {
        public var percent:Number;
        public var manual:Boolean;
        public static const DRAG:String = "draggin";
        public static const RELEASE:String = "releasing";
        public static const CHANGE:String = "change";

        public function SliderEvent(param1:String, param2:Number = 1, param3:Boolean = false)
        {
            super(param1);
            this.percent = param2;
            this.manual = param3;
            return;
        }// end function

    }
}
