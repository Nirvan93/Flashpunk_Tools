package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Nirvan
	 */
	
		
	 
	public class Main extends Engine
	{
		[Embed(source = "calist.ttf",  embedAsCFF = "false", fontFamily = 'font')] public static const F_FONT:Class;

		public function Main():void 
		{
			super(640, 480, 60);
			FP.console.enable();
		}
		
		override public function init():void 
		{
			trace('engine initialized');
			FP.screen.color = 0x000;
			FP.world = new gridRoom;
			super.init();
		}
	}
	
}