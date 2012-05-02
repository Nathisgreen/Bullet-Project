package  Hazards.Lazers
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
			
	public class LazerHoz extends Entity
	{
		public var sprLazerTop:Image = new Image(GC.SPR_LAZER_TOP, new Rectangle(0, 0, 16, 16));
		
		private var onTime:int;
		private var offTime:int;
		private var lineLength:int;
		
		private var timer0:int = 0;
		
		private var timerOn:int = 0;
		private var timerOff:int = 0;
		public var on:Boolean = true;
		//if its always on
		private var constant:String;
		
		private var pointArray:Array = [];
		private var pointArraya:Array = [];
		
		private var offset:int = 1;
		private var hasLenght:Boolean = false;
		
		private var startDelay:int;
		
		//for rendering
		private var ii:int = 0;
		
		private var imageCount:int = 0;
		private var bitmapArray:Array = new Array();
		private var imageArray:Array = new Array();
		private var done:Boolean = false;
		private var switchTime:int = 0;
		
		
		public function LazerHoz(x:int,y:int,aOnTime:int,aOffTime:int,aConstant:String, delay:int) 
		{
			constant = aConstant;
			this.x = x;
			this.y = y;
			onTime = aOnTime;
			offTime = aOffTime;
			startDelay = delay;
			type = GC.TYPE_LAZER;
			graphic = sprLazerTop;
			lineLength = 0;
			addPointsArray();
			allocateX();
			setHitbox(lineLength, 8, 0, -4)
			sprLazerTop.angle = 90;
			sprLazerTop.originX = 16
			layer = -1;
		}
		
		override public function update():void
		{	
			if (hasLenght == false)
			{
				autoLength();
			}
			
			if (timer0 < 5)
			{
				timer0++
			}
			else
			{
				//make the electricty change
				timer0 = 0;
				switchTime++
				if (switchTime > 6)
				{
					switchTime = 0;
				}
			}
			
			if (constant == "false")
			{
				if (on == true)
				{
					if (timerOn < onTime + startDelay)
					{
						timerOn++
					}
					else
					{
						startDelay = 0;
						timerOn = 0;
						on = false;
					}
				}
				else
				{
					if (timerOff < offTime)
					{
						timerOff++
					}
					else
					{
						timerOff = 0;
						on = true;
					}
				}
			}
		}
		
		override public function render():void
		{
			if (done == false && hasLenght == true )
			{
				Draw.setTarget(bitmapArray[imageCount] , new Point(x, y));
				allocateX();
				ii = 0;
				for each (var i:Point in pointArray)
				{
					if (ii == 0)
					{
						Draw.linePlus(this.x + 4, y + 8, i.x, i.y, 0x770505, 1)
					}
					else
					{
						Draw.linePlus(i.x, i.y, pointArray[ii - 1].x, pointArray[ii - 1].y, 0x770505, 1)
					}
					ii++;
				}
				
				ii = 0;
				for each (var ia:Point in pointArraya)
				{
					if (ii == 0) 
					{
						Draw.linePlus(this.x + 4, y + 8, ia.x, ia.y, 0xD10909, 1)
					}
					else
					{
						Draw.linePlus(ia.x, ia.y, pointArraya[ii - 1].x, pointArraya[ii - 1].y, 0xD10909, 1)
					}
					ii++;
				}
				imageArray[imageCount] = new Image(bitmapArray[imageCount]);
				Draw.resetTarget();
			}
			
			if (done == true && on == true)
			{
				Draw.graphic(imageArray[switchTime], x, y);
			}
			
			if (done == false && hasLenght == true)
			{
				if (imageCount < 6)
				{
					imageCount ++;
				}
				else
				{
					if (done == false)
					{
						done = true;
					}
					imageCount = 0;
				}
			}
			super.render();
		}
		
		//add points to arrays
		private function addPointsArray():void
		{
			for (var i:int = 0; i < 10; i++)
			{
				pointArray.push(new Point(x, y));
				pointArraya.push(new Point(x, y));
			}
		}
		
		//work out the spacing for the gap
		private function allocateY():void
		{
			var space:Number;
			space = lineLength / 10;	
			var ii:int = 1;
			
			for each (var i:Point in pointArray)
			{
				i.x = this.x +(ii * space);
				ii ++;
			}
			
			ii = 1;
			for each (var ia:Point in pointArraya)
			{
				ia.x = this.x +(ii * space);
				ii ++;
			}
		}
		
		//randomize the x positions
		private function allocateX():void
		{
			for each (var i:Point in pointArray)
			{
				i.y = this.y+8 + randomNumber( -5, 5);
			}
			for each (var ia:Point in pointArraya)
			{
				ia.y = this.y+8 + randomNumber( -5, 5);
			}
		}
		
		private function autoLength():void
		{
			while (lineLength == 0)
			{
				if (!collide(GC.TYPE_LEVEL, x+offset, y))
				{
					offset += 16;
				}
				else
				{
					lineLength = offset;
					hasLenght = true;
					allocateY();

					setHitbox(lineLength, 8, 0, -4)
					for (var i:int = 0; i < 7; i++)
					{
						bitmapArray[i] = new BitmapData(lineLength, 16, true, 0x00000000);
					}
				}	
			}
			
		}
		
		//found on the interwebs
		private function randomNumber(low:int=0, high:int=1):int
		{
			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		
		public function getOn():Boolean
		{
			return on;
		}
	}

}
