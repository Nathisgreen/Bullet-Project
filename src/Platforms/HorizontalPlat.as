package  Platforms
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key
	
	public class HorizontalPlat extends Entity 
	{
		public var sprPlat:Spritemap = new Spritemap(GC.SPR_MOVINGPLATFORM, 32, 8);
		public var xSpeed:int = 50;
		public var _collideTypes:Array = new Array(GC.TYPE_LEVEL, GC.TYPE_INVISIBLESOLID);
		public var startPosition:Point;
		public var on:Boolean;
		public var ID:int;
		public var targetID:int;
		public var isStatic:String;
		public var start_xSpeed:int;
		
		public function HorizontalPlat(x:int, y:int,stat:String, oID:int,oTargetID:int, startDir:int) 
		{
			this.x = x;
			this.y = y;
			startPosition = new Point(x, y);
			ID = oID;
			targetID = oTargetID;
			isStatic = stat;
			start_xSpeed = xSpeed;
			
			if (startDir == 1)
			{
				start_xSpeed = -xSpeed;
				xSpeed = -xSpeed;
			}
			
			if (isStatic == "true")
			{
				on = false;
			}
			else
			{
				on = true;
			}
			
			type = GC.TYPE_HOZPLAT;
			graphic = sprPlat;
			layer = -1;
			
			setHitbox(32, 2);
		}
		
		override public function update():void 
		{
			if (LevelController.player.getState() == "robot")
			{
				if (!Input.check(Key.DOWN))
				{
					if (LevelController.player.y + LevelController.player.height -1 < this.y)
					{
						type = GC.TYPE_HOZPLAT;
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
			

			if (collideTypes(_collideTypes, x + (xSpeed* FP.elapsed), y))
			{
				xSpeed = -xSpeed;
			}

			
			if (on == true)
			{
				x += Math.round(xSpeed * FP.elapsed);
			}
			
			super.update();
		}
		
		public function turnOn():void
		{
			on = true;
			if (targetID != 0)
			{
				for each(var platObject:HorizontalPlat in LevelController.platformList)
				{
					if (platObject.ID == targetID)
					{
						platObject.on = true;
					}
				}
			}
		}
		
	}

}