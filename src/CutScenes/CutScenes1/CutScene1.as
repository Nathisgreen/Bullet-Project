package CutScenes.CutScenes1
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class CutScene1 extends Entity 
	{
		private var aSciencetis:IntroSciencetis;
		private var aTube:IntroScienceTube;
		
		private var text1:TxtBox;
		private var text2:TxtBox;
		
		private var state:int = 0;
		
		private var hasShown0:Boolean = false;
		private var hasShown1:Boolean = false;
		private var hasShown2:Boolean = false;
		
		private var waitTimer:int = 0;
		private var waitTime:int = 60;
		
		public function CutScene1() 
		{
			Input.define("action", Key.ENTER);
			for (var i:int = 0; i < LevelController.SciencetisList.length; i++)
			{
				aSciencetis = LevelController.SciencetisList[i];
				if (aSciencetis.id == 0)
				{
					aSciencetis.isTalking = true;
				}
			}
		}
		
		override public function update():void 
		{
			if (state == 0)
			{
				if (hasShown0 == false)
				{
				text1 = new TxtBox(LevelController.player.x, LevelController.player.y, 20, "Oh no! x01134 has broken out of his tube! What should we do?!?");
				world.add(text1);
				hasShown0 = true;
				}
				
				if (text1.allShown == true)
				{
					if (waitTimer < waitTime)
					{
					waitTimer++
					}
					else
					{
						for (var i:int = 0; i < LevelController.SciencetisList.length; i++)
						{
							aSciencetis = LevelController.SciencetisList[i];
							if (aSciencetis.id == 0)
							{
								aSciencetis.isTalking = false;
							}
							if (aSciencetis.id == 1)
							{
								aSciencetis.isTalking = true;
							}
						}
						waitTimer = 0;
						state ++;
						trace(state);
					}
				}
			}
			if (state == 1)
			{
				if (hasShown1 == false)
				{
					world.remove(text1);
					text2 =  new TxtBox(LevelController.player.x, LevelController.player.y, 20, "We can't risk him escaping, raise the tubes and start destroy sequence!");
					world.add(text2);
					hasShown1 = true;
				}
				
				if (text2.allShown == true)
				{
					if (waitTimer < waitTime)
					{
					waitTimer++
					}
					else
					{
						for (var ii:int = 0; ii < LevelController.SciencetisList.length;ii++)
						{
							aSciencetis = LevelController.SciencetisList[ii];
							if (aSciencetis.id == 1)
							{
								aSciencetis.isTalking = false;
							}
						}
						
						waitTimer = 0;
						state ++;
						trace(state);
					}
				}
				if (state == 2)
				{
					if (hasShown2 == false)
					{
						world.remove(text2);
						hasShown0 = false;
						hasShown1 = false;
						hasShown2 = true;
						for (var iii:int = 0; iii < LevelController.TubeList.length; iii++)
						{
							aTube = LevelController.TubeList[iii];
							aTube.shouldMove = true;
						}
						LevelController.player.setActive(true);
						if (LevelController.alarmOn == false)
						{
							LevelController.alarmOn = true;
							world.add(new AlarmLight());
						}
						world.remove(this);
					}
				}
			}
		super.update();
		}
		
	}

}