package  
{
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nirvan
	 */
	public class GV 
	{
		public static var gameSpeed:Number = 1;
		
		
		
		public static function SmoothValue(Actual:Number, New:Number, Speed:Number):Number
		{var val:Number = (Actual - New); if ( Math.abs(val)<.01*Speed ) return val; else return (val*FP.elapsed*60) / Speed;}
		
	}

}