package  
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class OpeningWallVert extends Entity 
	{
		private var hasCollided:Boolean = false;
		
		public function OpeningWallVert(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			type = GC.TYPE_LEVEL;
			setHitbox(26, 16,5,0);
		}
		
		override public function update():void 
		{
			if (LevelController.openingBlocksOff == false)
			{
				if (LevelController.OpeningTube != null)
				{
					if (collide(GC.TYPE_PLAYER, x+1, y) && !hasCollided)
					{
						LevelController.OpeningTube.hitWall();
						hasCollided = true;
					}
					
					if (!collide(GC.TYPE_PLAYER, x + 1, y) && hasCollided)
					{
						hasCollided = false;
					}
				}
			}
			else
			{
				type = GC.TYPE_NOT_SOLID;
			}
			super.update();
		}
		
	}

}