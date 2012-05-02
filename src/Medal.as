package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class Medal extends Entity 
	{
		public var sprMedal :Spritemap = new Spritemap(GC.SPR_MEDAL, 16, 16);
		
		public function Medal(x:int,y:int) 
		{
			this.x = x;
			this.y = y;
			
			graphic = sprMedal;
			layer = -1;
			visible = false;
			setHitbox(16, 16);
		}
		
		override public function update():void 
		{
			if (collide(GC.TYPE_PLAYER, x, y) && visible == false)
			{
				visible = true;
			}
			
			super.update();
		}
		
	}

}