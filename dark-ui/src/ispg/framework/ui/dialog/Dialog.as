package ispg.framework.ui.dialog
{
    import flash.events.*;
    import flash.utils.*;

    public class Dialog extends Box
    {
        public var ok:Button;
        public var notok:Button;
        public var cancel:Button;

        public function Dialog(param1:Editor, param2:String, param3:int, param4:int, param5:Boolean)
        {
            super(param1, param2, param3, param4);
            this.AddToStage(param5);
            this.ok = new Button("rm_ok", 70);
            this.ok.addEventListener(MouseEvent.CLICK, this.OKClick, false, 0, true);
            this.ok.x = param3 - 82;
            this.ok.y = param4 - 33;
            addChild(this.ok);
            this.cancel = new Button("rm_cancel", 70);
            this.cancel.addEventListener(MouseEvent.CLICK, this.CloseClick, false, 0, true);
            this.cancel.x = param3 - 162;
            this.cancel.y = param4 - 33;
            addChild(this.cancel);
            return;
        }// end function

        private function KeyDown(event:KeyboardEvent) : void
        {
            if (ed.IsTopmost(this))
            {
                if (event.keyCode == 13)
                {
                    this.OKClick(null);
                }
                else if (event.keyCode == 27)
                {
                    this.CloseClick(null);
                }
            }
            return;
        }// end function

        public function AddToStage(param1:Boolean = false) : void
        {
            if (ed != null)
            {
                this.alpha = 0;
                this.x = int((ed.stage.stageWidth - this.width) / 2);
                this.y = int((ed.stage.stageHeight - this.height) / 2);
                ed.addChild(this);
                ed.SetModal(this, param1);
                ed.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.KeyDown, false, 1, true);
                setTimeout(this.Tween, 10);
            }
            return;
        }// end function

        public function Tween() : void
        {
            this.alpha = this.alpha + 0.25;
            if (this.alpha < 1)
            {
                setTimeout(this.Tween, 15);
            }
            else
            {
                this.alpha = 1;
            }
            return;
        }// end function

        override public function CloseClick(event:MouseEvent) : void
        {
            if (!AppState.TextInteraction)
            {
                this.Close();
            }
            return;
        }// end function

        public function OKClick(event:MouseEvent) : void
        {
            if (!AppState.TextInteraction)
            {
                this.Close();
            }
            return;
        }// end function

        public function Close() : void
        {
            if (ed != null)
            {
                ed.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.KeyDown, false);
                ed.removeChild(this);
                ed.RemoveModal();
            }
            return;
        }// end function

    }
}
