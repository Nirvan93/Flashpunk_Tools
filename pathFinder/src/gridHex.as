package  
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nirvan
	 */
	public class gridHex
	{
		[Embed(source = "../assets/cellc.png")] private const img:Class;
		public var parent:int;
		public var F:int;
		public var G:int;
		public var H:int;
		public var status:int;
		public var value:int;
		public var image:Image;
		
		public function gridHex(parent:int, x:int, y:int)
		{
			this.parent = parent;
			//dir = 0;
			F = 0;
			G = 0;
			H = 0;
			status = 0;
			value = 0;
			image = new Image(img);
			image.x = x;
			image.y = y;
		}
		
		public function refresh(i:int, j:int):void
		{
			parent = i;
			F = 0;
			G = 0;
			H = 0;
			status = 0;
			if (j) value = 0;
		}
	}

}