package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class RechargerEffect extends Entity
	{
		public var sprRechargerEffect :Spritemap = new Spritemap(GC.SPR_RECHARGEREFFECT, 32, 32);
		
		public function RechargerEffect(x:int , y:int) 
		{
			this.x = x;
			this.y = y;
			
			layer = -4;
			
			sprRechargerEffect.add("animation", [0, 1, 2, 3, 4, 5], 7,true);
			sprRechargerEffect.play("animation");
			
			graphic = sprRechargerEffect;
		}
		
		override public function update():void 
		{
			sprRechargerEffect.update();
			super.update();
		}
		
	}

}