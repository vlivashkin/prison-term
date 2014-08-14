package vk_prison {
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.*;
import flash.geom.Matrix;

import vk_prison.data.Question;
import vk_prison.data.QuestionsManager;
import vk_prison.ui.ScreenManager;
import vk_prison.vk.Config;
import vk_prison.vk.Friends;
import vk_prison.vk.Storage;
import vk_prison.vk.Wall;

[SWF(width=807, height=454)]
public class Prison extends Sprite {
    private var sManager:ScreenManager;
    private var qManager:QuestionsManager;

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

        sManager = new ScreenManager(this);
        qManager = new QuestionsManager();

        sManager.setBackground("final");

        Config.getInstance().initFlashVars(stage);

        var vkFriends:Friends = new Friends();
        vkFriends.getFriendsList(onFriendsListLoaded);
    }

    private function onFriendsListLoaded(friendsList:Object):void {
        if (friendsList) {
            toStartScreen(friendsList);
        } else {
            toQuestionScreen();
        }
    }

    private function toStartScreen(friendsList:Object):void {
        sManager.showStartScreen(friendsList);
        sManager.startBtn.addEventListener(MouseEvent.CLICK, function (e:Event):void {
            toQuestionScreen();
        });

    }

    private function toQuestionScreen():void {
        sManager.clearControls();
        sManager.showQuestionScreen();
        sManager.btn[0].addEventListener(MouseEvent.CLICK, function (e:Event):void {
            toNextQuestion(0);
        });
        sManager.btn[1].addEventListener(MouseEvent.CLICK, function (e:Event):void {
            toNextQuestion(1);
        });
        sManager.btn[2].addEventListener(MouseEvent.CLICK, function (e:Event):void {
            toNextQuestion(2);
        });
        sManager.btn[3].addEventListener(MouseEvent.CLICK, function (e:Event):void {
            toNextQuestion(3);
        });

        toNextQuestion(-1);
    }

    private function toNextQuestion(btnNum:int):void {
        var question:Question = qManager.getNextQuestion(btnNum);
        if (question != null) {
            sManager.showNextQuestion(question);
        } else {
            toFinalScreen();
        }
    }

    private function toFinalScreen():void {
        sManager.clearControls();
        sManager.showFinalScreen();

        sManager.resBtn.addEventListener(MouseEvent.CLICK, function (e:Event):void {
            toResultScreen();

            var snapshot:BitmapData = new BitmapData(stage.width, stage.height);
            snapshot.draw(stage, new Matrix());

            sManager.clearControls();

            var vkWall:Wall = new Wall(stage);
            vkWall.wallPostWithScreenshot(snapshot, toResultScreen);
        });
    }

    private function toResultScreen():void {
        sManager.clearControls();
        sManager.showResultScreen(qManager.score);

        var vkStorage:Storage = new Storage();
        vkStorage.setScore(qManager.score);
    }
}
}