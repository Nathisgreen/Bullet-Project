package 
{	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(320, 240,60,false);
			FP.screen.scale = 2;
			FP.screen.color = 0x000000;
			FP.console.enable();
		}
		
		override public function init():void 
		{
			super.init();
			FP.world = new LevelController();
		}
		
	}
	
}