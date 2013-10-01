package nid.framework.ui.dialog
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ColorLookupDialog extends BitmapOperationDialogBase
    {
        var f:Filter;
        var pattern:GradientPad;
        var gradients:Gradients;
        var bgs:Sprite;
        var mtx:Matrix;
        var bmg:BitmapData;
        var holder:Sprite;
        var a:Array;
        var scroller:Scrollbar;
        var gradienteditor:GradientEditor;

        public function ColorLookupDialog(param1:Editor)
        {
            this.a = new Array();
            super(param1, "rm_color_lookup", 360, 300, Action.ColorLookupFilter);
            this.f = new Filter();
            var _loc_2:* = new Sprite();
            _loc_2.graphics.beginFill(10856360);
            _loc_2.graphics.drawRect(0, 0, 350, 1);
            _loc_2.graphics.endFill();
            _loc_2.x = 4;
            _loc_2.y = 120;
            this.addChild(_loc_2);
            this.holder = new Sprite();
            this.holder.addEventListener(MouseEvent.ROLL_OVER, this.HolderMouseOver, false, 1, true);
            this.holder.addEventListener(MouseEvent.ROLL_OUT, this.HolderMouseOut, false, 1, true);
            this.holder.x = 5;
            this.holder.y = 121;
            addChild(this.holder);
            this.scroller = new Scrollbar(this.holder, new Rectangle(0, 0, 330, 170));
            this.scroller.x = 340;
            this.scroller.y = 121;
            addChild(this.scroller);
            this.gradienteditor = new GradientEditor(param1);
            this.gradienteditor.y = 10;
            this.gradienteditor.x = 0;
            this.gradienteditor.addEventListener(ChangeEvent.CHANGE, this.Change, false, 1, true);
            addChild(this.gradienteditor);
            var _loc_3:int = 279;
            cancel.x = 279;
            ok.x = _loc_3;
            ok.y = 25;
            cancel.y = 54;
            this.bgs = new Sprite();
            this.bmg = new BitmapData(256, 1, false, 16777215);
            this.PrepareStandardGradients();
            this.RenderGradients();
            return;
        }// end function

        override public function Change(... args) : void
        {
            if (!locked)
            {
                bm.copyPixels(bc, bm.rect, bm.rect.topLeft);
                this.bmg.fillRect(this.bmg.rect, 16777215);
                this.bmg.draw(this.gradienteditor.preview);
                this.f.ColorLookup(bm, bc, this.bmg, selection, offset);
            }
            return;
        }// end function

        private function PrepareStandardGradients()
        {
            this.a.push(new GradientInfo(new Array(0, 16777215), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(12877, 14031393, 14031393, 7378334, 7378334, 16507815), new Array(1, 1, 1, 1, 1, 1), new Array(64, 64, 127, 127, 200, 200)));
            this.a.push(new GradientInfo(new Array(10066329, 204890, 0), new Array(1, 1, 1), new Array(0, 128, 255)));
            this.a.push(new GradientInfo(new Array(43231, 3290262, 13244040, 15412782, 16640301, 40532), new Array(1, 1, 1, 1, 1, 1), new Array(0, 51, 102, 153, 204, 255)));
            this.a.push(new GradientInfo(new Array(721336, 266313776, 721336), new Array(1, 1, 1), new Array(32, 128, 224)));
            this.a.push(new GradientInfo(new Array(0, 16711680), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(16777215, 16711680), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(16777215, 65280), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(16777215, 255), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(4870484, 16777215, 4870484, 16777215, 4870484), new Array(1, 1, 1, 1, 1), new Array(0, 64, 128, 196, 255)));
            this.a.push(new GradientInfo(new Array(2722252, 16777215, 9464320, 14262016, 16777215), new Array(1, 1, 1, 1, 1), new Array(0, 125, 130, 150, 255)));
            this.a.push(new GradientInfo(new Array(3823477, 0), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(2689625, 16743424), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(16777215, 9744739, 922630, 0), new Array(1, 1, 1, 1), new Array(0, 36, 180, 255)));
            this.a.push(new GradientInfo(new Array(16763997, 12451677, 65485, 3657471, 14704383, 16737999, 16735840, 16743168), new Array(1, 1, 1, 1, 1, 1, 1, 1), new Array(0, 35, 70, 105, 140, 175, 220, 255)));
            this.a.push(new GradientInfo(new Array(16773338, 25498, 16773338, 25498, 13247835, 16773338, 25498, 13247835, 16773338), new Array(1, 1, 1, 1, 1, 1, 1, 1, 1), new Array(0, 35, 70, 105, 140, 165, 210, 235, 255)));
            this.a.push(new GradientInfo(new Array(655538, 16711680, 16776192), new Array(1, 1, 1), new Array(0, 128, 255)));
            this.a.push(new GradientInfo(new Array(9506575, 12787487), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(8229135, 11453215), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(1858181, 3183559), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(8723536, 13054075), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(8743708, 13083184), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(11579568, 16777215), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(16350011, 16350011, 16362886, 16367263), new Array(1, 1, 1, 1), new Array(0, 165, 166, 255)));
            this.a.push(new GradientInfo(new Array(13695549, 13695549, 14744199, 16777215), new Array(1, 1, 1, 1), new Array(0, 165, 166, 255)));
            this.a.push(new GradientInfo(new Array(2267130, 2267130, 7191034, 11918330), new Array(1, 1, 1, 1), new Array(0, 165, 166, 255)));
            this.a.push(new GradientInfo(new Array(16392688, 16392688, 16412147, 16430582), new Array(1, 1, 1, 1), new Array(0, 165, 166, 255)));
            this.a.push(new GradientInfo(new Array(16434209, 16434209, 16439149, 16443573), new Array(1, 1, 1, 1), new Array(0, 165, 166, 255)));
            this.a.push(new GradientInfo(new Array(12369084, 12369084, 13750737, 16448250), new Array(1, 1, 1, 1), new Array(0, 165, 166, 255)));
            this.a.push(new GradientInfo(new Array(10292233, 16222214, 16238084), new Array(1, 1, 1), new Array(0, 128, 255)));
            this.a.push(new GradientInfo(new Array(1458006, 15923967), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(547436, 12056826), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(5334127, 15398911), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(298941, 16777215), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(5334127, 12311533), new Array(1, 1), new Array(0, 255)));
            this.a.push(new GradientInfo(new Array(16718994, 16727732, 16736969, 16751595, 16757742), new Array(1, 1, 1, 1, 1), new Array(0, 64, 128, 192, 255)));
            this.a.push(new GradientInfo(new Array(16718994, 16758246, 16736969, 16758246, 16718994), new Array(1, 1, 1, 1, 1), new Array(0, 64, 128, 192, 255)));
            this.a.push(new GradientInfo(new Array(16756723, 16765685, 16768508, 16772859), new Array(1, 1, 1, 1), new Array(0, 130, 135, 242)));
            this.a.push(new GradientInfo(new Array(16740008, 16742032, 16767683), new Array(1, 1, 1), new Array(0, 130, 255)));
            this.a.push(new GradientInfo(new Array(16756953, 16775417, 16756953, 16768254, 16567012, 16771316, 16763621, 16777215), new Array(1, 1, 1, 1, 1, 1, 1, 1), new Array(0, 17, 36, 61, 96, 146, 181, 255)));
            this.a.push(new GradientInfo(new Array(16734643, 16748500, 16750063), new Array(1, 1, 1), new Array(114, 127, 139)));
            return;
        }// end function

        public function RenderGradients() : void
        {
            var _loc_4:GradientInfo = null;
            while (this.holder.numChildren > 0)
            {
                
                this.holder.removeChildAt(0);
            }
            var _loc_1:int = 5;
            var _loc_2:int = 5;
            var _loc_3:int = 0;
            while (_loc_3 < this.a.length)
            {
                
                if (_loc_3 > 0 && _loc_3 % 8 == 0)
                {
                    _loc_2 = _loc_2 + 40;
                    _loc_1 = 5;
                }
                _loc_4 = this.a[_loc_3] as GradientInfo;
                _loc_4.addEventListener(MouseEvent.MOUSE_DOWN, this.GradientMouseDown);
                _loc_4.x = _loc_1;
                _loc_4.y = _loc_2;
                _loc_4.nr = _loc_3;
                this.holder.addChild(_loc_4);
                _loc_1 = _loc_1 + 41;
                _loc_3++;
            }
            this.scroller.SetContentHeight(_loc_2 + 41);
            return;
        }// end function

        private function HolderMouseOver(event:MouseEvent) : void
        {
            ed.cursor.Set(ToolType.Click);
            return;
        }// end function

        private function HolderMouseOut(event:MouseEvent) : void
        {
            ed.cursor.Set(ToolType.None);
            return;
        }// end function

        private function GradientMouseDown(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as GradientInfo;
            this.gradienteditor.colors = U.Clone(_loc_2.colors) as Array;
            this.gradienteditor.alphas = U.Clone(_loc_2.alphas) as Array;
            this.gradienteditor.ratios = U.Clone(_loc_2.ratios) as Array;
            this.gradienteditor.SetGradient();
            return;
        }// end function

    }
}
