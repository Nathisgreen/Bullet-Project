/*things to remember
 * First time laser is seen in current level order is bad - unexpected and cant see it on causeing uknown death
 * 		-new obstacles need a level introduction
 * 		-laser need to be more visible
 * 
 * In first level the last platform with spinner stick should be made jumpable to exit
 * Game font is large and hard to read, blends with background
 *  need easier levels introducing rocket mode(lots of short ones that progressively get longer/harder
 * 
 * 
 * (idea)spinners should be vents, entire theme indoor factory sorta
 * (idea)this is game [inside the ventalage system] - start with robot escaping something trying
 * 											and climbing into vents
 *
 * 		-could do another game that continues each about 15-20 levels
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * */

package  
{
	import CutScenes.*;
	import CutScenes.CutScenes1.*;
	import flash.geom.Point;
	import Grids.*;
	import Hazards.*;
	import Hazards.Lazers.*;
	import Hazards.Turret.*;
	import Platforms.*;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Backdrop;

	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class LevelController extends World 
	{
		public static var restart:Boolean = false;		// if we should restart the current level
		public static var player:Player;
		public static var fuelBar:FuelBar = new FuelBar();
		public static var GravityList:Array = new Array();
		public static var FuelList:Array = new Array();
		public static var SciencetisList:Array = new Array();
		public static var TubeList:Array = new Array();
		public static var alarmOn:Boolean = false;
		public static var platformList:Array = new Array();
		private static var robotBlockGrid:RobotBlockGrid;
		private static var bulletBlockGrid:BulletBlockGrid;
		private static var bgPaper:Backdrop = new Backdrop(GC.BG_PAPER);
		
		public static var OpeningTube:IntroScienceTube;
		
		public var level:int = 1;
		public var levels:Array = new Array(GC.LVL_OPENINGTEST,GC.LVL_V21,GC.LVL_1,GC.LVL_LVL11,GC.LVL_Tutorial,GC.LVL_DEMO1,GC.LVL_teaser,GC.LVL_ONE);
		
		public static var openingBlocksOff:Boolean = false;
		
		public static var finished:Boolean = false;
		
		public function LevelController() 
		{
			super();
		}
		
		override public function begin():void 
		{
			loadLevel();
			super.begin();
		}
		
		override public function update():void 
		{
			if (restart == true) { restartLevel(); restart = false; }
			
			if (finished )
			{
					//if we are ready to go to the next level, go to it
					nextLevel();
			}
			
			if (player.getActive() == true)
			{
				FP.camera.x += Math.round(((player.x -FP.width/2) -FP.camera.x)/10);
				FP.camera.y += Math.round(((player.y -FP.height / 2) -FP.camera.y) / 10);
				//FP.camera.x = player.x - FP.width / 2;
				//FP.camera.y = player.y - FP.height / 2;
			}
			
			//FP.camera.x = player.x - FP.width / 2;
			//FP.camera.y = player.y - FP.height / 2;
			
			super.update();
		}
		
		public function loadLevel():void
		{
			GravityList.splice(0,GravityList.length)
			trace(GravityList.length)
			
			if (level > levels.length) { level = 1; }
			
			finished = false;
			
			//Make it so classes get passed the xml string instead of parsing the level
			//here and in the classes. Dont have time at the mo to do it
			var o:XML;
			//get the xml file of the level
			var file:ByteArray = new levels[level-1];
			var str:String = file.readUTFBytes(file.length);
			var xml:XML = new XML(str);
			
			//set of collision grids
			var baseGrid:Level = Level(add(new Level(levels[level-1])));
			robotBlockGrid = RobotBlockGrid(add(new RobotBlockGrid(levels[level-1])));
			bulletBlockGrid = BulletBlockGrid(add(new BulletBlockGrid(levels[level-1])));
			
			//set up objects
			if (level == 1)
			{
				
				for each (o in xml.LObjects[0].PlayerStart) 
				{
					var aX:int = o.@x;
					player = Player(add( new Player(aX+8, o.@y))); add(fuelBar);
				}
			}
			else
			{
				for each (o in xml.LObjects[0].PlayerStart) { player = Player(add( new Player(o.@x, o.@y))); add(fuelBar); }
			}
			for each (o in xml.LObjects[0].SpikeUp) { Spike(add(new Spike(o.@x, o.@y, 0))) }
			for each (o in xml.LObjects[0].SpikeLeft) { Spike(add(new Spike(o.@x, o.@y, 1))) }
			for each (o in xml.LObjects[0].SpikeDown) { Spike(add(new Spike(o.@x, o.@y, 2))) }
			for each (o in xml.LObjects[0].SpikeRight) { Spike(add(new Spike(o.@x, o.@y, 3))) }
			for each (o in xml.LObjects[0].OneWayPlat) { OneWayPlatform(add(new OneWayPlatform(o.@x, o.@y))) }
			for each (o in xml.LObjects[0].movingHPlat ) 
			{
				var platObj:HorizontalPlat;
				platObj = new HorizontalPlat(o.@x, o.@y,o.@Stationary,o.@ID,o.@Activate_ID,o.@StartDirection);
				add(platObj);
				platformList.push(platObj);
			}
			for each (o in xml.LObjects[0].Spinner) { SpinnerStick(add(new SpinnerStick(o.@x, o.@y, o.@Counter_Rotate, o.@Rotation_Speed))) }
			for each (o in xml.LObjects[0].Exit) { LevelExit(add(new LevelExit(o.@x, o.@y))) }
			for each (o in xml.LObjects[0].Turret) { GunTurret(add(new GunTurret(o.@x, o.@y, o.@Shoot_Speed, o.@Bullet_Speed)))}
			for each (o in xml.LObjects[0].lazorTop) { LazerTop(add(new LazerTop(o.@x, o.@y, o.@OnTime, o.@OffTime, o.@Constant, o.@StartDelay))) }
			for each (o in xml.LObjects[0].lazorHoz) {LazerHoz(add(new LazerHoz(o.@x, o.@y, o.@OnTime, o.@OffTime,o.@Constant, o.@StartDelay))) }
			for each (o in xml.LObjects[0].Fuel) 
			{
				var fuelObj:FuelCan;
				fuelObj = new FuelCan(o.@x, o.@y);
				add(fuelObj);
				FuelList.push(fuelObj);
			}
			for each (o in xml.LObjects[0].Grabber) 
			{
				var a:GravityGrabber;
				a = new GravityGrabber(o.@x, o.@y)
				add(a);
				GravityList.push(a);
			}
			for each (o in xml.LObjects[0].TextBox) { TxtBox(add(new TxtBox(o.@x, o.@y, o.@Distance, o.@Text))) }
			for each (o in xml.LObjects[0].checkPoint) { CheckPoint(add(new CheckPoint(o.@x, o.@y))) }
			for each (o in xml.LObjects[0].stopperBlock) { BlockStopper(add(new BlockStopper(o.@x, o.@y))) }
			for each (o in xml.LObjects[0].ogSciencetis)
			{ 
				var scienceObj:IntroSciencetis;
				scienceObj = new  IntroSciencetis(o.@x, o.@y,o.@ID,o.@facing);
				add(scienceObj)
				SciencetisList.push(scienceObj);
			}
			for each (o in xml.LObjects[0].ogScienceTube) 
			{
				var tubeObj:IntroScienceTube;
				tubeObj = new IntroScienceTube(o.@x, o.@y, o.@Display);
				if (o.@Display == false)
				{
					OpeningTube = tubeObj;
				}
				add(tubeObj)
				TubeList.push(tubeObj);
			}
			for each (o in xml.LObjects[0].hotSpot) { HotSpot(add(new HotSpot(o.@x, o.@y, o.@Distance, o.@DisplayText, o.@CameraX, o.@CameraY))) }
			for each (o in xml.LObjects[0].steamEmitter) {SteamEmitter(add(new SteamEmitter(o.@x, o.@y,new Point(o.@DirX,o.@DirY)))) }
			for each (o in xml.LObjects[0].fuelRecharger) { Recharger(add(new Recharger(o.@x, o.@y))) }
			for each (o in xml.LObjects[0].hiddenMedal) { Medal(add(new Medal(o.@x, o.@y))) }
			for each (o in xml.LObjects[0].openingWallVert) { OpeningWallVert(add(new OpeningWallVert(o.@x, o.@y))) }
			for each (o in xml.LObjects[0].openingWallHoz) { OpeningWallHoz(add(new OpeningWallHoz(o.@x, o.@y))) }
			FP.camera.x = player.x-150;
			FP.camera.y = player.y - 200;
			
			//addGraphic(Backdrop(bgPaper));
		}
		
		//remove all the entities, load the CURRENT level
		public function restartLevel():void
		{
			removeAll();
		}
		
		public function nextLevel():void
		{
			trace("level loaded");
			removeAll();
			level ++;
			loadLevel();
			finished = false;
		}
		
	}

}