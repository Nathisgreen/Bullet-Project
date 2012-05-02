package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class SteamPart extends Entity 
	{
		public var sprSteam:Spritemap = new Spritemap(GC.SPR_STEAMPART, 24, 24);
		public var direction:Point;
		public var scale:Number = 0.5;
		public var alpha:Number = 1;
		
		public var fadeFast:Boolean = false;
		private var growthTimer:int = 5;
		private var growthCount:int = 0;
		
		private var diffX:int;
		private var diffY:int;
		
		public var isActive:Boolean = true;
		
		public function SteamPart(aX:int, aY:int, aDirection:Point ) 
		{
			isActive = true;
			x = aX;
			y = aY;
			direction = aDirection;
			sprSteam.alpha = alpha;
			sprSteam.scaleX = scale;
			sprSteam.scaleY = scale;
			graphic = sprSteam;
			setHitbox(24, 24);
			layer = -1;
			diffX = (((Math.random() *2) -1.5 ) *1.1)
			diffY = (( (Math.random() * 2) -1.5) * 1.1)
		}
		
		override public function update():void 
		{
			if (isActive)
			{
				direction.normalize(1);
				x += direction.x + (diffX)/8
				y += direction.y + (diffY)/8
				
				if (growthCount < growthTimer) { growthCount ++ } else
					{
					growthCount  = 0;
					scale += 0.1;
					}
				sprSteam.scaleX = scale;
				sprSteam.scaleY = scale;
				sprSteam.alpha = alpha;
				
				alpha -= 0.015
				if (alpha < 0.1)
				{
					//world.remove(this);
					isActive = false;
				}
				
				if (fadeFast)
				{
					alpha -= 0.015;
				}
				
				if (collide(GC.TYPE_PLAYER, x, y) )
				{
					diffX = LevelController.player.getSpeed().x*5;
					diffY = LevelController.player.getSpeed().y*5;
					fadeFast = true;
				}
				
				super.update();
			}
		}
		
		override public function render():void 
		{
			if (isActive)
			{
			super.render();
			}
		}
		
		public function reset(xx:int, yy:int, aPoint:Point):void
		{
			x = xx;
			y = yy;
			direction  = aPoint;
			
			scale = 0.5;
			alpha = 1;
			
			sprSteam.alpha = alpha;
			sprSteam.scaleX = scale;
			sprSteam.scaleY = scale;
		
			diffX = (((Math.random() * 2) -1.5 ) * 1.1)
			diffY = (((Math.random() * 2) -1.5 ) * 1.1)
			
			fadeFast = false;

			isActive = true;
		}
		
	}

}