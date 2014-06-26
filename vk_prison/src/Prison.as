package
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	
	import vk.APIConnection;
	import vk.events.*;
	import vk.ui.VKButton;

	[SWF (width=807, height=454, backgroundColor=0xF7F7F7)]
	public class Prison extends Sprite
	{
		[Embed(source = '../resources/background.jpg')]
		private var bkgClass:Class;
		private var bkg:Bitmap = new bkgClass();
		
		private var qNumField:TextField = createQNumField();
		private var questionField:TextField = createQuestionField();
		
		private var btn:Array = new Array(
			addButton(243, 159, 323, 47),
			addButton(243, 223, 323, 47),
			addButton(243, 287, 323, 47),
			addButton(243, 350, 323, 47)
		);
		
		private var questions:Array = new Array();
		private var currentQuestion:uint = 0;
		private var score:uint = 0;
		
		public function Prison()
		{
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e: Event = null): void {
			if (e) {
				removeEventListener(e.type, init);
			}

			addChild(bkg);
			addChild(qNumField);
			addChild(questionField);
			
			for (var i:uint = 0; i < btn.length; i++) {
				addChild(btn[i]);
			}
			
			btn[0].addEventListener(MouseEvent.CLICK, btn0reaction);
			btn[1].addEventListener(MouseEvent.CLICK, btn1reaction);
			btn[2].addEventListener(MouseEvent.CLICK, btn2reaction);
			btn[3].addEventListener(MouseEvent.CLICK, btn3reaction);
			
			function btn0reaction (e:MouseEvent):void
			{
				score += questions[currentQuestion].response[0].score;
				currentQuestion++;
				nextQuestion();
			}
			
			function btn1reaction (e:MouseEvent):void
			{
				score += questions[currentQuestion].response[1].score;
				currentQuestion++;
				nextQuestion();
			}
			
			function btn2reaction (e:MouseEvent):void
			{
				score += questions[currentQuestion].response[2].score;
				currentQuestion++;
				nextQuestion();
			}
			
			function btn3reaction (e:MouseEvent):void
			{
				score += questions[currentQuestion].response[3].score;
				currentQuestion++;
				nextQuestion();
			}
			
			addQuestion("Смотрели ли вы фильм Олигарх?", "Ага", 4, "Нет", 3);
			addQuestion("Как часто вы носите кепочку?", "Не снимаю", 4, "Сплю с ней", 3, "Люблю ее", 2, "Нет, братья. Я не такой", 1);
			
			nextQuestion();
			
		}
		
		private function createQNumField():TextField
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
		
		private function createQuestionField():TextField
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 20;
			
			var qBar:TextField = new TextField();
			qBar.x = 80;
			qBar.y = 67 + 69 - qBar.height/2;
			qBar.width = 647;
			qBar.autoSize = TextFieldAutoSize.CENTER;
			qBar.defaultTextFormat = myFormat;
			qBar.textColor = 0x000000;
			
			return qBar;
		}
		
		private function addButton(x:uint, y:uint, width:uint, height:uint):SimpleButton
		{
			var btn:SimpleButton = new SimpleButton();
			btn.upState = createRect(width, height, 0x888888);
			btn.overState = createRect(width, height, 0xAAAAAA);
			btn.downState = createRect(width, height, 0x555555);
			btn.hitTestState = createRect(width, height, 0x666666);
			btn.x = x;
			btn.y = y;
			
			return btn;
		}
		
		private function createRect(width:uint, height:uint, color:uint):Sprite
		{
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 17;
			
			var textField:TextField = new TextField();
			textField.name = "textField";
			textField.mouseEnabled = false;
			textField.width = width;
			textField.height = height;
			textField.autoSize = TextFieldAutoSize.CENTER;
			textField.y = height/2 - 11;
			textField.defaultTextFormat = myFormat;
			
			var rectangleShape:Shape = new Shape();
			rectangleShape.graphics.lineStyle(2);
			rectangleShape.graphics.beginFill(color);
			rectangleShape.graphics.drawRect(0, 0, width, height);
			rectangleShape.graphics.endFill();
			
			var btnSprite:Sprite = new Sprite();
			btnSprite.name = "btnSprite";
			btnSprite.addChild(rectangleShape);
			btnSprite.addChild(textField);
			
			return btnSprite;
		}
		
		private function addQuestion(question:String, r1:String, r1s:uint, r2:String, r2s:uint,
									 r3:String = null, r3s:uint = 0, r4:String = null, r4s:uint = 0):void
		{
			var q:Object = new Object();
			q.question = question;
			var response:Array = new Array();
			response.push(doResp(r1, r1s));
			response.push(doResp(r2, r2s));
			response.push(doResp(r3, r3s));
			response.push(doResp(r4, r4s));
			q.response = response;
			questions.push(q);
		}
		
		private function doResp(r:String, rs:uint):Object
		{
			var resp:Object = new Object();
			resp.value = r;
			resp.score = rs;
			
			return resp;
		}
		
		private function nextQuestion():void
		{
			if (currentQuestion < questions.length) {
				qNumField.text = "Вопрос " + (currentQuestion + 1) + " из " + questions.length + ".";
				
				questionField.text = questions[currentQuestion].question;
				
				for (var i:uint = 0; i < btn.length; i++) {
					var text:String = questions[currentQuestion].response[i].value;
					if (text != null) {
						updateLabel(i, text);
						btn[i].visible = true;
					} else {
						btn[i].visible = false;
					}
				}
			} else {
				qNumField.visible = false;
				questionField.text = "Ваш психологический срок: " + score + " лет.";
				for (var i:uint = 0; i < btn.length; i++) {
					btn[i].visible = false;
				}
			}
		}
		
		private function updateLabel(btnIndex:uint, text:String):void
		{
			var sbs:DisplayObjectContainer;
			
			sbs = DisplayObjectContainer(btn[btnIndex].upState);
			TextField(sbs.getChildByName("textField")).text = text;
			sbs = DisplayObjectContainer(btn[btnIndex].overState);
			TextField(sbs.getChildByName("textField")).text = text;
			sbs = DisplayObjectContainer(btn[btnIndex].downState);
			TextField(sbs.getChildByName("textField")).text = text;
			sbs = DisplayObjectContainer(btn[btnIndex].hitTestState);
			TextField(sbs.getChildByName("textField")).text = text;
		}
	}
}