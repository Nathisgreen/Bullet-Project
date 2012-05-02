package  Hazards
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class GravityGrabber extends Entity
	{
		public var sprGrabber:Spritemap = new Spritemap(GC.SPR_GRABBER, 16, 16);
		public var isActive:Boolean = false;
		private var _position:Point;
		private var _playerPosition:Point;
		private var _direction:Point = new Point(0,0);
		private var _text:Text;
		
		public function GravityGrabber(x:int, y:int) 
		{
			
			graphic = sprGrabber;
			layer = -1;
			type = GC.TYPE_GAVITY_GRABBER;
			this.x = x + sprGrabber.width/2;
			this.y = y + sprGrabber.height / 2;
			sprGrabber.x =  - sprGrabber.width / 2;
			sprGrabber.y =  - sprGrabber.height / 2;
			setHitbox(100, 100, 50,  50);
		}
		
		override public function update():void 
		{
			_direction.x = x - LevelController.player.x;
			_direction.y = y - LevelController.player.y;

			super.update();
		}
		
		override public function render():void 
		{
			super.render();
			//Draw.resetTarget();
			if (LevelController.player.getState() == "bullet")
			{
				if (isActive)
				{
					Draw.line(x, y, LevelController.player.x + 4, LevelController.player.y + 4, 0x00000000f);
				}
			}
		}
		
	}

}