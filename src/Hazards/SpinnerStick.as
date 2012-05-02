package  Hazards
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.masks.Pixelmask;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class SpinnerStick extends Entity 
	{
		public var sprSpinnerStick:Image;
		private var maskBmp:BitmapData;
		private var maskObj:Pixelmask;
		private var counterRotate:String;
		private var rotateSpeed:Number;
		
		public function SpinnerStick(x1:int, y1:int, rotateDir:String, aSpeed:Number) 
		{	
			sprSpinnerStick = new Image(GC.SPR_SPINNER_STICK)
			this.x = x1 + sprSpinnerStick.width/2;
			this.y = y1 + sprSpinnerStick.height / 2;	
			counterRotate = rotateDir;	
			rotateSpeed = aSpeed;
			type = GC.TYPE_SPIKE;
			layer = -1;
			sprSpinnerStick.centerOrigin()
			sprSpinnerStick.smooth = true;
			var size:int = Math.ceil(Math.sqrt(sprSpinnerStick.width * sprSpinnerStick.width + sprSpinnerStick.height * sprSpinnerStick.height));
			maskBmp = new BitmapData(size-8, size-8, true, 0);
			var offset:Point = new Point(size / 2, size / 2);
			maskObj = new Pixelmask(maskBmp, -offset.x +4, -offset.y+4);
			sprSpinnerStick.render(maskBmp, offset, FP.zero);
			
			super(x, y, sprSpinnerStick, maskObj);

		}
		
		override public function update():void 
		{
			if (counterRotate == "false")
			{
				angle(sprSpinnerStick.angle + rotateSpeed);
			}
			else
			{
				angle(sprSpinnerStick.angle - rotateSpeed);
			}
			
			if (collide(GC.TYPE_PLAYER, x, y))
			{
				LevelController.player.died();
			}
			
			super.update();
		}
		
		public function angle(value:Number):void 
		{
			sprSpinnerStick.angle = value;
			maskBmp.fillRect(maskBmp.rect, 0);
			FP.point.x = maskBmp.width / 2;
			FP.point.y = maskBmp.height / 2;
			sprSpinnerStick.render(maskBmp, FP.point, FP.zero);
		}
		
	}

}