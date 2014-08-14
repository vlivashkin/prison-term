package vk_prison.vk {
import com.adobe.images.JPGEncoder;

import flash.display.BitmapData;
import flash.display.Stage;
import flash.events.Event;
import flash.utils.ByteArray;

import ru.inspirit.net.MultipartURLLoader;

import vk.APIConnection;

public class Wall {
    internal var _stage:Stage;
    internal var _VK:APIConnection;

    public function Wall(stage:Stage) {
        _VK = Config.getInstance().VK;
        _stage = stage;
    }

    public function wallPostWithScreenshot(bitmapData:BitmapData, onSuccess:Function):void {
        _VK.api('photos.getWallUploadServer', {
        }, function(data:Object):void {
            sendImage(data.upload_url, bitmapData, onSuccess);
        }, function(data:Object):void {
            trace("Fail photos.getWallUploadServer with error_msg: " + data.error_msg + "\n");
        });
    }

    private function sendImage(url:String, image:BitmapData, onSuccess:Function):void {
        var jpgEncoder:JPGEncoder = new JPGEncoder(90);
        var imgBA:ByteArray = jpgEncoder.encode(image);

        var mpLoader:MultipartURLLoader = new MultipartURLLoader();
        mpLoader.addFile(imgBA, "photo.jpg", "photo", 'image/jpg');
        mpLoader.load(url);
        mpLoader.addEventListener(Event.COMPLETE, function(event:Event):void {
            var dataStr:String = event.currentTarget.data.toString();
            trace(dataStr);
            var data:Object = JSON.parse(dataStr);

            saveWallPhoto(data, onSuccess);
        });
    }

    private function saveWallPhoto(data:Object, onSuccess:Function):void {
        _VK.api("photos.saveWallPhoto", {
            server: data.server,
            photo: data.photo,
            hash: data.hash
        }, function(data:Object):void {
            wallPost("Мои результаты теста на психологический тюремный срок\nhttps://vk.com/app4428337", data['0'].id, onSuccess);
        }, function(data:Object):void {
            trace("Fail photos.saveWallPhoto with error_msg: " + data.error_msg + "\n");
        });
    }

    private function wallPost(message:String, attachment:String, onSuccess:Function):void {
        _VK.api('wall.post', {
            message: message,
            attachment: attachment
        }, function(data:Object):void {
            onSuccess(data);
        }, function(data:Object):void {
            trace("Fail wall.post with error_msg: " + data.error_msg + "\n");
        });
    }
}
}