package vk_prison.ui {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class Creator {

    [Embed(systemFont="Calibri",
            fontName="CalibriCustom",
            mimeType="application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    private var CalibriCustom:Class;

    public function Creator() {
    }

    public static function createQNumField():TextField {
        var qBar:TextField = new TextField();
        qBar.x = 243;
        qBar.y = 2;
        qBar.width = 323;
        qBar.height = 23;
        qBar.autoSize = TextFieldAutoSize.CENTER;
        qBar.textColor = 0xFFFFFF;

        return qBar;
    }

    public static function createQuestionField():TextField {
        var myFormat:TextFormat = new TextFormat();
        myFormat.size = 21;
        myFormat.align = TextFormatAlign.CENTER;
        myFormat.font = "CalibriCustom";


        var qBar:TextField = new TextField();
        qBar.x = 80;
        qBar.y = 67 + 69 - qBar.height / 2 - 1;
        qBar.width = 647;
        qBar.autoSize = TextFieldAutoSize.CENTER;
        qBar.defaultTextFormat = myFormat;
        qBar.textColor = 0xFFFFFF;
        qBar.embedFonts = true;

        return qBar;
    }

    public static function createFinalTextField():TextField {
        var myFormat:TextFormat = new TextFormat();
        myFormat.size = 60;
        myFormat.align = TextFormatAlign.CENTER;
        myFormat.font = "CalibriCustom";
        myFormat.bold = true;

        var qBar:TextField = new TextField();
        qBar.x = 80;
        qBar.y = 180;
        qBar.width = 647;
        qBar.autoSize = TextFieldAutoSize.CENTER;
        qBar.defaultTextFormat = myFormat;
        qBar.textColor = 0xFFFFFF;
        qBar.embedFonts = true;

        return qBar;
    }

    public static function createResultTextField():TextField {
        var myFormat:TextFormat = new TextFormat();
        myFormat.size = 60;
        myFormat.align = TextFormatAlign.LEFT;
        myFormat.font = "CalibriCustom";
        myFormat.bold = true;

        var qBar:TextField = new TextField();
        qBar.x = 30;
        qBar.y = 10;
        qBar.width = 647;
        qBar.autoSize = TextFieldAutoSize.LEFT;
        qBar.defaultTextFormat = myFormat;
        qBar.textColor = 0xFFFFFF;
        qBar.embedFonts = true;

        return qBar;
    }

    public static function createResultField():TextField {
        var myFormat:TextFormat = new TextFormat();
        myFormat.size = 120;
        myFormat.align = TextFormatAlign.LEFT;
        myFormat.font = "CalibriCustom";
        myFormat.bold = true;

        var qBar:TextField = new TextField();
        qBar.x = 30;
        qBar.y = 190;
        qBar.width = 647;
        qBar.autoSize = TextFieldAutoSize.LEFT;
        qBar.defaultTextFormat = myFormat;
        qBar.textColor = 0xFFFFFF;
        qBar.embedFonts = true;

        return qBar;
    }
}
}