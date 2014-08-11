package vk_prison.ui.vk {
import flash.display.Loader;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFormat;


/**
 * @author Alexey Kharkov
 */
internal class ComboItem extends Sprite {
    public function ComboItem(par:*, photoURL:String, name:String, idx:int, w:int):void {
        this.par = par;
        this.idx = idx;
        this.w = w;

        var bkgRect:Shape = new Shape();
        bkgRect.graphics.beginFill(0xffffff, 0);
        bkgRect.graphics.drawRect(0, 0, w, ListBox.ITEM_H);
        addChild(bkgRect);

        roundRect = new Shape();
        roundRect.graphics.beginFill(0x006600, 1);
        roundRect.graphics.drawRoundRect(10, 8, 38, 38, 4, 4);
        addChild(roundRect);

        loader = addChild(new Loader()) as Loader;
        loader.load(new URLRequest(photoURL));
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
        loader.x = 10;
        loader.y = 8;
        addChild(loader);

        var myFormat:TextFormat = new TextFormat();
        myFormat.bold = true;
        myFormat.color = 0x45688e;

        txt = Utils.addText(60, 8, w, 11, name);
        txt.setTextFormat(myFormat);
        addChild(txt);

        addEventListener(MouseEvent.MOUSE_OVER, onOver);
        addEventListener(MouseEvent.MOUSE_OUT, onOut);
        addEventListener(MouseEvent.MOUSE_DOWN, onDown);

        buttonMode = true;
        mouseChildren = false;
    }

    public var txt:TextField = null;
    public var idx:int = 0;
    private var par:* = null;
    private var w:uint = 1;
    private var loader:Loader;
    private var roundRect:Shape;

    internal function onImageLoaded(e:Event):void {
        loader.content.height = 38;
        loader.content.width = 38;
        loader.content.mask = roundRect;
    }

    // ----------------------------------------------------------------------- Events handlers
    private function onOver(e:MouseEvent):void {
        if (!par.enMouse)
            return;

        if (par.owner == null) // Parent is Listbox, not ComboBox
        {
            if (par.selY != y)
                Utils.rect(this, 0, 1, w, ListBox.ITEM_H - 1, Utils.ARROW_BG_COL, Utils.ARROW_BG_BORDER_COL);
        }
        else
            par.setItemActive(this);
    }

    private function onOut(e:MouseEvent):void {
        graphics.clear();
    }

    private function onDown(e:MouseEvent):void {
        //graphics.clear();
        par.onItemClick(this, true);
    }
}
}
