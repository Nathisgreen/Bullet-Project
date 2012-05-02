package  
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
	public class CheckPoint extends Entity 
	{
		[Embed(source = '../Assets/Fonts/comic.ttf', embedAsCFF = "false", fontFamily = "MyFont")]
		private const FONT_COMICSANS:Class;
		
		private var objText:Text;
		private var displayText:Text  = new Text("");
		private var displayText1:Text  = new Text("");
		private var displayText2:Text  = new Text("");
		
		private var delay:int = 0;
		
		private var index:int = 0;
		
		public var sprCheckPoint:Spritemap = new Spritemap(GC.SPR_CHECKPOINT, 7, 32);
		private var position:Point;
		
		private var hasActivated:Boolean = false;
		
		public function CheckPoint(x:int,y:int) 
		{
			this.x = x;
			this.y = y;
			position = new Point(x, y);
			graphic = sprCheckPoint;
			layer = -1;
			
			objText = new Text("Check Point!");
			displayText.text = objText.text;
			displayText.wordWrap = true;
			displayText.width = 280;
			displayText.font = "MyFont"
			displayText.text = "";
			
			displayText1.text = objText.text;
			displayText1.wordWrap = true;
			displayText1.width = 280;
			displayText1.font = "MyFont"
			displayText1.text = "";
			
			displayText2.text = objText.text;
			displayText2.wordWrap = true;
			displayText2.width = 280;
			displayText2.font = "MyFont"
			displayText2.text = "";
		}
		
		override public function update():void 
		{
			if (distanceToPoint(LevelController.player.x, LevelController.player.y) < 40)
			{
				LevelController.player.setStartPosition(position);
				sprCheckPoint.color = 0x1CBC37;
				hasActivated = true;
			}
			
			if (hasActivated)
			{
				if (delay < 6)
				{
					delay ++;
				}
				else
				{
					displayText.text = objText.text.charAt(index);
					if ( index - 1 > 0)
					{
						displayText1.text = objText.text.charAt(index-1);
					}
					else
					{
						displayText1.text = objText.text.charAt(0);
					}
					if ( index - 2 > 0)
					{
						displayText2.text = objText.text.charAt(index-2);
					}
					else
					{
						displayText2.text = objText.text.charAt(0);
					}
					
					delay = 0;
					index++;
				}
			}
			
			super.update();
		}
		
		override public function render():void 
		{
			displayText.color = 0x009900;
			displayText.size = 11;
			Draw.graphic (displayText, (x - 20) + index * 3, y - 15)
			
			displayText1.color = 0x009900;
			displayText1.size = 10;
			displayText1.alpha = 0.6;
			if (index - 1 > 0) {
				Draw.graphic (displayText1, (x - 20) + (index-1) * 2.8, y - 15)	
			}
			else
			{
				Draw.graphic (displayText1, (x - 10) + (0) * 2.8, y - 15)
			}
			
			displayText2.color = 0x309900;
			displayText2.size = 9;
			displayText2.alpha = 0.3;
			if (index - 2 > 0) {
				Draw.graphic (displayText2, (x - 20) + (index-2) * 2.6, y - 15)	
			}
			else
			{
				Draw.graphic (displayText2, (x - 20) + (0) * 2.6, y - 15)
			}
			
			super.render();
		}
		
	}

}