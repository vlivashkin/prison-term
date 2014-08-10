package vk_prison.ui {
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class PrisonButton extends SimpleButton {
    static public const TEXT_SIZE_NORMAL:uint = 0;
    static public const TEXT_SIZE_BIG:uint = 1;
    static public const TEXT_SIZE_GREAT:uint = 2;

    [Embed(systemFont="Calibri",
            fontName="CalibriCustom",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var CalibriCustom:Class;

    public function PrisonButton(x:uint, y:uint, width:uint, height:uint, buttonType:uint = TEXT_SIZE_NORMAL) {
        var textSize:uint;
        var textY:int;

        switch (buttonType) {
            case TEXT_SIZE_GREAT:
                textSize = 30;
                textY = -6;
                break;
            case TEXT_SIZE_BIG:
                textSize = 24;
                textY = -4;
                break;
            case TEXT_SIZE_NORMAL:
            default:
                textSize = 17;
                textY = 0;
                break;
        }

        this.upState = createRect(width, height, 0x999999, textSize, textY);
        this.overState = createRect(width, height, 0xAAAAAA, textSize, textY);
        this.downState = createRect(width, height, 0x555555, textSize, textY);
        this.hitTestState = createRect(width, height, 0x666666, textSize, textY);
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

    public static function createRect(width:uint, height:uint, color:uint, textSize:uint, y:int):Sprite {
        var myFormat:TextFormat = new TextFormat();
        myFormat.size = textSize;
        myFormat.font = "CalibriCustom";

        var textField:TextField = new TextField();
        textField.name = "textField";
        textField.mouseEnabled = false;
        textField.width = width;
        textField.height = height;
        textField.autoSize = TextFieldAutoSize.CENTER;
        textField.y = height / 2 - 12 + y;
        textField.defaultTextFormat = myFormat;
        textField.embedFonts = true;

        var rectangleShape:Shape = new Shape();
        rectangleShape.graphics.lineStyle(2);
        rectangleShape.graphics.beginFill(color);
        rectangleShape.graphics.drawRect(0, 0, width, height);
        rectangleShape.graphics.endFill();
        rectangleShape.alpha = .95;

        var btnSprite:Sprite = new Sprite();
        btnSprite.name = "btnSprite";
        btnSprite.addChild(rectangleShape);
        btnSprite.addChild(textField);

        return btnSprite;
    }
}
}