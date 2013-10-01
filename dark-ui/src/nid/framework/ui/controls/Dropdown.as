package nid.framework.ui.controls
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	import nid.framework.events.SelectEvent;
	import nid.framework.ui.UIState;

	public class Dropdown extends Sprite
	{
		internal var click:IconButton;
		internal var holder:Sprite;
		internal var content:Sprite;
		internal var sb:Scrollbar;
		internal var tb:TextInput;
		internal var cwidth:int;
		internal var active:Boolean = false;
		internal var item:SelectItem;
		internal var markedIndex:int = 0;
		internal var disable:Sprite;
		public  var length:int = 0;

		[Embed(source='../../theme/dark/assets/dropdown/DropdownOver.png')]
		private var	DropdownOver:Class;
		
		public function get selectedItem():SelectItem { return item; }
		
		public function Dropdown(_width:int, _height:int)
		{
			cwidth = _width;
			holder = new Sprite();
			content = new Sprite();

			click = new IconButton("",Bitmap(new DropdownOver()).bitmapData);
			click.addEventListener(MouseEvent.CLICK,  Open, false, 0, true);
			click.x = cwidth -  click.width;
			addChild( click);

			tb = new TextInput(cwidth -  click.width);
			tb.addEventListener(MouseEvent.CLICK,  Open, false, 0, true);
			tb.t.multiline = false;
			tb.t.selectable = false;
			tb.t.type = TextFieldType.DYNAMIC;
			addChild( tb);
			return;
		}

		private function MarkIndex(param1:int) : SelectItem
		{
			if ( item != null)
			{
				item.Select(false);
			}
			var _loc_2:* = param1 < 0 ? (0) : (param1 >=  length ? (( length - 1)) : (param1));
			markedIndex = _loc_2;
			item =  content.getChildAt(_loc_2) as SelectItem;
			item.Select();
			return  item;
		}

		public function Disable(param1:Boolean = true) : void
		{
			if ( disable == null)
			{
				disable = new Sprite();
				disable.visible = false;
				disable.alpha = 0.3;
				disable.graphics.beginFill(9474192);
				disable.graphics.drawRect(0, 0, 10, 10);
				disable.graphics.endFill();
				disable.height =  tb.height;
				disable.width =  tb.width +  click.width;
				addChild( disable);
			}
			disable.visible = param1;
			return;
		}

		public function Set(param1:String) : void
		{
			if ( item != null)
			{
				item.Select(false);
			}
			var _loc_2:int = 0;
			while (_loc_2 <  content.numChildren)
			{

				item =  content.getChildAt(_loc_2) as SelectItem;
				if ( item.name == param1)
				{
					break;
				}
				_loc_2++;
			}
			tb.text =  item.text;
			item.Select();
			markedIndex =  item.index;
			return;
		}
		
		public function set dataProvider(data:Array):void
		{
			Clear();
			for (var i:int = 0; i < data.length; i++)
			{
				AddItem(data[i].label, data[i].name, data[i].selected?true:false,data[i]);
			}
			Bind();
		}
		public function AddItem(_label:String, _name:String, _selected:Boolean = false,_data:Object=null) : void
		{
			var _item:SelectItem = new SelectItem(_label, _name,  cwidth, _data);
			_item.addEventListener(MouseEvent.CLICK,  ItemClick, false, 1, true);
			_item.addEventListener(MouseEvent.MOUSE_OVER,  ItemOver, false, 1, true);
			_item.y = Math.round(content.height);
			_item.x = 1;
			content.addChild(_item);
			if (_selected)
			{
				if ( item != null)
				{
					item.Select(false);
				}
				item = _item;
				_item.Select();
				tb.text = _item.text;
				markedIndex =  length;
			}
			_item.index =  length;
			length++;
			return;
		}
		
		public function Clear() : void
		{
			while ( content.numChildren > 0)
			{

				content.removeChildAt(0);
			}
			Bind();
			return;
		}

		public function Bind() : void
		{
			DrawHolder();
			return;
		}

		private function ItemClick(event:MouseEvent) : void
		{
			if ( item != null)
			{
				item.Select(false);
			}
			item = event.currentTarget as SelectItem;
			item.Select();
			HideContent();
			tb.text =  item.text;
			markedIndex =  item.index;
			dispatchEvent(new SelectEvent(SelectEvent.COMMAND,  item.name));
			dispatchEvent(new Event(Event.CHANGE));
			return;
		}

		private function ItemOver(event:Event) : void
		{
			dispatchEvent(new SelectEvent(SelectEvent.HOVER, (event.currentTarget as SelectItem).name));
			return;
		}

		private function DrawHolder() : void
		{
			var cheight:int = content.height + 1 > 180 ? 180:content.height + 1;
			holder.graphics.clear();
			holder.graphics.beginFill(9474192);
			holder.graphics.drawRect(0, 0,  cwidth, cheight);
			holder.graphics.beginFill(16777215);
			holder.graphics.drawRect(1, 1,  cwidth - 2, cheight - 2);
			holder.graphics.endFill();
			holder.y = 19;
			holder.x = 0;
			holder.addChild( content);
			if ( content.height > 180)
			{
				cheight =  content.height;
				sb = new Scrollbar( content, new Rectangle(0, 0,  cwidth, 178));
				sb.y = 1;
				sb.x =  cwidth - 17;
				sb.SetContentHeight(cheight);
				holder.addChild(sb);
			}
			return;
		}

		private function HideContent() : void
		{
			active = false;
			UIState.TextInteraction = false;
			stage.removeEventListener(MouseEvent.CLICK,  ClickOutside, true);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,  KBKeyDown, true);
			removeChild( holder);
			dispatchEvent(new SelectEvent(SelectEvent.CLOSE, ""));
			return;
		}

		private function KBKeyDown(event:KeyboardEvent) : void
		{
			var _loc_2:SelectItem = null;
			event.stopImmediatePropagation();
			if (event.keyCode === 38)
			{
				_loc_2 =  MarkIndex(( markedIndex - 1));
				sb.ScrollTo(_loc_2.y);
				dispatchEvent(new SelectEvent(SelectEvent.HOVER, _loc_2.name));
			}
			else if (event.keyCode == 40)
			{
				_loc_2 =  MarkIndex(( markedIndex + 1));
				sb.ScrollTo(_loc_2.y + _loc_2.height);
				dispatchEvent(new SelectEvent(SelectEvent.HOVER, _loc_2.name));
			}
			else if (event.keyCode == 13 &&  active)
			{
				if ( item != null)
				{
					item.Select(false);
				}
				item =  MarkIndex( markedIndex);
				HideContent();
				tb.text =  item.text;
				markedIndex =  item.index;
				dispatchEvent(new SelectEvent(SelectEvent.COMMAND,  item.name));
				dispatchEvent(new Event(Event.CHANGE));
			}
			return;
		}

		private function Open(event:Event) : void
		{
			active = Boolean(! active);
			if ( active)
			{
				//stage.focus = this;
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
				addChild( holder);
				UIState.TextInteraction = true;
				stage.addEventListener(MouseEvent.CLICK,  ClickOutside, true);
				stage.addEventListener(KeyboardEvent.KEY_DOWN,  KBKeyDown, true, 0, true);
			}
			else
			{
				HideContent();
			}
			return;
		}

		private function ClickOutside(event:MouseEvent) : void
		{
			if (! hitTestPoint(stage.mouseX, stage.mouseY))
			{
				HideContent();
			}
			return;
		}

		public function get value() : String
		{
			return  item != null ? ( item.name) : ("");
		}

	}
}
