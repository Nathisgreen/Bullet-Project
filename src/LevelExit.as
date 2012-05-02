package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class LevelExit extends Entity 
	{
		public var sprLevelExit:Spritemap = new Spritemap(GC.SPR_EXIT, 48, 48);
		private var _exitBack:Entity;
		private var _canOpen:Boolean = false;
		private var _aniSpeed:int = 3
		private var _count:int = 0;
		
		public function LevelExit(x:int, y:int) 
		{
			type = GC.TYPE_EXIT;
			graphic = sprLevelExit;
			this.x = x + sprLevelExit.width /2;
			this.y = y + sprLevelExit.height/2;
			layer = -1;
			sprLevelExit.frame = 0;
			sprLevelExit.x =  - sprLevelExit.width / 2;
			sprLevelExit.y =  - sprLevelExit.height /2;
			setHitbox(30, 30, 15, 6);
		}
		
		override public function update():void 
		{
			if (LevelController.finished == false)
			{
			doorAnimate();
			}
			super.update();
		}
		
		private function doorAnimate():void
		{
			
			if (distanceToPoint(LevelController.player.x, LevelController.player.y,false) < 80)
			{
				_canOpen = true;
			}
			else
			{
				_canOpen = false;
			}
			
			_count += 1
			if (_count == _aniSpeed)
			{
				if (_canOpen == true) 
				{
					if (sprLevelExit.frame < sprLevelExit.frameCount-1)
					{
						sprLevelExit.frame += 1;
					}
				}
				else
				{
					if (sprLevelExit.frame > 0)
					{
						sprLevelExit.frame -= 1;
					}
				}
				
				_count = 0;
			}
			
		}
		
	}

}