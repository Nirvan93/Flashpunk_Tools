package  
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Nirvan
	 */
	public class LevelWorld extends World 
	{
		[Embed(source="../level1.lev", mimeType="application/octet-stream")] private static const LEVEL1:Class;
		
		public function LevelWorld() 
		{
			add(new LevelEntity(LEVEL1));
		}
		
		override public function update():void 
		{

			
			
			
			super.update();
		}
		
	}

}