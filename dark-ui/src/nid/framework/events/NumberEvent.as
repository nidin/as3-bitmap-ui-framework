package nid.framework.events
{
    import flash.events.*;

    public class NumberEvent extends Event
    {
        public var val:Number;
        public static const CHANGE:String = "valch";

        public function NumberEvent(param1:Number)
        {
            super(CHANGE);
            this.val = param1;
            return;
        }// end function

    }
}
