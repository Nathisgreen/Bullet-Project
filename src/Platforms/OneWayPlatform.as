package  Platforms
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key
	
	public class OneWayPlatform extends Entity 
	{
		public var sprPlat:Spritemap = new Spritemap(GC.SPR_ONEWAY_PLAT, 16, 8);
		
		public function OneWayPlatform(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			
			type = GC.TYPE_LEVEL;
			graphic = sprPlat
			layer = 0
			
			setHitbox(16, 2);
		}
		
		override public function update():void 
		{
			if (LevelController.player.getState() == "robot")
			{
				if (!Input.check(Key.DOWN))
				{
					if (LevelController.player.y + LevelController.player.height -1 < this.y)
					{
						type = GC.TYPE_LEVEL;
					}
					else
					{
						sprPlat.color = 0xfffffff;
						type = GC.TYPE_NOT_SOLID;
					}
				}
				else
				{
					type = GC.TYPE_NOT_SOLID;
				}
			}
			else
			{
				if (FP.sign(LevelController.player.getYSpeed()) == 1)
				{
					if (LevelController.player.y + LevelController.player.height -1 < this.y)
					{
					type = GC.TYPE_LEVEL;
					}
				}
				else
				{
					sprPlat.color = 0xfffffff;
					type = GC.TYPE_NOT_SOLID;
				}
			}
					
			super.update();
		}
		
	}

}