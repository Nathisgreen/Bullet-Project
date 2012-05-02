package  
{
	import CutScenes.CutScenes1.CutScene1;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class HotSpot extends Entity 
	{
		[Embed(source = '../Assets/Fonts/comic.ttf', embedAsCFF = "false", fontFamily = "MyFont")]
		private const FONT_COMICSANS:Class;
		
		private var distance:int;
		private var objText:Text;
		private var showText:Boolean = false;
		
		private var cameraX:int = 0;
		private var cameraY:int = 0;
		
		private var canTalk:Boolean = true;
		private var canTimer:int = 200;
		private var canTime:int = 0;
		
		public function HotSpot(x:int, y:int, dist:int, txt:String, camX:int, camY:int) 
		{
			this.x = x;
			this.y = y;
			distance = dist;
			objText = new Text(txt);
			cameraX = camX;
			cameraY = camY;
			layer = -10000000000000
			Input.define("action", Key.DOWN);
		}
		
		override public function update():void 
		{
			if (distanceToPoint(LevelController.player.x, LevelController.player.y) < distance && LevelController.player.getActive() == true )
			{
				showText = true;
			}
			else
			{
				showText = false;
			}
			
			if (showText)
			{
				if (Input.check("down") && canTalk)
				{
					FP.camera.x = cameraX;
					FP.camera.y = cameraY;
					LevelController.player.setActive(false);
					var a:CutScene1 = new CutScene1();
					world.add(a);
					canTalk = false;
				}
			}
			
			if (canTalk == false)
			{
				if (canTime < canTimer)
				{
					canTime++;
				}
				else
				{
					canTalk = true;
					canTime = 0;
				}
			}
			
			
			
			super.update();
		}
		
		override public function render():void 
		{
			if (showText)
			{
				//Theres nothing like magic numbers
				objText.size =10;
				objText.color = 0x00000000;
				Draw.rect( LevelController.player.x - (objText.text.length*7)/2+8, LevelController.player.y-30, objText.text.length * 7, 20+((objText.text.length / 280) *70), 0x0ffffff, 0.8, false);
				Draw.graphic(objText,  LevelController.player.x - (objText.text.length*7)/2 + 11+8, LevelController.player.y-30)
				Draw.graphic(objText,  LevelController.player.x - (objText.text.length*7)/2 +9+8, LevelController.player.y-30)
				Draw.graphic(objText,  LevelController.player.x - (objText.text.length*7)/2+10+8,LevelController.player.y-31)
				Draw.graphic(objText,  LevelController.player.x - (objText.text.length*7)/2+10+8,LevelController.player.y-29)
				objText.color = 0xffffffff;
				objText.size = 10;
				Draw.graphic(objText,  LevelController.player.x - (objText.text.length*7)/2+10+8, LevelController.player.y-30)
				super.render();
			}
		}
		
		
	}

}