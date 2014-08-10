package vk.gui {
import flash.display.Sprite;
import flash.text.TextField;

/**
 * @author Alexey Kharkov
 */
internal class LabelButton extends Sprite {
    public function LabelButton(label:String, x:int, y:int):void {
        txt = Utils.addText(x, y, 0, 11, label);
        addChild(txt);

        buttonMode = true;
        mouseChildren = false;
    }

    private var txt:TextField = null;

    public function get label():String {
        return txt.text;
    }

    public function set label(s:String):void {
        Utils.setText(txt, s);
    }
}
}
