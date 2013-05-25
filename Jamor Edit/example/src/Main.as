package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.geom.Rectangle;
	import flash.ui.MouseCursorData;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Nirvan
	 */
	
		
	 
	public class Main extends Engine
	{
		//[Embed(source = "../assets/Droeming.otf",  embedAsCFF = "false", fontFamily = 'font')] public static const F_FONT:Class;
		//[Embed(source = "../assets/cur1.png")] public const CURSOR1:Class;
		//[Embed(source = "../assets/cur2.png")] public const CURSOR2:Class;		
		
		//private var c1:Bitmap = new CURSOR1();
		//private var c2:Bitmap = new CURSOR2();
		
		public function Main():void 
		{
			//if(Mouse.supportsNativeCursor){setupMouseCursors();}
			super(700, 500, 60);
			FP.console.enable();
			
		}
		
		override public function init():void 
		{
			trace('engine initialized');
			FP.screen.color = 0x000000;
			FP.world = new DecodeRoom;
			
			
			
			super.init();
		}
		
		/*
        private function setupMouseCursors():void 
		{
			var bitmaps:Vector.<BitmapData> = new Vector.<BitmapData>;
			var r:Rectangle;
			var cursorBitmapData:BitmapData;
			var cursorData:MouseCursorData;
			var cursorVector:Vector.<BitmapData>;
			
			r = new Rectangle(0, 0, 32, 32);
            cursorBitmapData = new BitmapData(32, 32, true, 0x00000000);

            cursorBitmapData.copyPixels(c1.bitmapData, r, new Point(0, 0), null, null, true);
			bitmaps[0]=cursorBitmapData;
             
            cursorData = new MouseCursorData();
            cursorData.hotSpot = new Point(0, 0);
            cursorData.data = bitmaps;
             
            Mouse.registerCursor("arrow", cursorData);
			
			///////////////
			
			cursorBitmapData = new BitmapData(32, 32, true, 0x00000000);
            cursorBitmapData.copyPixels(c2.bitmapData, r, new Point(0, 0), null, null, true);
			bitmaps[0]=cursorBitmapData;
             
            cursorData = new MouseCursorData();
            cursorData.hotSpot = new Point(0, 0);
            cursorData.data = bitmaps;
             
            Mouse.registerCursor("button", cursorData);
			
			
			//cursorBitmapData = new BitmapData(24, 24, true, 0x00000000);
            //cursorBitmapData.copyPixels(c2.bitmapData, r, new Point(0, 0), null, null, true);
			//bitmaps[0]=cursorBitmapData;
             
            //cursorData = new MouseCursorData();
            //cursorData.hotSpot = new Point(0, 0);
            //cursorData.data = bitmaps;
             
            //Mouse.registerCursor("ibeam", cursorData);
			
			Mouse.cursor = "arrow";
			
        }
		*/
	
	}
	
	

	
}