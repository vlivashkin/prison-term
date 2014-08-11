package vk_prison.ui.vk {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

public class ListHeader extends Sprite {
    public function ListHeader(x:uint, y:uint, w:uint, h:uint, s:String) {
        var myFormat:TextFormat = new TextFormat();
        myFormat.bold = true;

        var txt:TextField = Utils.addText(x, y, w, 11, s, 0xffffff);
        txt.setTextFormat(myFormat);
        addChild(txt);

        txt.y = y + Math.round((h - txt.textHeight) / 2) - 5;
        txt.x = x + 10;

        Utils.fillRRect(this, x, y, w, h, 0x5780ab, 6);
    }
}
}
