package  
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class OpeningWallHoz extends Entity 
	{
		
		public function OpeningWallHoz(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			type = GC.TYPE_LEVEL;
			setHitbox(16, 16);
		}
		
		override public function update():void 
		{
			if (LevelController.openingBlocksOff == false)
			{

			}
			else
			{
				type = GC.TYPE_NOT_SOLID;
			}
			super.update();
		}
		
	}

}