package vk_prison.ui {
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.text.TextField;

import vk_prison.ui.vk.ListBox;

import vk_prison.data.Question;
import vk_prison.ui.vk.ListHeader;
import vk_prison.utils.TimeUtils;
import vk_prison.vk.Friends;

public class ScreenManager {
    [Embed(source='../../../img/bkg.jpg')]
    private var CommonBackground:Class;
    [Embed(source="../../../img/final_bkg.jpg")]
    private var FinalBackground:Class;

    // Common Fields
    private var _sprite:Sprite;
    private var _bkg:Bitmap;

    // Start Screen
    private var _startBtn:PrisonButton;
    private var _fListHeader:ListHeader;
    private var _friendsList:ListBox;

    // Question Screen Fields
    private var _qNumField:TextField;
    private var _questionField:TextField;
    private var _btn:Array;

    // Final Screen
    private var _finalTextField:TextField;
    private var _resBtn:PrisonButton;

    // Result Screen
    private var _resultTextField:TextField;
    private var _resultField:TextField;


    public function ScreenManager(sprite:Sprite) {
        _sprite = sprite;
    }

    public function showStartScreen(stage:Stage):void {
        setBackground("final");

        _startBtn = new PrisonButton(153, 195, 280, 60, PrisonButton.TEXT_SIZE_GREAT);
        _startBtn.updateLabel("Начать тест");
        _sprite.addChild(_startBtn);

        _fListHeader = new ListHeader(576, 10, 221, 40, "Сроки ваших друзей");
        _sprite.addChild(_fListHeader);

        _friendsList = new ListBox(576, 44, 220);
        _sprite.addChild(_friendsList);

        var vkFriends:Friends = new Friends(stage);
        vkFriends.getFriendsList(onFriendsListLoaded);
    }

    private function onFriendsListLoaded(data:Object):void {
        for each (var guy:Object in data) {
            _friendsList.addItem(guy.photo, guy.first_name + " " + guy.last_name);
        }
    }



    public function showQuestionScreen():void {
        setBackground("common");

        _qNumField = FieldGenerator.createQNumField();
        _sprite.addChild(_qNumField);

        _questionField = FieldGenerator.createQuestionField();
        _sprite.addChild(_questionField);

        _btn = [];
        _btn.push(
                new PrisonButton(237, 159, 332, 47),
                new PrisonButton(237, 223, 332, 47),
                new PrisonButton(237, 287, 332, 47),
                new PrisonButton(237, 350, 332, 47)
        );

        for (var i:uint = 0; i < _btn.length; i++) {
            _sprite.addChild(_btn[i]);
        }
    }

    public function showNextQuestion(question:Question):void {
        _qNumField.text = "Вопрос " + question.number + " из 10.";

        _questionField.text = question.question;

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

        _finalTextField = FieldGenerator.createFinalTextField();
        _finalTextField.text = "Тест окончен.";
        _sprite.addChild(_finalTextField);

        _resBtn = new PrisonButton(287, 267, 232, 47, PrisonButton.TEXT_SIZE_BIG);
        _resBtn.updateLabel("Узнать результат");
        _sprite.addChild(_resBtn);
    }

    public function showResultScreen(score:uint):void {
        setBackground("final");

        _resultTextField = FieldGenerator.createResultTextField();
        _resultTextField.text = "Мой психологический\nтюремный срок:";
        _sprite.addChild(_resultTextField);

        _resultField = FieldGenerator.createResultField();
        _resultField.text = score + " " + TimeUtils.getUnit(score);
        _sprite.addChild(_resultField);
    }

    public function clearControls():void {
        remove(_qNumField);
        remove(_questionField);
        if (_btn != null) {
            for each (var button:PrisonButton in _btn){
                remove(button);
            }
            _btn = null;
        }
        remove(_finalTextField);
        remove(_resBtn);
    }

    private static function remove(child:DisplayObject):void {
        if(child && child.parent) {
            child.parent.removeChild(child);
            child = null;
        }
    }


    public function get startBtn():PrisonButton {
        return _startBtn;
    }

    public function get btn():Array {
        return _btn;
    }

    public function get resBtn():PrisonButton {
        return _resBtn;
    }

    private function setBackground(bkgType:String):void {
        if (_bkg != null) {
            _sprite.removeChild(_bkg);
        }
        if(bkgType == "common") {
            _bkg = new CommonBackground();
            _sprite.addChild(_bkg);
        } else if (bkgType == "final") {
            _bkg = new FinalBackground();
            _sprite.addChild(_bkg);
        } else {
            _bkg = new CommonBackground();
            _sprite.addChild(_bkg);
        }
    }
}
}
