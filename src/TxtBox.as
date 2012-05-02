package 
{
	import flash.text.Font;
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
	public class TxtBox extends Entity 
	{
		[Embed(source = '../Assets/Fonts/comic.ttf', embedAsCFF = "false", fontFamily = "MyFont")]
		private const FONT_COMICSANS:Class;
		
		private var distance:int;
		private var objText:Text;
		private var showText:Boolean = false;
		private var displayText:Text  = new Text("");
		
		private var counter:int = 0;
		
		private var textTimer:int = 0;
		private var textSpeed:int = 1;
		
		public var allShown:Boolean = false;
		
		public function TxtBox(x:int, y:int, dist:int, txt:String ) 
		{
			this.x = x;
			this.y = y;
			distance = dist;
			
			objText = new Text(txt);
			
			displayText.text = objText.text;
			displayText.wordWrap = true;
			displayText.width = 280;
			displayText.font = "MyFont"
			displayText.text = "";
			Input.define("action", Key.DOWN);
			layer = -10000000000000;
		}
		
		override public function update():void 
		{
			if (distanceToPoint(LevelController.player.x, LevelController.player.y) < distance)
			{
				showText = true;
			}
			else
			{
				showText = false;
				displayText.text = "";
				counter = 0;
			}
			
			if (showText == true)
			{
				if (displayText.text.length < objText.text.length)
				{
					if (textTimer < textSpeed)
					{
						textTimer ++
					}
					else
					{
						displayText.text += objText.text.charAt(counter);
						counter++
						textTimer = 0;
					}
				}
			}
			else
			{
				allShown = false;
			}
			
			if (displayText.text== objText.text)
			{
				allShown = true;
			}
			
			if (Input.pressed("action"))
			{
				if (allShown == false)
				{
					showAllText();
				}
			}
			super.update();
		}
		
		public function showAllText():void
		{
			displayText.text = objText.text;
			allShown = true;
		}
		
		override public function render():void 
		{
			if (showText)
			{
				displayText.size =11;
				displayText.color = 0x00000000;
				Draw.rect( FP.camera.x + 1, FP.camera.y + 10, 318, 20+((objText.text.length / 280) *70), 0x0ffffff, 0.8, false);
				Draw.graphic(displayText, FP.camera.x + 1, FP.camera.y + 10)
				Draw.graphic(displayText, FP.camera.x - 1, FP.camera.y + 10)
				Draw.graphic(displayText, FP.camera.x, FP.camera.y + 11)
				Draw.graphic(displayText, FP.camera.x, FP.camera.y + 9)
				displayText.color = 0xffffffff;
				displayText.size = 11;
				Draw.graphic(displayText, FP.camera.x, FP.camera.y + 10)
				super.render();
			}
		}
		
	}

}