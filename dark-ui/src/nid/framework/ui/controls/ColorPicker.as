package nid.framework.ui.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ColorPicker extends Dialog
    {
        var map:Sprite;
        var spectrum:Sprite;
        var marker:Sprite;
        var drag:Sprite;
        var cmap:BitmapData;
        var cspectrum:BitmapData;
        var ccolor:BitmapData;
        var color:uint;
        var org:uint;
        var pad:ColorPad;
        var hval:NumberInput;
        var sval:NumberInput;
        var lval:NumberInput;
        var rval:NumberInput;
        var gval:NumberInput;
        var bval:NumberInput;
        var hex:TextInput;
        var red:uint;
        var green:uint;
        var blue:uint;
        var hue:Number;
        var saturation:Number;
        var brightness:Number;
        var snapshot:BitmapData;
        var realtime:Boolean;
        var rt:String;
        var gt:String;
        var bt:String;
        var lmx:int = 0;
        var lmy:int = 0;
        var lsy:int = 0;
        var a:Number;
        var r:Number;
        var g:Number;
        var b:Number;
        var hf:Number;
        var f:Number;
        var pv:Number;
        var qv:Number;
        var tv:Number;

        public function ColorPicker(param1:Editor, param2:ColorPad, param3:Boolean = false)
        {
            this.SetupSnapshot(param1);
            super(param1, "rm_colorpicker", 396, 232, false);
            this.pad = param2;
            this.color = param2.color;
            this.org = param2.color;
            this.realtime = param3;
            this.AddMap();
            this.AddSpectrum();
            this.AddColorOutput();
            this.AddButtonsAndInputs();
            this.CalculateColors();
            this.SetMarkers();
            this.SetInputs();
            this.SetActiveColor();
            this.RenderMap();
            return;
        }// end function

        override public function CloseClick(event:MouseEvent) : void
        {
            this.pad.Set(this.org);
            this.Cleanup();
            Close();
            return;
        }// end function

        override public function OKClick(event:MouseEvent) : void
        {
            this.pad.Set(this.color);
            this.Cleanup();
            Close();
            return;
        }// end function

        public function Cleanup() : void
        {
            ed.modal.removeEventListener(MouseEvent.ROLL_OVER, this.ShowPicker, false);
            ed.modal.removeEventListener(MouseEvent.ROLL_OUT, this.HidePicker, false);
            ed.modal.removeEventListener(MouseEvent.CLICK, this.PickerClick, false);
            return;
        }// end function

        private function SetupSnapshot(param1:Editor) : void
        {
            this.snapshot = new BitmapData(param1.stage.stageWidth < 3500 ? (param1.stage.stageWidth) : (3500), param1.stage.stageHeight < 3500 ? (param1.stage.stageHeight) : (3500), false);
            this.snapshot.draw(param1);
            param1.modal.addEventListener(MouseEvent.ROLL_OVER, this.ShowPicker, false, 0, true);
            param1.modal.addEventListener(MouseEvent.ROLL_OUT, this.HidePicker, false, 0, true);
            param1.modal.addEventListener(MouseEvent.CLICK, this.PickerClick, false, 0, true);
            return;
        }// end function

        private function ShowPicker(event:MouseEvent) : void
        {
            ed.cursor.Set(ToolType.Picker);
            return;
        }// end function

        private function HidePicker(event:MouseEvent) : void
        {
            ed.cursor.Set(ToolType.None);
            return;
        }// end function

        private function PickerClick(event:MouseEvent) : void
        {
            this.color = this.snapshot.getPixel32(stage.mouseX, stage.mouseY);
            this.CalculateColors();
            this.SetMarkers();
            this.SetInputs();
            this.SetActiveColor();
            this.RenderMap();
            return;
        }// end function

        private function AddMap() : void
        {
            this.map = new Sprite();
            this.map.x = 10;
            this.map.y = 25;
            this.map.graphics.beginFill(9474192);
            this.map.graphics.drawRect(0, 0, 196, 196);
            this.map.graphics.beginFill(16777215);
            this.map.graphics.drawRect(1, 1, 194, 194);
            this.map.graphics.endFill();
            var _loc_1:* = new Bitmap();
            this.cmap = new BitmapData(192, 192, false);
            _loc_1.bitmapData = this.cmap;
            var _loc_2:int = 2;
            _loc_1.y = 2;
            _loc_1.x = _loc_2;
            this.map.addChild(_loc_1);
            addChild(this.map);
            this.RenderMap();
            this.marker = new Sprite();
            this.marker.addChild(new Bitmap(new ColorMarker()));
            this.marker.x = 189;
            this.marker.y = -2;
            this.map.addChild(this.marker);
            this.map.addEventListener(MouseEvent.MOUSE_DOWN, this.MapMouseDown, false, 0, true);
            this.map.addEventListener(MouseEvent.MOUSE_UP, this.MapMouseUp, false, 0, true);
            return;
        }// end function

        private function AddSpectrum() : void
        {
            this.spectrum = new Sprite();
            this.spectrum.graphics.beginFill(9474192);
            this.spectrum.graphics.drawRect(0, 0, 23, 196);
            this.spectrum.graphics.beginFill(16777215);
            this.spectrum.graphics.drawRect(1, 1, 21, 194);
            this.spectrum.graphics.endFill();
            var _loc_1:* = new Bitmap();
            this.cspectrum = new BitmapData(19, 192, false);
            _loc_1.bitmapData = this.cspectrum;
            var _loc_2:int = 2;
            _loc_1.y = 2;
            _loc_1.x = _loc_2;
            this.spectrum.addChild(_loc_1);
            this.spectrum.x = 219;
            this.spectrum.y = 25;
            addChild(this.spectrum);
            this.RenderSpectrum();
            this.drag = new Sprite();
            this.drag.addChild(new Bitmap(new SpectrumDrag()));
            this.drag.x = -8;
            this.drag.y = -1;
            this.spectrum.addChild(this.drag);
            this.spectrum.addEventListener(MouseEvent.MOUSE_DOWN, this.SpectrumMouseDown, false, 0, true);
            this.spectrum.addEventListener(MouseEvent.MOUSE_UP, this.SpectrumMouseUp, false, 0, true);
            return;
        }// end function

        private function AddColorOutput() : void
        {
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(9474192);
            _loc_1.graphics.drawRect(0, 0, 50, 50);
            _loc_1.graphics.beginFill(16777215);
            _loc_1.graphics.drawRect(1, 1, 48, 48);
            _loc_1.graphics.endFill();
            var _loc_2:* = new Bitmap();
            this.ccolor = new BitmapData(46, 46, false);
            _loc_2.bitmapData = this.ccolor;
            var _loc_3:int = 2;
            _loc_2.y = 2;
            _loc_2.x = _loc_3;
            _loc_1.addChild(_loc_2);
            _loc_1.x = 255;
            _loc_1.y = 25;
            addChild(_loc_1);
            this.RenderColor();
            return;
        }// end function

        private function AddButtonsAndInputs() : void
        {
            var _loc_8:int = 315;
            cancel.x = 315;
            ok.x = _loc_8;
            ok.y = 25;
            cancel.y = 54;
            var _loc_1:* = new Literal("H:");
            _loc_1.x = 252;
            _loc_1.y = 90;
            addChild(_loc_1);
            var _loc_2:* = new Literal("S:");
            _loc_2.x = 252;
            _loc_2.y = 115;
            addChild(_loc_2);
            var _loc_3:* = new Literal("L:");
            _loc_3.x = 252;
            _loc_3.y = 140;
            addChild(_loc_3);
            this.hval = new NumberInput(30, 0, 0, 359);
            this.hval.x = 270;
            this.hval.y = 90;
            addChild(this.hval);
            this.sval = new NumberInput(30, 0, 0, 100);
            this.sval.x = 270;
            this.sval.y = 115;
            addChild(this.sval);
            this.lval = new NumberInput(30, 0, 0, 100);
            this.lval.x = 270;
            this.lval.y = 140;
            addChild(this.lval);
            var _loc_4:* = new Literal("R:");
            new Literal("R:").x = 317;
            _loc_4.y = 90;
            addChild(_loc_4);
            var _loc_5:* = new Literal("G:");
            new Literal("G:").x = 317;
            _loc_5.y = 115;
            addChild(_loc_5);
            var _loc_6:* = new Literal("B:");
            new Literal("B:").x = 317;
            _loc_6.y = 140;
            addChild(_loc_6);
            this.rval = new NumberInput(30, 0, 0, 255);
            this.rval.x = 335;
            this.rval.y = 90;
            addChild(this.rval);
            this.gval = new NumberInput(30, 0, 0, 255);
            this.gval.x = 335;
            this.gval.y = 115;
            addChild(this.gval);
            this.bval = new NumberInput(30, 0, 0, 255);
            this.bval.x = 335;
            this.bval.y = 140;
            addChild(this.bval);
            var _loc_7:* = new Literal("#");
            new Literal("#").x = 255;
            _loc_7.y = 180;
            addChild(_loc_7);
            this.hex = new TextInput(60, 6, "ffffff");
            this.hex.t.restrict = "0-9 a-f";
            this.hex.x = 270;
            this.hex.y = 180;
            addChild(this.hex);
            this.rval.t.addEventListener(KeyboardEvent.KEY_UP, this.RGBInputKeyUP);
            this.gval.t.addEventListener(KeyboardEvent.KEY_UP, this.RGBInputKeyUP);
            this.bval.t.addEventListener(KeyboardEvent.KEY_UP, this.RGBInputKeyUP);
            this.hval.t.addEventListener(KeyboardEvent.KEY_UP, this.HSLInputKeyUP);
            this.sval.t.addEventListener(KeyboardEvent.KEY_UP, this.HSLInputKeyUP);
            this.lval.t.addEventListener(KeyboardEvent.KEY_UP, this.HSLInputKeyUP);
            this.hex.t.addEventListener(KeyboardEvent.KEY_UP, this.HexInputKeyUP);
            return;
        }// end function

        private function HexInputKeyUP(event:KeyboardEvent) : void
        {
            this.red = 0;
            this.green = 0;
            this.blue = 0;
            if (this.hex.t.length > 5)
            {
                this.blue = int("0x" + this.hex.t.text.substr(4, 2));
            }
            if (this.hex.t.length > 3)
            {
                this.green = int("0x" + this.hex.t.text.substr(2, 2));
            }
            if (this.hex.t.length > 1)
            {
                this.red = int("0x" + this.hex.t.text.substr(0, 2));
            }
            this.color = 255 << 24 | this.red << 16 | this.green << 8 | this.blue;
            this.CalculateColors();
            this.SetActiveColor();
            this.SetMarkers();
            this.SetInputs(true);
            this.RenderMap();
            return;
        }// end function

        private function RGBInputKeyUP(event:KeyboardEvent) : void
        {
            this.color = 255 << 24 | this.rval.value << 16 | this.gval.value << 8 | this.bval.value;
            this.CalculateColors();
            this.SetActiveColor();
            this.SetMarkers();
            this.SetInputs();
            this.RenderMap();
            return;
        }// end function

        private function HSLInputKeyUP(event:KeyboardEvent) : void
        {
            this.color = this.GetRGB(this.hval.value, this.sval.value / 100, this.lval.value / 100);
            this.CalculateColors();
            this.SetActiveColor();
            this.SetMarkers();
            this.SetInputs();
            this.RenderMap();
            return;
        }// end function

        private function RenderColor() : void
        {
            this.ccolor.fillRect(new Rectangle(0, 0, 46, 46), this.color);
            return;
        }// end function

        private function SetMarkers() : void
        {
            this.drag.y = 191 - Math.round(191 * (this.hue / 360)) - 1;
            this.marker.x = Math.round(191 * (this.saturation / 100)) - 2;
            this.marker.y = 191 - Math.round(191 * (this.brightness / 100)) - 2;
            return;
        }// end function

        private function CalculateColors() : void
        {
            this.red = this.color >>> 16 & 255;
            this.green = this.color >>> 8 & 255;
            this.blue = this.color & 255;
            var _loc_1:* = Math.min(this.red, this.green, this.blue);
            var _loc_2:* = Math.max(this.red, this.green, this.blue);
            this.brightness = _loc_2 * 100 / 255;
            var _loc_3:* = _loc_2 - _loc_1;
            if (_loc_3)
            {
                this.saturation = 100 * (_loc_3 / _loc_2);
                if (this.red == _loc_2)
                {
                    this.hue = (this.green - this.blue) / _loc_3 * 60;
                }
                else if (this.green == _loc_2)
                {
                    this.hue = (2 + (this.blue - this.red) / _loc_3) * 60;
                }
                else
                {
                    this.hue = (4 + (this.red - this.green) / _loc_3) * 60;
                }
                if (this.hue > 360)
                {
                    this.hue = this.hue - 360;
                }
                else if (this.hue < 0)
                {
                    this.hue = this.hue + 360;
                }
            }
            else
            {
                var _loc_4:int = 0;
                this.saturation = 0;
                this.hue = _loc_4;
            }
            return;
        }// end function

        private function SetActiveColor() : void
        {
            this.ccolor.fillRect(new Rectangle(0, 0, 46, 23), this.color);
            if (this.realtime)
            {
                this.pad.Set(this.color);
            }
            return;
        }// end function

        private function SetInputs(param1:Boolean = false) : void
        {
            this.rval.value = this.red;
            this.gval.value = this.green;
            this.bval.value = this.blue;
            this.hval.value = Math.round(this.hue);
            this.sval.value = Math.round(this.saturation);
            this.lval.value = Math.round(this.brightness);
            if (!param1)
            {
                this.rt = this.red.toString(16);
                if (this.rt.length < 2)
                {
                    this.rt = "0" + this.rt;
                }
                this.gt = this.green.toString(16);
                if (this.gt.length < 2)
                {
                    this.gt = "0" + this.gt;
                }
                this.bt = this.blue.toString(16);
                if (this.bt.length < 2)
                {
                    this.bt = "0" + this.bt;
                }
                this.hex.text = this.rt + this.gt + this.bt;
            }
            return;
        }// end function

        private function RenderSpectrum() : void
        {
            var _loc_1:uint = 0;
            var _loc_3:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < 192)
            {
                
                _loc_1 = this.GetRGB((191 - _loc_2) / 191 * 359, 1, 1);
                _loc_3 = 0;
                while (_loc_3 < 19)
                {
                    
                    this.cspectrum.setPixel(_loc_3, _loc_2, _loc_1);
                    _loc_3++;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function RenderMap() : void
        {
            var _loc_2:int = 0;
            var _loc_1:int = 0;
            while (_loc_1 < 192)
            {
                
                _loc_2 = 0;
                while (_loc_2 < 192)
                {
                    
                    this.cmap.setPixel(_loc_2, _loc_1, this.GetRGB(this.hue, _loc_2 / 191, (191 - _loc_1) / 191));
                    _loc_2++;
                }
                _loc_1++;
            }
            return;
        }// end function

        private function MapMouseDown(event:MouseEvent) : void
        {
            this.marker.x = this.map.mouseX - 5;
            this.marker.y = this.map.mouseY - 4;
            this.marker.startDrag(false, new Rectangle(-2, -2, 191, 191));
            this.addEventListener(Event.ENTER_FRAME, this.MapMove, false, 1, true);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.MapMouseUp, true, 1, false);
            return;
        }// end function

        private function MapMouseUp(event:MouseEvent) : void
        {
            this.marker.stopDrag();
            this.removeEventListener(Event.ENTER_FRAME, this.MapMove, false);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.MapMouseUp, true);
            return;
        }// end function

        private function MapMove(event:Event) : void
        {
            if (this.lmx != this.marker.x || this.lmy != this.marker.y)
            {
                this.saturation = (this.marker.x + 2) / 191 * 100;
                this.brightness = 100 - (this.marker.y + 2) / 191 * 100;
                this.color = this.GetRGB(this.hue, this.saturation / 100, this.brightness / 100);
                this.red = this.color >>> 16 & 255;
                this.green = this.color >>> 8 & 255;
                this.blue = this.color & 255;
                this.SetActiveColor();
                this.SetInputs();
                this.lmx = this.marker.x;
                this.lmy = this.marker.y;
            }
            return;
        }// end function

        private function SpectrumMouseDown(event:MouseEvent) : void
        {
            this.drag.y = this.spectrum.mouseY - 3;
            this.drag.startDrag(false, new Rectangle(-8, -1, 0, 191));
            this.addEventListener(Event.ENTER_FRAME, this.SpectrumMove, false, 1, true);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.SpectrumMouseUp, true, 1, true);
            return;
        }// end function

        private function SpectrumMouseUp(event:MouseEvent) : void
        {
            this.drag.stopDrag();
            this.removeEventListener(Event.ENTER_FRAME, this.SpectrumMove, false);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.SpectrumMouseUp, true);
            return;
        }// end function

        private function SpectrumMove(event:Event) : void
        {
            if (this.lsy != this.drag.y)
            {
                this.hue = (191 - (this.drag.y + 1)) / 191 * 359;
                this.color = this.GetRGB(this.hue, this.saturation / 100, this.brightness / 100);
                this.red = this.color >>> 16 & 255;
                this.green = this.color >>> 8 & 255;
                this.blue = this.color & 255;
                this.SetActiveColor();
                this.RenderMap();
                this.SetInputs();
                this.lsy = this.drag.y;
            }
            return;
        }// end function

        private function GetRGB(param1:Number, param2:Number, param3:Number) : uint
        {
            if (param3 == 0)
            {
                this.r = 0;
                this.g = 0;
                this.b = 0;
            }
            else if (param2 == 0)
            {
                var _loc_4:* = param3;
                this.b = param3;
                var _loc_4:* = _loc_4;
                this.g = _loc_4;
                this.r = _loc_4;
            }
            else
            {
                this.hf = param1 / 60;
                this.f = this.hf - int(this.hf);
                this.pv = param3 * (1 - param2);
                this.qv = param3 * (1 - param2 * this.f);
                this.tv = param3 * (1 - param2 * (1 - this.f));
                switch(int(this.hf))
                {
                    case 0:
                    {
                        this.r = param3;
                        this.g = this.tv;
                        this.b = this.pv;
                        break;
                    }
                    case 1:
                    {
                        this.r = this.qv;
                        this.g = param3;
                        this.b = this.pv;
                        break;
                    }
                    case 2:
                    {
                        this.r = this.pv;
                        this.g = param3;
                        this.b = this.tv;
                        break;
                    }
                    case 3:
                    {
                        this.r = this.pv;
                        this.g = this.qv;
                        this.b = param3;
                        break;
                    }
                    case 4:
                    {
                        this.r = this.tv;
                        this.g = this.pv;
                        this.b = param3;
                        break;
                    }
                    case 5:
                    {
                        this.r = param3;
                        this.g = this.pv;
                        this.b = this.qv;
                        break;
                    }
                    case 6:
                    {
                        this.r = param3;
                        this.g = this.tv;
                        this.b = this.pv;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this.r = this.r * 255;
            this.g = this.g * 255;
            this.b = this.b * 255;
            return this.a << 24 | this.r << 16 | this.g << 8 | this.b;
        }// end function

    }
}
