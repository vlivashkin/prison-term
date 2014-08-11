package vk_prison.ui.vk {

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class ListBox extends Sprite {
    static internal const ITEM_H:uint = 50;
    static private const W:uint = 16; // Currently active item
    static private const ITEMS_COUNT_TO_SCROLL:uint = 8; // Highlighted item

    public function ListBox(x:int, y:int, w:int):void {
        this.x = x;
        this.y = y;
        this.w = w;

        items = [];

        //mouseEnabled = false;
        buttonMode = true;

        // Selection rects
        sel = new Sprite();
        sel.mouseEnabled = false;
        addChild(sel);
        sel.mask = maskRect();

        // Scroll bar
        sb = new ScrollBar(w - W, 0, ITEM_H * ITEMS_COUNT_TO_SCROLL - 1);
        sb.visible = false;
        sb.addEventListener(Event.SCROLL, onScroll);
        addChild(sb);

        drawBg();

        addEventListener(MouseEvent.ROLL_OVER, onOver);
        addEventListener(MouseEvent.ROLL_OUT, onOut);
        addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
    }
    internal var sel:Sprite = null; // Highlighting rectangle
    internal var owner:ComboBox = null;
    internal var enMouse:Boolean = true;
    private var items:Array = null;
    private var w:int = 0;
    private var sb:ScrollBar = null;

    public override function get width():Number {
        return w;
    }

    public override function get height():Number {
        return Math.min(length, ITEMS_COUNT_TO_SCROLL) * ITEM_H;
    }

    public function get length():uint {
        return items.length;
    }

    public function clear():void {
        items = [];
        clearLayout();

        // Reset ScrollBar
        sb.init(0, ITEMS_COUNT_TO_SCROLL);
        sb.scrollPosition = 0;
        sb.visible = false;
    }

    public function addItem(photoURL:String, name:String):void {
        addItemHelper(photoURL, name);
        upd();
    }

    private function addItemHelper(photoURL:String, name:String):void {
        var idx:int = length;
        var item:ComboItem = new ComboItem(this, photoURL, name, idx, w);
        item.y = idx * ITEM_H - 1;

        items.push(item);
    }

    private function upd():void {
        drawBg();

        if (length > ITEMS_COUNT_TO_SCROLL) {
            sb.init(length - ITEMS_COUNT_TO_SCROLL, ITEMS_COUNT_TO_SCROLL);
            sb.scrollPosition = 0;

            sb.visible = true;
        } else
            reDraw();
    }

    private function maskRect():Sprite {
        var ss:Sprite = new Sprite();
        Utils.fillRect(ss, 0, 0, w + 1, ITEMS_COUNT_TO_SCROLL * ITEM_H + 1, 0);
        addChild(ss);
        return ss;
    }

    private function drawBg():void {
        graphics.clear();
        var h:uint = Math.min(length, ITEMS_COUNT_TO_SCROLL) * ITEM_H - 1;
        Utils.rect(this, 0, 0, w, h, 0xffffff, 0xcccccc, (owner == null) ? 1 : 0.92);

        if (owner != null) {
            Utils.horLine(this, 0, w, 0, 0xadadad);
            Utils.horLine(this, 0, w, h, 0xadadad, 0.95);
            Utils.horLine(this, 0, w, h + 1, 0xadadad, 0.5);
            Utils.horLine(this, 0, w, h + 2, 0xadadad, 0.2);
        }
    }

    private function reDraw():void {
        clearLayout();

        var yy:uint = -ITEM_H * Math.round(sb.scrollPosition);
        for (var i:uint = 0; i < items.length; ++i) {
            items[i].y = yy - 1;
            yy += ITEM_H;

            if (items[i].y > -ITEM_H && items[i].y < height) {
                addChild(items[i]);
                items[i].mask = maskRect();
            }
        }

        setChildIndex(sb, numChildren - 1);
    }

    private function clearLayout():void {
        while (numChildren > 2) // the first two children are "sel" and "sel mask"
            removeChildAt(numChildren - 1);
        addChild(sb);
    }

    private function mouseInside():Boolean {
        return mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height;
    }

    // ----------------------------------------------------------------------- Event handlers

    private function onOver(e:MouseEvent):void {
        if (e.target == this && owner == null) {
            MouseWheel.capture();
        }
    }

    private function onOut(e:MouseEvent):void {
        if (e.target == this && owner == null && !mouseInside()) {
            MouseWheel.release();
        }
    }

    private function onScroll(e:Event):void {
        reDraw();
    }

    private function onWheel(e:MouseEvent):void {
        enMouse = true;
        sb.scrollPosition -= e.delta;
        reDraw();
    }
}
}
