package ispg.framework.events
{
    import flash.events.*;

    public class ChangeEvent extends Event
    {
        public var val:Object;
        public static const CHANGE:String = "change";

        public function ChangeEvent(param1)
        {
            super(CHANGE);
            this.val = param1;
            return;
        }// end function

    }
}
