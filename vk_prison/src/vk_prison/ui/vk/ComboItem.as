package vk_prison.ui.vk {
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFormat;

import vk_prison.utils.DateUtils;
import vk_prison.vk.Storage;

internal class ComboItem extends Sprite {
    public var txt:TextField = null;
    public var idx:int = 0;
    private var par:* = null;
    private var w:uint = 1;
    private var roundRect:Shape;

    public function ComboItem(par:*, uid:uint, name:String, photoURL:String, idx:int, w:int):void {
        this.par = par;
        this.idx = idx;
        this.w = w;

        var bkgRect:Shape = new Shape();
        bkgRect.graphics.beginFill(0xffffff, 0);
        bkgRect.graphics.drawRect(0, 0, w, ListBox.ITEM_H);
        addChild(bkgRect);

        roundRect = new Shape();
        roundRect.graphics.beginFill(0xffffff, 1);
        roundRect.graphics.drawRoundRect(10, 8, 38, 38, 4, 4);
        addChild(roundRect);

        var loader:Loader = addChild(new Loader()) as Loader;
        loader.load(new URLRequest(photoURL));
        loader.contentLoaderInfo.addEventListener(Event.INIT, onImageLoaded);
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
        loader.x = 10;
        loader.y = 8;
        addChild(loader);

        var myFormat:TextFormat = new TextFormat();
        myFormat.bold = true;
        myFormat.color = 0x45688e;

        txt = Utils.addText(60, 9, w, 11, name);
        txt.setTextFormat(myFormat);
        addChild(txt);

        var vkStorage:Storage = new Storage();
        vkStorage.getScore(uid, onScoreLoaded);

        addEventListener(MouseEvent.MOUSE_OVER, onOver);
        addEventListener(MouseEvent.MOUSE_OUT, onOut);
        addEventListener(MouseEvent.MOUSE_DOWN, onDown);

        buttonMode = true;
        mouseChildren = false;
    }

    internal function onScoreLoaded(data:Object):void {
        var score:String = data.toString();

        var myFormat:TextFormat = new TextFormat();
        myFormat.bold = true;
        myFormat.color = 0x45688e;

        trace("Срок " + score + DateUtils.getUnit(parseInt(score, 10)));
        txt = Utils.addText(60, 27, w, 11, "Срок: " + score + " " + DateUtils.getUnit(parseInt(score, 10)));
        txt.setTextFormat(myFormat);
        addChild(txt);
    }

    internal function onImageLoaded(event:Event):void {
        var loaderInfo:LoaderInfo = LoaderInfo(event.target);

        if (loaderInfo.bytesLoaded == loaderInfo.bytesTotal) {
            EventDispatcher(event.target).removeEventListener(event.type, arguments.callee);
            loaderInfo.loader.scaleX = 38 / loaderInfo.width;
            loaderInfo.loader.scaleY = 38 / loaderInfo.height;
            loaderInfo.loader.mask = roundRect;
        }
    }

    private function onOver(e:MouseEvent):void {
        if (!par.enMouse)
            return;

        if (par.selY != y)
            Utils.rect(this, 0, 1, w, ListBox.ITEM_H - 1, Utils.ARROW_BG_COL, Utils.ARROW_BG_BORDER_COL);
    }

    private function onOut(e:MouseEvent):void {
        graphics.clear();
    }

    private function onDown(e:MouseEvent):void {

    }
}
}
