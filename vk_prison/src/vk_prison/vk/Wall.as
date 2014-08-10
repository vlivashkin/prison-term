package vk_prison.vk {
import flash.display.BitmapData;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Matrix;
import flash.utils.ByteArray;

import com.adobe.images.JPGEncoder;

import ru.inspirit.net.MultipartURLLoader;

import vk.APIConnection;

public class Wall {
    internal var stage:Stage;
    internal var flashVars:Object;
    internal var VK:APIConnection;

    public function Wall(stage:Stage) {
        this.stage = stage;
        flashVars = stage.loaderInfo.parameters as Object;

        if (!flashVars.api_id) {
            flashVars['api_id'] = 4428337;
            flashVars['viewer_id'] = 41624918;
            flashVars['sid'] = "ae34f41025929d067a2fc182a95e7830a0d12aa2c487de48f62e9d54c84109ca8b0a79073b37d11ed295a";
            flashVars['secret'] = "0081bc7f5d";
        }

        VK = new APIConnection(flashVars);
    }

    public function wallPostWithScreenshot():void {
        VK.api('photos.getWallUploadServer', {
        }, function(data:Object):void {
            var bitmapData:BitmapData = new BitmapData(stage.width, stage.height);
            bitmapData.draw(stage, new Matrix());
            sendImage(data.upload_url, bitmapData);
        }, function(data:Object):void {
            trace("Fail photos.getWallUploadServer with error_msg: " + data.error_msg + "\n");
        });
    }

    private function sendImage(url:String, image:BitmapData):void {
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

    private function saveWallPhoto(data:Object):void {
        VK.api("photos.saveWallPhoto", {
            server: data.server,
            photo: data.photo,
            hash: data.hash
        }, function(data:Object):void {
            wallPost("Мои результаты теста на психологический тюремный срок\nhttps://vk.com/app4428337", data['0'].id);
        }, function(data:Object):void {
            trace("Fail photos.saveWallPhoto with error_msg: " + data.error_msg + "\n");
        });
    }

    private function wallPost(message:String, attachment:String):void {
        VK.api('wall.post', {
            message: message,
            attachment: attachment
        }, function(data:Object):void {
            trace("Success wall.post with post_id: " + data.post_id.toString() + "\n");
        }, function(data:Object):void {
            trace("Fail wall.post with error_msg: " + data.error_msg + "\n");
        });
    }
}
}