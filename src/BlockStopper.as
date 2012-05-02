package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class BlockStopper extends Entity 
	{
		//public var sprStopper:Spritemap = new Spritemap(GC.SPR_BLOCK, 16, 16);
		
		public function BlockStopper(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			type = GC.TYPE_INVISIBLESOLID;
			//graphic = sprStopper;
			setHitbox(15, 15);
			visible = false;
		}
		
	}

}