package  CutScenes.CutScenes1
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class AlarmLight extends Entity 
	{
		private var changeSpeed:Number = 0.03;
		private var recAlpha:Number = 0.2;
		private var switchFade:Boolean = false;
		
		public function AlarmLight() 
		{
			layer = -1000000000;	
		}
		
		override public function update():void 
		{
			if (switchFade == false)
			{
				if (recAlpha < 0.8)
				{
					recAlpha +=  changeSpeed;
				}
				else
				{
					switchFade = true;
				}
			}
			else
			{
				if (recAlpha > 0.2)
				{
					recAlpha -=  changeSpeed;
				}
				else
				{
					switchFade = false;
				}
			}
			super.update();
		}
		
		override public function render():void 
		{
			Draw.rectPlus(FP.camera.x, FP.camera.y, 320, 240,  0xA31232, recAlpha, true,1,0);
			super.update();
		}
		
	}

}