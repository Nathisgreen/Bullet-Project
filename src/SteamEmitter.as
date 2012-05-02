package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class SteamEmitter extends Entity 
	{
		private var partTimer:int = 5;
		private var partCount:int = 0;
		
		private var aDir:Point;
		
		
		private var particles:Array = new Array();
		//var steamPart:SteamPart = new SteamPart(0,0,new Point(0,0));
		
		private var hasCreated:Boolean = false;
		
		public function SteamEmitter(aX:int,  aY:int, aDirection:Point) 
		{
			x = aX;
			y = aY;
			aDir = aDirection;
		}
		
		override public function update():void 
		{
			if (partCount < partTimer)
			{
				partCount ++;
			}
			else
			{
				for each(var a:SteamPart in particles)
				{
					if (hasCreated == false)
					{
						if (a.isActive == false)
						{
							a.reset(x, y, aDir);
							hasCreated = true;
							trace("recycled")
						}
					}
				}
				
				if (hasCreated == false)
				{
					var b:SteamPart = new SteamPart(x, y , aDir)
					particles.push(b);
					world.add(b);
					trace("not recycled")
				}
					
				hasCreated = false;
				partCount = 0;
				trace("particles: " +particles.length);
			}
			
			super.update();
		}
		
		
	}

}