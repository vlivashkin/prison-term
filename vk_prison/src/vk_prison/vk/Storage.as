package vk_prison.vk {

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import vk.APIConnection;

import vk_prison.utils.DateUtils;

public class Storage {
    internal var _VK:APIConnection;

    public function Storage() {
        _VK = Config.getInstance().VK;
    }

    internal var _uid:uint;
    internal var _onSuccess:Function;

    public function getScore(uid:uint, onSuccess:Function):void {
        _uid = uid;
        _onSuccess = onSuccess;

        _VK.api("getVariable", {key: 1504, user_id: uid},
        function(data:Object):void {
            if (data == "") {
                var score:uint = DateUtils.getRandomNumber(10, 25);
                setScore(score);
                data = score.toString();
            }
            onSuccess(data);
        }, function(data:Object):void {
            if (data.error_code == 6) {
                var _timer:Timer = new Timer(DateUtils.getRandomNumber(100, 2000), 1);
                _timer.addEventListener(TimerEvent.TIMER, onComplete);
                _timer.start();
            }
        });
    }

    internal function onComplete(e:Event):void {
        getScore(_uid, _onSuccess);
    }

    public function setScore(score:uint):void {
        _VK.api("putVariable", {key: 1504, value: score},
        function (data:Object):void {

        }, function (data:Object):void {

        });
    }
}
}
