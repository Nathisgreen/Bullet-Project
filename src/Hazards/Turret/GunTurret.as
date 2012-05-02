package  Hazards.Turret
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class GunTurret extends Entity 
	{
		public var sprTurretBase:Spritemap = new Spritemap(GC.SPR_TURRET_BASE, 16, 16);
		public var sprTurretGun:Spritemap = new Spritemap(GC.SPR_TURRET_GUN, 5, 26);
		
		private var _turretAngle:Number = 0;
		private var _turretPosition:Point
		private var _playerPosition:Point = new Point();
		private var _playerDirection:Point = new Point();
		
		private var _shootTime:int;
		private var _bulletSpeed:int;
		private var _bulletTimer:int = 0;;
		
		public function GunTurret(x:int, y:int,shootTime:int,bulletSpeed:int) 
		{
			this.x = x;
			this.y = y;
			
			_shootTime = new int(shootTime);
			_bulletSpeed = new int(bulletSpeed);
			
			type = GC.TYPE_LEVEL;
			graphic = sprTurretBase
			layer = 0;
			
			sprTurretGun.originX = 3;
			sprTurretGun.originY = 15;
			sprTurretGun.smooth = true;
			
			setHitbox(16, 16);
			
			_turretPosition = new Point(this.x, this.y);
		
		}
		
		override public function update():void 
		{
			_playerPosition.x = LevelController.player.x;
			_playerPosition.y = LevelController.player.y;
			
			_playerDirection.x = _turretPosition.x - LevelController.player.x;
			_playerDirection.y = _turretPosition.y - LevelController.player.y;
			
			sprTurretGun.angle = Math.atan2(_playerDirection.x,_playerDirection.y) * (180 / Math.PI);
			
			if (_bulletTimer < _shootTime)
			{
				_bulletTimer ++;
			}
			else
			{
				_bulletTimer = 0;
				shootBullet();
			}
			
			super.update();
		}
		
		override public function render():void 
		{
			super.render();
			Draw.graphic(sprTurretGun, x +(sprTurretBase.width/2), y + (sprTurretBase.scaledHeight/2));
		}
		
		private function shootBullet():void
		{
			var bullet:TurretBullet = new TurretBullet(x+sprTurretBase.width/2, y+sprTurretBase.height/2, _playerDirection, _bulletSpeed);
			world.add(bullet);
		}
	}

}