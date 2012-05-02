package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class FuelCan extends Entity 
	{
		public var sprFuel :Spritemap = new Spritemap(GC.SPR_FUELCAN, 16, 16);
		
		public function FuelCan(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			
			sprFuel.add("animation", [0, 1, 2, 3], 3, true);
			sprFuel.play("animation");
			
			type = GC.TYPE_FUELCAN;
			graphic = sprFuel
			layer = -1;
			
			setHitbox(16, 16);
		}
		
		override public function update():void 
		{
			if (collide(GC.TYPE_PLAYER, x, y) && visible == true )
			{
				LevelController.fuelBar.addFuel(20);
				visible = false;
			}
			sprFuel.update();
			
			super.update();
		}
		
	}

}