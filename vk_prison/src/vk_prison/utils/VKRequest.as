package vk_prison.utils {
import flash.display.BitmapData;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Matrix;
import flash.utils.ByteArray;

import com.adobe.images.JPGEncoder;

import ru.inspirit.net.MultipartURLLoader;

import vk.APIConnection;

public class VKRequest {
    internal var stage:Stage;
    internal var flashVars:Object;
    internal var VK:APIConnection;

    public function VKRequest(stage:Stage) {
        this.stage = stage;
        flashVars = stage.loaderInfo.parameters as Object;

        if (!flashVars.api_id) {
            // -- For local testing enter you test-code here:
            flashVars['api_id'] = 4428337;
            flashVars['viewer_id'] = 41624918;
            flashVars['sid'] = "acc40156cf2dc376dea9d0350ed56f2f0a22e19d8834d5222b54546d126d8cec502ef0ddd47b6a23fcca2";
            flashVars['secret'] = "f542f15920";
            // -- //
        }

        VK = new APIConnection(flashVars);
    }

    public function post():void {
        getServerURL();
    }

    private function getServerURL():void {
        VK.api('photos.getWallUploadServer', {
        }, function(data:Object):void {
            var bitmapData:BitmapData = new BitmapData(stage.width, stage.height);
            bitmapData.draw(stage, new Matrix());
            sendImage(data.upload_url, bitmapData);
        }, function(data:Object):void {
            trace("Fail photos.getWallUploadServer error_msg: " + data.error_msg + "\n");
        });
    }

    public function sendImage(url:String, image:BitmapData):void {
        var jpgEncoder:JPGEncoder = new JPGEncoder(90);
        var imgBA:ByteArray = jpgEncoder.encode(image);

        var mpLoader:MultipartURLLoader = new MultipartURLLoader();
        mpLoader.addFile(imgBA, "photo.jpg", "photo", 'image/jpg');
        mpLoader.load(url);
        mpLoader.addEventListener(Event.COMPLETE, function(event:Event):void {
            var dataStr:String = event.currentTarget.data.toString();
            trace(dataStr);
            var data:Object = JSON.parse(dataStr);

            saveWallPhoto(data);
        });
    }

    public function saveWallPhoto(data:Object):void {
        VK.api("photos.saveWallPhoto", {
            server: data.server,
            photo: data.photo,
            hash: data.hash
        }, function(data:Object):void {
            wallPost("Мои результаты теста на психологический тюремный срок\nhttps://vk.com/app4428337", data['0'].id);
        }, function(data:Object):void {
            trace("Fail photos.saveWallPhoto error_msg: " + data.error_msg + "\n");
        });
    }

    public function wallPost(message:String, attachment:String):void {
        VK.api('wall.post', {
            message: message,
            attachment: attachment
        }, function(data:Object):void {
            trace("Success wall.post post_id: " + data.post_id.toString() + "\n");
        }, function(data:Object):void {
            trace("Fail wall.post error_msg: " + data.error_msg + "\n");
        });
    }
}
}