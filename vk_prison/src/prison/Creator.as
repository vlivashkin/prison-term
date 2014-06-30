package prison
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	internal class Creator
	{
		[Embed(systemFont="Calibri", 
		    fontName = "CalibriCustom", 
		    mimeType = "application/x-font", 
		    fontWeight="normal", 
		    fontStyle="normal",
		    advancedAntiAliasing="true", 
		    embedAsCFF="false")]
		private var CalibriCustom:Class;
		
		public function Creator()
		{
		}
		
		public function createQNumField():TextField
		{
			var qBar:TextField = new TextField();
			qBar.x = 243;
			qBar.y = 2;
			qBar.width = 323;
			qBar.height = 23;
			qBar.autoSize = TextFieldAutoSize.CENTER;
			qBar.textColor = 0xFFFFFF;
			
			return qBar;
		}
		
		public function createQuestionField():TextField
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 21;
			myFormat.align = TextFormatAlign.CENTER;
			myFormat.font = "CalibriCustom";
			
			
			var qBar:TextField = new TextField();
			qBar.x = 80;
			qBar.y = 67 + 69 - qBar.height/2 - 1;
			qBar.width = 647;
			qBar.autoSize = TextFieldAutoSize.CENTER;
			qBar.defaultTextFormat = myFormat;
			qBar.textColor = 0xFFFFFF;
			qBar.embedFonts = true;
			
			return qBar;
		}
		
		public function createFinalTextField():TextField
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 60;
			myFormat.align = TextFormatAlign.CENTER;
			myFormat.font = "CalibriCustom";
			myFormat.bold = true;
			
			var qBar:TextField = new TextField();
			qBar.x = 80;
			qBar.y = 180;
			qBar.width = 647;
			qBar.autoSize = TextFieldAutoSize.CENTER;
			qBar.defaultTextFormat = myFormat;
			qBar.textColor = 0xFFFFFF;
			qBar.embedFonts = true;
			
			return qBar;
		}
		
		public function createResultTextField():TextField
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 60;
			myFormat.align = TextFormatAlign.LEFT;
			myFormat.font = "CalibriCustom";
			myFormat.bold = true;
			
			var qBar:TextField = new TextField();
			qBar.x = 30;
			qBar.y = 10;
			qBar.width = 647;
			qBar.autoSize = TextFieldAutoSize.LEFT;
			qBar.defaultTextFormat = myFormat;
			qBar.textColor = 0xFFFFFF;
			qBar.embedFonts = true;
			
			return qBar;
		}
		
		public function createResultField():TextField
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 90;
			myFormat.align = TextFormatAlign.LEFT;
			myFormat.font = "CalibriCustom";
			myFormat.bold = true;
			
			var qBar:TextField = new TextField();
			qBar.x = 30;
			qBar.y = 190;
			qBar.width = 647;
			qBar.autoSize = TextFieldAutoSize.LEFT;
			qBar.defaultTextFormat = myFormat;
			qBar.textColor = 0xFFFFFF;
			qBar.embedFonts = true;
			
			return qBar;
		}
		
		public function addButton(x:uint, y:uint, width:uint, height:uint):SimpleButton
		{
			var btn:SimpleButton = new SimpleButton();
			btn.upState = createRect(width, height, 0x999999, 17, 0);
			btn.overState = createRect(width, height, 0xAAAAAA, 17, 0);
			btn.downState = createRect(width, height, 0x555555, 17, 0);
			btn.hitTestState = createRect(width, height, 0x666666, 17, 0);
			btn.x = x;
			btn.y = y;
			
			return btn;
		}
		
		public function addFinalButton(x:uint, y:uint, width:uint, height:uint):SimpleButton
		{
			var btn:SimpleButton = new SimpleButton();
			btn.upState = createRect(width, height, 0x999999, 24, -4);
			btn.overState = createRect(width, height, 0xAAAAAA, 24, -4);
			btn.downState = createRect(width, height, 0x555555, 24, -4);
			btn.hitTestState = createRect(width, height, 0x666666, 24, -4);
			btn.x = x;
			btn.y = y;
			
			return btn;
		}
		
		private function createRect(width:uint, height:uint, color:uint, textSize:uint, y:int):Sprite
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = textSize;
			myFormat.font = "CalibriCustom";
			
			var textField:TextField = new TextField();
			textField.name = "textField";
			textField.mouseEnabled = false;
			textField.width = width;
			textField.height = height;
			textField.autoSize = TextFieldAutoSize.CENTER;
			textField.y = height/2 - 12 + y;
			textField.defaultTextFormat = myFormat;
			textField.embedFonts = true;
			
			var rectangleShape:Shape = new Shape();
			rectangleShape.graphics.lineStyle(2);
			rectangleShape.graphics.beginFill(color);
			rectangleShape.graphics.drawRect(0, 0, width, height);
			rectangleShape.graphics.endFill();
			rectangleShape.alpha = .95;
			
			var btnSprite:Sprite = new Sprite();
			btnSprite.name = "btnSprite";
			btnSprite.addChild(rectangleShape);
			btnSprite.addChild(textField);
			
			return btnSprite;
		}	
	}
}