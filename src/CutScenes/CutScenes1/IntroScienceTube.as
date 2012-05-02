package  CutScenes.CutScenes1
{
	import flash.accessibility.Accessibility;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class IntroScienceTube extends Entity 
	{
		
		private var isTalking:Boolean = true;
		private var isExcited:Boolean = false;
		private var jump:Boolean = false;
		private var randInt:int = 0;
		private var showRobo:String
		private var hitCount:int = 0;
		private var timer0:int = 0;
		private var timer1:int = 0;
		
		public var shouldMove:Boolean = false;
		private var hasMoved:Boolean = false;
		private var startY:int;
		
		public var sprIntroScienceTube :Spritemap = new Spritemap(GC.SPR_SCIENCETUBE, 32, 80);
		public var sprIntroScienceTubeBreak :Spritemap = new Spritemap(GC.SPR_SCIENCETUBEBREAK, 32, 80);
		public var sprPlayer1:Spritemap = new Spritemap(GC.SPR_PLAYER, 16, 16);
		
		public function IntroScienceTube(x:int, y:int,show:String ) 
		{
			this.x = x;
			this.y = y;
			startY = y;
			
			if (show == "true")
			{
				graphic = sprIntroScienceTube;
				layer = -1;
			}
			else
			{
				sprIntroScienceTubeBreak.add("animation", [0, 1, 2, 3, 4, 5], 0, false);
				sprIntroScienceTubeBreak.play("animation");
				graphic = sprIntroScienceTubeBreak;
				layer = -4;
			}
			type = GC.TYPE_LEVEL;
			showRobo = show;
			sprPlayer1.add("stand", [0], 0, false);
			sprPlayer1.play("stand");
			setHitbox(32, 5,0,-8)
		}
		
		override public function update():void 
		{
			if (shouldMove)
			{
				if (hasMoved == false)
				{
					if (y > startY - 50)
					{
						y -= 1;
					}
					else
					{
						hasMoved = true;
					}
				}
				
			}
			super.update();
		}
		
		override public function render():void 
		{
			if (showRobo == "true")
			{
			Draw.graphic(sprPlayer1,x+8,y+48)
			}
			super.render();
		}
		
		public function hitWall():void
		{

				if (hitCount % 4 == 0)
				{
					if (sprIntroScienceTubeBreak.index < 5)
					{
						sprIntroScienceTubeBreak.index++;
						
						if (sprIntroScienceTubeBreak.index == 5)
						{
							LevelController.openingBlocksOff = true;
							layer = -1;
							world.add(new Flash());
						}
					}
				}
				hitCount++;
		}
		
		
		
	}

}