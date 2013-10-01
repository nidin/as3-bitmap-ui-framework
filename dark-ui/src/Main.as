package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import nid.framework.events.SliderEvent;
	import nid.framework.theme.dark.Box;
	import nid.framework.ui.controls.Button;
	import nid.framework.ui.controls.ColorPad;
	import nid.framework.ui.controls.Dropdown;
	import nid.framework.ui.controls.Dropslider;
	import nid.framework.ui.controls.TextInput;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class Main extends Sprite 
	{
		private var slider:Dropslider;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var box:Box = new Box("Charector", 220, 177);
			box.x = 150;
			box.y = 50;
			addChild(box);
			
			var text:TextInput = new TextInput(200, 150, "Enter Text Here", 60);
			text.x = 10;
			text.y = 50;
			box.addChild(text);
			
			var drop:Dropdown = new Dropdown(100, 50);
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.AddItem("test", "test");
			drop.Bind();
			drop.x = 250;
			drop.y = 250;
			addChild(drop);
			//box.Resize(500, 500);
			
			slider = new Dropslider(60, 50, 250, 100);
			slider.addEventListener(SliderEvent.DRAG, track);
			slider.x = 150;
			slider.y = 300;
			addChild(slider);
			
			var color:ColorPad = new ColorPad(60);
			color.x = 250;
			color.y = 300;
			addChild(color);
			
			var btn:Button = new Button("button",60);
			btn.x = 300;
			btn.y = 300;
			addChild(btn);
		}
		
		private function track(e:SliderEvent):void 
		{
			trace(slider.value);
		}
		
	}
	
}