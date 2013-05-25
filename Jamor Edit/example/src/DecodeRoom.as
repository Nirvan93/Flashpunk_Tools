package  
{
	import flash.globalization.LastOperationStatus;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Danish Goel
	 */
	public class DecodeRoom extends World 
	{
		
		// loaded counter
		private var txtLoader:Text;
        private var txt:Text;
		// if loading done
		public static var loaded:Boolean = false;
		
		// called once world is switched to this one
		override public function begin():void 
		{
			trace('decoding images');
			
			// start loading!
			new OctetStreamBitmapDecoder(DATA,
				// set loaded flag to true on complete
					function ():void { loaded = true; },//TransparentJpeg.processAssetsClass(GC);
				
				// exclude JPG_ and SND_ prefixed constants
				new RegExp("^(?!JPG_|SND_).*$"),
				
				// show loading progress
				function (done:Number):void {
				}
			);
		}
		
		override public function update():void 
		{
			
			// if minimum screen time elapsed and all images loaded go to image display
			
			if (loaded)
			{
				trace("Decoding compleated");
				FP.world = new LevelWorld;
			}		
			
			super.update();
		}
		
	}

}