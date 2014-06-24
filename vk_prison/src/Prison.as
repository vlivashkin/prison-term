package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	
	import vk.APIConnection;
	import vk.events.*;
	import vk.ui.VKButton;

	[SWF (width=807, height=730, backgroundColor=0xF7F7F7)]
	public class Prison extends Sprite
	{
		[Embed(source = '../resources/background.jpg')]
		private var bkgClass:Class;
		private var bkg:Bitmap = new bkgClass();
		
		public function Prison()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e: Event = null): void {
			if (e) {
				removeEventListener(e.type, init);
			}

			addChild(bkg);

			var btn1:PrisonButton = new PrisonButton();
			btn1.x = 100;
			btn1.y = 300;
			btn1.width = 600;
			btn1.height = 70;
			addChild(btn1);
			
			var btn2:PrisonButton = new PrisonButton();
			btn2.x = 100;
			btn2.y = 400;
			btn2.width = 600;
			btn2.height = 70;
			addChild(btn2);
			
			var btn3:PrisonButton = new PrisonButton();
			btn3.x = 100;
			btn3.y = 500;
			btn3.width = 600;
			btn3.height = 70;
			addChild(btn3);
			
			var btn4:PrisonButton = new PrisonButton();
			btn4.x = 100;
			btn4.y = 600;
			btn4.width = 600;
			btn4.height = 70;
			addChild(btn4);
		}
		
	}
	
	
}