package  CutScenes.CutScenes1
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class Flash extends Entity 
	{
		private var timer:int = 0;
		private var recAlpha:Number = 1;
		private var switchFade:Boolean = false;
		
		public function Flash() 
		{
			layer = -1000000000;
			visible = true;
		}
		
		override public function update():void 
		{
			if (timer < 10)
			{
				timer++;
			}
			else
			{
				visible = false;
			}
			/*if (switchFade == false)
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
			}*/
			super.update();
		}
		
		override public function render():void 
		{
			Draw.rectPlus(FP.camera.x, FP.camera.y, 320, 240,  0xFFFFFF, recAlpha, true,1,0);
			super.update();
		}
		
	}

}