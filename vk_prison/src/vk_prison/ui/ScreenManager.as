package vk_prison.ui {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;

import vk_prison.data.Question;
import vk_prison.utils.TimeUtils;

public class ScreenManager {
    [Embed(source='../../../img/bkg.jpg')]
    private var CommonBackground:Class;
    [Embed(source="../../../img/final_bkg.jpg")]
    private var FinalBackground:Class;

    // Common Fields
    private var sprite:Sprite;
    private var bkg:Bitmap;

    // Start Screen

    // Question Screen Fields
    private var qNumField:TextField;
    private var questionField:TextField;
    private var _btn:Array;


    // Final Screen
    private var finalTextField:TextField;

    // Result Screen
    private var _resBtn:PrisonButton;

    public function ScreenManager(sprite:Sprite) {
        this.sprite = sprite;
    }

    public function showStartScreen():void {
        setBackground("common");
    }

    public function showQuestionScreen():void {
        setBackground("common");

        qNumField = Creator.createQNumField();
        sprite.addChild(qNumField);

        questionField = Creator.createQuestionField();
        sprite.addChild(questionField);

        _btn = [];
        _btn.push(
                new PrisonButton(237, 159, 332, 47),
                new PrisonButton(237, 223, 332, 47),
                new PrisonButton(237, 287, 332, 47),
                new PrisonButton(237, 350, 332, 47)
        );

        for (var i:uint = 0; i < _btn.length; i++) {
            sprite.addChild(_btn[i]);
        }
    }

    public function showNextQuestion(question:Question):void {
        qNumField.text = "Вопрос " + question.number + " из 10.";

        questionField.text = question.question;

        for (var i:uint = 0; i < _btn.length; i++) {
            var text:String = question.answers[i].value;
            if (text != null) {
                _btn[i].updateLabel(text);
                _btn[i].visible = true;
            } else {
                _btn[i].visible = false;
            }
        }
    }

    public function showFinalScreen():void {
        setBackground("final");

        bkg.visible = false;
        qNumField.visible = false;
        questionField.visible = false;
        for (var i:uint = 0; i < _btn.length; i++) {
            _btn[i].visible = false;
        }

        finalTextField = Creator.createFinalTextField();
        finalTextField.text = "Тест окончен.";
        sprite.addChild(finalTextField);

        _resBtn = new PrisonButton(287, 267, 232, 47, "primary");
        _resBtn.updateLabel("Узнать результат");
        sprite.addChild(_resBtn);
    }

    public function showResultScreen(score:uint):void {
        setBackground("final");

        finalTextField.visible = false;
        _resBtn.visible = false;

        var resultTextField:TextField = Creator.createResultTextField();
        resultTextField.text = "Мой психологический\nтюремный срок:";
        sprite.addChild(resultTextField);

        var resultField:TextField = Creator.createResultField();
        resultField.text = score + " " + TimeUtils.getUnit(score);
        sprite.addChild(resultField);
    }

    public function clearControls():void {
        if (qNumField != null) {
            sprite.removeChild(qNumField);
            qNumField = null;
        }
        if (questionField != null) {
            sprite.removeChild(questionField);
            questionField = null;
        }
        if (_btn != null) {
            _btn.forEach(function(button:PrisonButton):void {
                sprite.removeChild(button);
            });
            _btn  = null;
        }
        if (finalTextField != null) {
            sprite.removeChild(finalTextField);
            finalTextField = null;
        }
        if (_resBtn != null) {
            sprite.removeChild(_resBtn);
            _resBtn = null;
        }
    }


    public function get btn():Array {
        return _btn;
    }

    public function get resBtn():PrisonButton {
        return _resBtn;
    }

    private function setBackground(bkgType:String):void {
        if (bkg != null) {
            sprite.removeChild(bkg);
        }
        if(bkgType == "common") {
            bkg = new CommonBackground();
            sprite.addChild(bkg);
        } else if (bkgType == "final") {
            bkg = new FinalBackground();
            sprite.addChild(bkg);
        } else {
            bkg = new CommonBackground();
            sprite.addChild(bkg);
        }
    }
}
}
