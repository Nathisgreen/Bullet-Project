package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class FuelBar extends Entity 
	{
		private var maxFuel:int = 100;
		private var fuel:Number = 1;
		
		public function FuelBar() 
		{
			layer = -10;
		}
		
		override public function update():void 
		{
			if (fuel > 100) { fuel = 100; }
			super.update();
		}
		
		override public function render():void 
		{
			//Draw.rect(world.camera.x +250, world.camera.y +210, 50, 10, 0x00000000f, 1, true)
			Draw.rectPlus(world.camera.x +200, world.camera.y +210, 100, 10, 0x00000000f, 1, false, 1, 0)
			Draw.rectPlus(world.camera.x +199, world.camera.y +209, 102, 12, 0xfffffffff, 1, false, 1, 0)
			Draw.rectPlus(world.camera.x +198, world.camera.y +208, 104, 14, 0x00000000f, 1, false, 1, 0)
			if (fuel > 10)
			{
				Draw.rectPlus(world.camera.x +201, world.camera.y +211, fuel - 1, 9, 0xFFFF00, 1, true, 1, 0)
			}
			else
			{
				Draw.rectPlus(world.camera.x +201, world.camera.y +211, fuel - 1, 9, 0xA31232, 1, true, 1, 0)
			}
			super.render();
		}
		
		public function subtractFuel(ammount:Number):void
		{
			if (fuel - ammount > 1)
			{
			fuel -= ammount;
			}
			else
			{
				fuel = 1;
			}
		}
		
		public function addFuel(ammount:Number):void
		{
			fuel += ammount;
		}
		
		public function setFuel(ammount:Number):void
		{
			fuel = ammount;
		}
		
		public function getFuel():Number
		{
			return fuel;
		}
		
	}

}