package nid.framework.ui.controls
{
    import flash.display.*;

    public class ColorDrag extends Sprite
    {
        public var nr:int;
        public var color:uint;
        public var opacity:Number;
        var selected:Boolean;

        public function ColorDrag(param1:uint, param2:Number = 1, param3:int = 0)
        {
            this.nr = param3;
            this.color = param1;
            this.opacity = param2;
            this.selected = false;
            this.Redraw();
            return;
        }// end function

        public function SetColor(param1:uint) : void
        {
            this.color = param1;
            this.Redraw();
            return;
        }// end function

        public function SetOpacity(param1:Number) : void
        {
            this.opacity = param1;
            return;
        }// end function

        public function Mark(param1:Boolean) : void
        {
            this.selected = param1;
            this.Redraw();
            return;
        }// end function

        public function Redraw() : void
        {
            this.graphics.clear();
            this.graphics.beginFill(0);
            this.graphics.drawRect(4, 0, 1, 1);
            this.graphics.drawRect(3, 1, 3, 1);
            this.graphics.drawRect(2, 2, 5, 1);
            this.graphics.drawRect(1, 3, 7, 1);
            this.graphics.drawRect(0, 4, 9, 1);
            this.graphics.endFill();
            if (!this.selected)
            {
                this.graphics.beginFill(13421772);
                this.graphics.drawRect(4, 1, 1, 1);
                this.graphics.drawRect(3, 2, 3, 1);
                this.graphics.drawRect(2, 3, 5, 1);
                this.graphics.drawRect(1, 4, 7, 1);
                this.graphics.endFill();
            }
            this.graphics.beginFill(0);
            this.graphics.drawRect(0, 5, 9, 10);
            this.graphics.endFill();
            this.graphics.beginFill(16777215);
            this.graphics.drawRect(1, 6, 7, 8);
            this.graphics.endFill();
            this.graphics.beginFill(this.color);
            this.graphics.drawRect(2, 7, 5, 6);
            this.graphics.endFill();
            return;
        }// end function

    }
}
