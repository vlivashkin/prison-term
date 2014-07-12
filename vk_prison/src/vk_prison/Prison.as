package vk_prison {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.*;
import flash.text.*;

import vk_prison.ui.Creator;
import vk_prison.ui.PrisonButton;
import vk_prison.utils.Helper;
import vk_prison.utils.VKRequest;

[SWF(width=807, height=454, backgroundColor=0xF7F7F7)]
public class Prison extends Sprite {
    private var questions:Array = [];

    // question screen
    private var currentQuestion:uint = 0;
    private var score:uint = 0;
    [Embed(source='../../img/bkg.jpg')]
    private var bkgClass:Class;
    private var bkg:Bitmap;
    private var qNumField:TextField;

    // final screen
    private var questionField:TextField;
    private var btn:Array = [];
    [Embed(source="../../img/final_bkg.jpg")]
    private var finalBkgClass:Class;
    private var finalTextField:TextField;
    private var resBtn:PrisonButton;

    public function Prison() {
        if (stage) {
            init();
        } else {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }
    }

    private function init(e:Event = null):void {
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

    private function initQuestionScreen():void {
        bkg = new bkgClass();
        addChild(bkg);

        qNumField = Creator.createQNumField();
        addChild(qNumField);

        questionField = Creator.createQuestionField();
        addChild(questionField);

        btn.push(
                new PrisonButton(237, 159, 332, 47),
                new PrisonButton(237, 223, 332, 47),
                new PrisonButton(237, 287, 332, 47),
                new PrisonButton(237, 350, 332, 47)
        );

        for (var i:uint = 0; i < btn.length; i++) {
            addChild(btn[i]);
        }

        btn[0].addEventListener(MouseEvent.CLICK, function (e:Event):void {
            btnReaction(0);
        });
        btn[1].addEventListener(MouseEvent.CLICK, function (e:Event):void {
            btnReaction(1);
        });
        btn[2].addEventListener(MouseEvent.CLICK, function (e:Event):void {
            btnReaction(2);
        });
        btn[3].addEventListener(MouseEvent.CLICK, function (e:Event):void {
            btnReaction(3);
        });
    }

    private function btnReaction(num:uint):void {
        score += questions[currentQuestion].response[num].score;
        currentQuestion++;
        showNextQuestion();
    }

    private function addQuestion(question:String, r1:String, r1s:uint, r2:String, r2s:uint, r3:String = null, r3s:uint = 0, r4:String = null, r4s:uint = 0):void {
        var q:Object = {};
        q.question = question;
        var response:Array = [];
        response.push(reformatResponse(r1, r1s));
        response.push(reformatResponse(r2, r2s));
        response.push(reformatResponse(r3, r3s));
        response.push(reformatResponse(r4, r4s));
        q.response = response;
        questions.push(q);

        function reformatResponse(r:String, rs:uint):Object {
            var resp:Object = {};
            resp.value = r;
            resp.score = rs;

            return resp;
        }
    }

    private function showNextQuestion():void {
        if (currentQuestion < questions.length) {
            qNumField.text = "Вопрос " + (currentQuestion + 1) + " из " + questions.length + ".";

            questionField.text = questions[currentQuestion].question;

            for (var i:uint = 0; i < btn.length; i++) {
                var text:String = questions[currentQuestion].response[i].value;
                if (text != null) {
                    btn[i].updateLabel(text);
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

        var finalBkg:Bitmap = new finalBkgClass();
        addChild(finalBkg);

        finalTextField = Creator.createFinalTextField();
        finalTextField.text = "Тест окончен.";
        addChild(finalTextField);

        resBtn = new PrisonButton(287, 267, 232, 47, "primary");
        resBtn.updateLabel("Узнать результат");
        addChild(resBtn);

        resBtn.addEventListener(MouseEvent.CLICK, function (e:Event):void {
            showResultScreen();
            var vkPost:VKRequest = new VKRequest(stage);
            vkPost.post();
        });
    }

    private function showResultScreen():void {
        finalTextField.visible = false;
        resBtn.visible = false;

        var resultTextField:TextField = Creator.createResultTextField();
        resultTextField.text = "Мой психологический\nтюремный срок:";
        addChild(resultTextField);

        var resultField:TextField = Creator.createResultField();
        resultField.text = score + " " + Helper.getUnit(score);
        addChild(resultField);
    }
}
}