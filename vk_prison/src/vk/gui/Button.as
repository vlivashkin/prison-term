// Base class for all VK buttons

package vk.gui {
import flash.display.SimpleButton;

/**
 * @author Alexey Kharkov
 */
public class Button extends SimpleButton {
    public static const LINK_BUTTON:uint = 0; // Button Type
    public static const BLUE_BUTTON:uint = 1; // Label
    public static const GRAY_BUTTON:uint = 2;

    public function Button(label:String, x:int, y:int, button_type:uint):void {
        this.x = x;
        this.y = y;

        bt = button_type;
        useHandCursor = true;

        this.label = label;
    }

    internal var bt:uint = 0;
    internal var s:String = null;

    public function get label():String {
        return s;
    }

    public function set label(value:String):void {
        s = value;
        updateButton();
    }

    // ---------------------------------------------------------------------- Internal methods.

    internal virtual function updateButton():void {
    } // Should be overrided
}
}
