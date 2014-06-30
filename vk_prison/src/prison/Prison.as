package prison
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.H264Level;
	import flash.text.*;
	
	import vk.APIConnection;
	import vk.events.*;

	[SWF (width=807, height=454, backgroundColor=0xF7F7F7)]
	public class Prison extends Sprite
	{
		private var questions:Array = new Array();
		private var currentQuestion:uint = 0;
		private var score:uint = 0;
		
		// question screen
		[Embed(source = '../img/bkg.jpg')]
		private var bkgClass:Class;

		private var bkg:Bitmap;
		private var qNumField:TextField;
		private var questionField:TextField;
		private var btn:Array = new Array();
		
		// final screen
		[Embed(source = '../img/final_bkg.jpg')]
		private var finalBkgClass:Class;
		
		private var finalBkg:Bitmap;
		private var finalTextField:TextField;
		private var resBtn:SimpleButton;

		// result screen
		private var resultTextField:TextField;
		private var resultField:TextField;
		
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
			
			initQuestionScreen();
			
			addQuestion("Авто какой марки вы предпочитаете?", "Mercedes", 1, "BMW", 3, "Lexus", 2, "Ни одну из перечисленных", 0);
			addQuestion("Сколько раз за свою жизнь вы были на стрелках?", "1-3 раза", 1, "3-5 раз", 2, "более 5 раз", 3, "Ни разу", 0);
			addQuestion("Какой из фильмов вы бы посмотрели в первую очередь?", "Сериал Бригада", 2, "Брат/Брат2", 1, "Бумер", 3, "Ни один из перечисленных", 0);
			addQuestion("Какого из исполнителей/групп вы уважаете больше, чем остальных?", "Словетский/Константа", 2, "Каспийский груз", 3, "Гармора", 1, "Ни один из перечисленных", 0);
			addQuestion("Занимаетесь ли вы боевыми искусствами?", "Нет, но занимался раньше", 2, "Да", 3, "Нет, но планирую в будущем", 1, "Нет и не планирую в будущем", 0);
			addQuestion("Считаете ли вы себя лидером в коллективе?", "Да", 2, "Трудно ответить", 1, "Нет", 0);
			addQuestion("Имеется ли у вас дома бейсбольная бита?", "Да, но она для занятий бейсболом", 1, "Нет, но планирую приобрести", 2, "Нет, но была раньше", 3, "Нет, т.к. в этом нет необходимости", 0);
			addQuestion("Обучены ли вы стрельбе из автоматичесокго оружия?", "Да, остались навыки владения оружием", 3, "Проходил обучение, но навыков не осталось", 1, "Нет, но планирую пройти обучение", 2, "Нет, обучение проходить НЕ планирую", 0);
			addQuestion("Согласны ли вы с утверждением \"незаменимых нет\"?", "Да", 2, " Нет", 0, "Трудно ответить", 1);
			addQuestion("Готовы ли вы повести за собой людей, если ситуация того требует?", "Да", 2, "Нет", 0, "Трудно ответить", 0);
			
			showNextQuestion();
			
		}
		
		private function initQuestionScreen():void
		{
			var creator:Creator = new Creator();
			
			bkg = new bkgClass();
			addChild(bkg);
			
			qNumField = creator.createQNumField();
			addChild(qNumField);
			
			questionField = creator.createQuestionField();
			addChild(questionField);
			
			btn.push(
				creator.addButton(237, 159, 332, 47),
				creator.addButton(237, 223, 332, 47),
				creator.addButton(237, 287, 332, 47),
				creator.addButton(237, 350, 332, 47)
			);
			
			for (var i:uint = 0; i < btn.length; i++) {
				addChild(btn[i]);
			}
			
			btn[0].addEventListener(MouseEvent.CLICK, function(e:Event):void{btnReaction(0)});
			btn[1].addEventListener(MouseEvent.CLICK, function(e:Event):void{btnReaction(1)});
			btn[2].addEventListener(MouseEvent.CLICK, function(e:Event):void{btnReaction(2)});
			btn[3].addEventListener(MouseEvent.CLICK, function(e:Event):void{btnReaction(3)});
		}
		
		private function btnReaction(num:uint):void
		{
			score += questions[currentQuestion].response[num].score;
			currentQuestion++;
			showNextQuestion();
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
			
			function doResp(r:String, rs:uint):Object
			{
				var resp:Object = new Object();
				resp.value = r;
				resp.score = rs;
				
				return resp;
			}
		}
		
		private function showNextQuestion():void
		{
			if (currentQuestion < questions.length) {
				qNumField.text = "Вопрос " + (currentQuestion + 1) + " из " + questions.length + ".";
				
				questionField.text = questions[currentQuestion].question;
				
				for (var i:uint = 0; i < btn.length; i++) {
					var text:String = questions[currentQuestion].response[i].value;
					if (text != null) {
						updateLabel(btn[i], text);
						btn[i].visible = true;
					} else {
						btn[i].visible = false;
					}
				}
			} else {
				showFinalScreen();
			}
		}
		
		private function showFinalScreen():void {
			bkg.visible = false;
			qNumField.visible = false;
			questionField.visible = false;
			for (var i:uint = 0; i < btn.length; i++) {
				btn[i].visible = false;
			}
			
			finalBkg = new finalBkgClass();
			addChild(finalBkg);
			
			var creator:Creator = new Creator();
			
			finalTextField = creator.createFinalTextField();
			finalTextField.text = "Тест окончен.";
			addChild(finalTextField);
			
			resBtn = creator.addFinalButton(287, 267, 232, 47);
			updateLabel(resBtn, "Узнать результат");
			addChild(resBtn);
			
			resBtn.addEventListener(MouseEvent.CLICK, function(e:Event):void{showResultScreen()});
		}
		
		private function showResultScreen():void {
			finalTextField.visible = false;
			resBtn.visible = false;
			
			var creator:Creator = new Creator();
			var helper:Helper = new Helper();
			
			resultTextField = creator.createResultTextField();
			resultTextField.text = "Мой психологический\nтюремный срок:";
			addChild(resultTextField);
			
			resultField = creator.createResultField();
			resultField.text = score + " " + helper.getUnit(score);
			addChild(resultField);
			
			var flashVars: Object = stage.loaderInfo.parameters as Object;
			var VK: APIConnection = new APIConnection(flashVars);
			VK.api('wall.post', {message: "Мой психологический тюремный срок: " + score + " " + helper.getUnit(score) + "\n vk.com/app4428337_41624918"}, null, null);
			
			var wallPost:WallPost = new WallPost();
			wallPost.createSnapshot(stage);
		}
		
		private function updateLabel(sBtn:SimpleButton, text:String):void
		{
			var sbs:DisplayObjectContainer;
			
			sbs = DisplayObjectContainer(sBtn.upState);
			TextField(sbs.getChildByName("textField")).text = text;
			sbs = DisplayObjectContainer(sBtn.overState);
			TextField(sbs.getChildByName("textField")).text = text;
			sbs = DisplayObjectContainer(sBtn.downState);
			TextField(sbs.getChildByName("textField")).text = text;
			sbs = DisplayObjectContainer(sBtn.hitTestState);
			TextField(sbs.getChildByName("textField")).text = text;
		}
	}
}