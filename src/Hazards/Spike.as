package  Hazards
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class Spike extends Entity 
	{ 
		public var sprSpike:Spritemap = new Spritemap(GC.SPR_SPIKE, 16, 16);
		
		public function Spike(x:int, y:int, spikeType:int) 
		{
			this.x = x;
			this.y = y;
			
			type = GC.TYPE_SPIKE;
			graphic = sprSpike
			layer = -1;
			
			sprSpike.originX = 8;
			sprSpike.originY = 8;
			sprSpike.x = 8
			sprSpike.y = 8;
			
			if (spikeType == 0)
			{
			setHitbox(12, 4,-2,-12);
			}
			
			//right
			if (spikeType == 1)
			{
			setHitbox(4, 12,-12,-2);
			sprSpike.angle = 90;
			}
			
			//top
			if (spikeType == 2)
			{
			setHitbox(12, 4,-2);
			sprSpike.angle = 180;
			}
			
			//left
			if (spikeType == 3)
			{
			setHitbox(4, 12,0,-2);
			sprSpike.angle = 270;
			}
			
		}
		
	}

}