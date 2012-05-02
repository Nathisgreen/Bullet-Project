package  CutScenes.CutScenes1
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class IntroSciencetis extends Entity 
	{
		public var sprIntroSciencetis :Spritemap = new Spritemap(GC.SPR_SCIENCETIS, 12, 42);
		
		public var isTalking:Boolean = false;
		private var isExcited:Boolean = false;
		private var jump:Boolean = false;
		private var randInt:int = 0;
		
		private var timer0:int = 0;
		private var timer1:int = 0;
		
		public var id:int = 0;
		
		private var faceDir:int;
		
		public function IntroSciencetis(x:int, y:int, aID:int, aFace:int) 
		{
			this.x = x;
			this.y = y;
			id = aID;
			graphic = sprIntroSciencetis;
			layer = -1;
			faceDir = aFace;
			
			sprIntroSciencetis.scaleX = faceDir;
			sprIntroSciencetis.add("Talking", [0, 1], 5, true);
			sprIntroSciencetis.add("Standing", [2], 5, true);
			sprIntroSciencetis.play("Standing");
		}
		
		override public function update():void 
		{
			super.update();
			if (isTalking == true)
			{
				sprIntroSciencetis.play("Talking")
				if (timer0 < 10)
				{
					timer0++;
				}
				else
				{
					randInt = FP.rand(10);
					if (randInt > 6)
					{
						if (jump == false)
						{
							jump = true;
							y -= 10;
						}
					}
				timer0 = 0;	
				}
				
				if (jump == true)
				{
					if (timer1 < 4)
					{
						timer1++
					}
					else
					{
						y += 10;
						jump = false;
						timer1 = 0;
					}
				
				}
			}
			else
			{
				if (jump)
				{
					y += 10;
					jump = false;
				}
				sprIntroSciencetis.play("Standing")
			}
		}
	}

}