package  Grids
{
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class RobotBlockGrid extends Entity 
	{
		public var _tiles:Tilemap;
		private var _grid:Grid;
		public var LevelData:XML;
		
		public function RobotBlockGrid(xml:Class) 
		{
			_tiles = new Tilemap(GC.TILE_FOREGROUND, 2560, 1920, 16, 16);
			graphic = _tiles;
			layer = -5;
			
			_grid = new Grid(2560, 1920, 16, 16, 0, 0);
			mask = _grid;
			
			type = GC.TYPE_NOT_SOLID;
			
			loadLevel(xml);
		}
		
		private function loadLevel(xml:Class):void
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			LevelData = new XML (dataString);
			var dataList:XMLList;
			var dataElement:XML;
			
			dataList = LevelData.LForeGroundTiles.tile;
			for each (dataElement in dataList)
			{
				_tiles.setTile(int(dataElement.@x) / 16, int(dataElement.@y) / 16, int (((dataElement.@tx ) / 16) + (dataElement.@ty)/16 * 10)); // * 10 because 10 tiles per row
				//add collision to grid here
				_grid.setTile(int(dataElement.@x) / 16, int(dataElement.@y) / 16, true);
			}
			
		}
	}

}