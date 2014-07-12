package vk_prison.ui {
import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.text.TextField;

public class PrisonButton extends SimpleButton {
    public function PrisonButton(x:uint, y:uint, width:uint, height:uint, buttonType:String = "common") {
        var textSize:uint;
        var textY:int;

        switch (buttonType) {
            case "primary":
                textSize = 24;
                textY = -4;
                break;
            case "common":
            default:
                textSize = 17;
                textY = 0;
                break;
        }

        this.upState = Helper.createRect(width, height, 0x999999, textSize, textY);
        this.overState = Helper.createRect(width, height, 0xAAAAAA, textSize, textY);
        this.downState = Helper.createRect(width, height, 0x555555, textSize, textY);
        this.hitTestState = Helper.createRect(width, height, 0x666666, textSize, textY);
        this.x = x;
        this.y = y;
    }

    public function updateLabel(text:String):void {
        var sbs:DisplayObjectContainer;

        sbs = DisplayObjectContainer(this.upState);
        TextField(sbs.getChildByName("textField")).text = text;
        sbs = DisplayObjectContainer(this.overState);
        TextField(sbs.getChildByName("textField")).text = text;
        sbs = DisplayObjectContainer(this.downState);
        TextField(sbs.getChildByName("textField")).text = text;
        sbs = DisplayObjectContainer(this.hitTestState);
        TextField(sbs.getChildByName("textField")).text = text;
    }
}
}