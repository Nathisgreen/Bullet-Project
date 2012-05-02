package  Hazards.Turret
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class TurretBullet extends Entity 
	{
		public var sprTurretBullet :Spritemap = new Spritemap(GC.SPR_TURRET_BULLET, 5, 5);
		
		private var _speed:int;
		private var _direction:Point = new Point();
		private var _startPosition:Point = new Point();
		
		public function TurretBullet(x:int, y:int,direction:Point,speed:int) 
		{
			this.x = x;
			this.y = y;
			_startPosition.x = x;
			_startPosition.y = y;
			
			_direction.x = direction.x;
			_direction.y = direction.y;
			_direction.normalize(1);
			_speed = speed;
			
			type = GC.TYPE_NOT_SOLID;
			graphic = sprTurretBullet;
			layer = 0;
			
			sprTurretBullet.originX = 2.5;
			sprTurretBullet.originY = 2.5;
			visible = false;
			
			setHitbox(5, 5);
			
		}
		
		override public function update():void 
		{
			x += -_direction.x * _speed * FP.elapsed;
			y += -_direction.y * _speed * FP.elapsed;
			
			if (collide(GC.TYPE_LEVEL, x, y) && visible == true)
			{
				world.remove(this);
			}
			
			if (_startPosition.x - x > 14 || _startPosition.x - x < -14 && visible == false)
			{
				visible = true;
			}
			
			if (_startPosition.y - y > 14 || _startPosition.y - y < -14 && visible == false)
			{
				visible = true;
			}
			
			super.update();
		}
		
	}

}