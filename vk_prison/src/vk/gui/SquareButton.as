package vk.gui {
/**
 * @author Alexey Kharkov
 */
public class SquareButton extends Button {
    public function SquareButton(label:String, x:int, y:int, type:uint = BLUE_BUTTON):void {
        super(label, x, y, type);
    } // Used for Box
    public var idx:uint = 0; // x margin
    private var w:uint = 0; // y margin
    private var h:uint = 25;

    public override function set width(val:Number):void {
        w = val;
        updateButton();
    }

    public override function set height(val:Number):void {
        h = val;
        updateButton();
    }

    // -------------------------------------------------------------------- Internal methods
    internal override function updateButton():void {
        switch (bt) {
            case GRAY_BUTTON:
                upState = new SquareGrayButtonDS(0, s, w, h);
                overState = new SquareGrayButtonDS(1, s, w, h);
                downState = new SquareGrayButtonDS(2, s, w, h);
                break;
            default:
                upState = new SquareBlueButtonDS(0, s, w, h);
                overState = new SquareBlueButtonDS(1, s, w, h);
                downState = new SquareBlueButtonDS(2, s, w, h);
        }
        hitTestState = overState;
    }
}
}
