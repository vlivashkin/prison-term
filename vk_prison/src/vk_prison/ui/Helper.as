package vk_prison.ui {
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

internal class Helper {
    [Embed(systemFont="Calibri",
            fontName="CalibriCustom",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
     private var CalibriCustom:Class;

    public function Helper() {
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