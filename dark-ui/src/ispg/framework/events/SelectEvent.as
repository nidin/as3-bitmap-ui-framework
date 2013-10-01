package ispg.framework.events
{
	import flash.events.Event;

    public class SelectEvent extends Event
    {
        public var val:String;
        public static const EXECUTE:String = "execute";
        public static const COMMAND:String = "command";
        public static const CLOSE:String = "close";
        public static const HOVER:String = "hover";

        public function SelectEvent(param1:String, param2:String)
        {
            super(param1);
            this.val = param2;
            return;
        }

    }
}
