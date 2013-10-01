package nid.framework.events
{
    import flash.events.*;

    public class DialogEvent extends Event
    {
        public static const CANCEL:String = "cancel";
        public static const OK:String = "ok";

        public function DialogEvent(param1:String) : void
        {
            super(param1);
            return;
        }// end function

    }
}
