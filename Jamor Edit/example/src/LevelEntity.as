package  
{
	import flash.utils.ByteArray;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	//	<width>1250</width>
	//	<height>500</height>
	
	/**
	 * ...
	 * @author Nirvan
	 */
	public class LevelEntity extends Entity 
	{
		public var tileset:Tilemap;
		public static var grid:Grid;
		public var levelfile:Class;
		
		public function LevelEntity(levelfile:Class) 
		{
			layer = 1;
			type = "solid";
			this.levelfile = levelfile;
		}
		
		override public function added():void 
		{
			loadMap(levelfile);
			super.added();
		}
		
      private function loadMap(xml:Class):void 
	  {
		//object voodoo (search the flashpunk forums for further explanation if needed)
		var rawData:ByteArray = new xml;
		var dataString:String = rawData.readUTFBytes(rawData.length);
		var xmlData:XML = new XML(dataString);
		var dataList:XMLList;
		var o:XML;
		 
		FP.width = xmlData.width;
		FP.height = xmlData.height;
         
		//reads the Tiles
		dataList = xmlData.tiles.objTile1;
		tileset = new Tilemap(DATA.TILES1, FP.width, FP.height, DATA.GRIDSIZE, DATA.GRIDSIZE);
		for each (o in dataList) tileset.setTile(int(o.@x), int(o.@y), int(o.@id) );
		graphic = tileset;
		
        //reads the level Grid
		grid = new Grid(FP.width, FP.height, DATA.GRIDSIZE, DATA.GRIDSIZE);
        grid.loadFromString(String(xmlData.grid), "");
		mask = grid;	
		
		dataList = xmlData.entities.player;
		for each (o in dataList) world.add(new Player(int(o.@x), int(o.@y) ));
         
      }
		
	}

}