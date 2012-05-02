package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class Recharger  extends Entity
	{
		public var sprRecharger :Spritemap = new Spritemap(GC.SPR_RECHARGER, 32, 32);
		
		private var aEffect:RechargerEffect = new RechargerEffect(0, 0);
		//public var sprRechargerEffect :Spritemap = new Spritemap(GC.SPR_RECHARGEREFFECT, 32, 32);
		private var aBool:Boolean = false;
		
		public function Recharger(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			aEffect.x = x;
			aEffect.y = y;
			
			type = GC.TYPE_FUELCAN;
			graphic = sprRecharger;
			layer = -1;
			
			setHitbox(32, 32, 0, 0);
		}
		
		override public function update():void 
		{
			if (aBool == false)
			{
				world.add(aEffect);
				aBool = true;
			}
			
			if (collide(GC.TYPE_PLAYER, x, y))
			{
				LevelController.fuelBar.addFuel(20);
			}
			
			super.update();
		}
		
	}

}