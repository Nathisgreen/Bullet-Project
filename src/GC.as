package  
{
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class GC 
	{
		//TileSets
		//base level tiles
		[Embed(source = '../Assets/TileSets/BarnTiles.png')]
		public static const TILE_GROUND1:Class;
		
		//robot block tiles
		[Embed(source = '../Assets/TileSets/foreTiles.png')]
		public static const TILE_FOREGROUND:Class;
		
		[Embed(source = '../Assets/TileSets/bulletTiles.png')]
		public static const TILE_BULLETBLOCKS:Class;
		
		
		//Levels
		[Embed(source = '../Assets/Levels/lvl_11.oel', mimeType = 'application/octet-stream')] 
		public static const LVL_LVL11:Class;
		
		[Embed(source = '../Assets/Levels/lvl_1.oel', mimeType = 'application/octet-stream')]
		public static const LVL_1:Class;
		
		[Embed(source = '../Assets/Levels/lvl_teaser1.oel', mimeType = 'application/octet-stream')]
		public static const LVL_teaser:Class;
		
		[Embed(source = '../Assets/Levels/lvl_tutorial.oel', mimeType = 'application/octet-stream')]
		public static const LVL_Tutorial:Class;
		
		/*[Embed(source = '../Assets/Levels/lvl_lazerTest.oel', mimeType = 'application/octet-stream')]
		public static const LVL_Tutorial1:Class;*/
		
		[Embed(source = '../Assets/Levels/Level_1.oel', mimeType = 'application/octet-stream')]
		public static const LVL_ONE:Class;
		
		[Embed(source = '../Assets/Levels/lvl_demo1.oel', mimeType = 'application/octet-stream')]
		public static const LVL_DEMO1:Class;
		
		[Embed(source = '../Assets/Levels/OpeningTest.oel', mimeType = 'application/octet-stream')]
		public static const LVL_OPENINGTEST:Class;
		
		[Embed(source = '../Assets/Levels/V2-1.oel', mimeType = 'application/octet-stream')]
		public static const LVL_V21:Class;
		
		//types
		public static const TYPE_LEVEL:String = "level"; //solid level blocks
		public static const TYPE_ROBOTBLOCK:String = "RobotBlock"; //robot blocks
		public static const TYPE_BULLETBLOCK:String = "BulletBlock"; //bullet blocks
		public static const TYPE_SPIKE:String = "Spike"; //bullet blocks
		public static const TYPE_NOT_SOLID:String = "NotSolid"; //bullet blocks
		public static const TYPE_PLAYER:String = "player";
		public static const TYPE_EXIT:String = "exit";
		public static const TYPE_GAVITY_GRABBER:String = "gravityGrabber";
		public static const TYPE_FUELCAN:String = "fuelCan";
		public static const TYPE_HOZPLAT:String = "horizontalPlat";
		public static const TYPE_LAZER:String = "lazer";
		public static const TYPE_INVISIBLESOLID:String = "invisSolid";
		
		//Sprites
		//Player Sprite
		[Embed(source = '../Assets/Sprites/sprPlayerRobot1.png')]
		public static const SPR_PLAYER:Class;
		
		//Bullet Sprite
		[Embed(source = '../Assets/Sprites/sprBullet1.png')]
		public static const SPR_BULLET:Class;
		
		//Spike Sprite
		[Embed(source = '../Assets/Sprites/sprSpike1.png')]
		public static const SPR_SPIKE:Class;
		
		//One way platform sprite
		[Embed(source = '../Assets/Sprites/sprOneWay.png')]
		public static const SPR_ONEWAY_PLAT:Class;
		
		//Spinner stick sprite
		[Embed(source = '../Assets/Sprites/sprSpinner1.PNG')]
		public static const SPR_SPINNER_STICK:Class;
		
		//Door sprite
		[Embed(source = '../Assets/Sprites/sprDoor3.png')]
		public static const SPR_EXIT:Class; 
		
		//Grabber sprite
		[Embed(source = '../Assets/Sprites/sprGrabber.png')]
		public static const SPR_GRABBER:Class;
		
		[Embed(source = '../Assets/Sprites/sprFuelCell.png')]
		public static const SPR_FUELCAN:Class;
		
		//Turret sprites
		[Embed(source = '../Assets/Sprites/sprTurretBase.png')]
		public static const SPR_TURRET_BASE:Class;
		[Embed(source = '../Assets/Sprites/sprTurretGun.png')]
		public static const SPR_TURRET_GUN:Class;
		[Embed(source = '../Assets/Sprites/sprTurretBullet.png')]
		public static const SPR_TURRET_BULLET:Class;
		
		//Lazer base sprite
		[Embed(source = '../Assets/Sprites/sprLazerTop.png')]
		public static const SPR_LAZER_TOP:Class;
		
		//CheckPoint sprite
		[Embed(source = '../Assets/Sprites/sprCheckPoint.png')]
		public static const SPR_CHECKPOINT:Class;
		
		[Embed(source = '../Assets/Sprites/sprBlock.png')]
		public static const SPR_BLOCK:Class;
		
		[Embed(source = '../Assets/Sprites/sprMovingPlatform.png')]
		public static const SPR_MOVINGPLATFORM:Class;
		
		[Embed(source = '../Assets/Sprites/sprSciencetis.png')]
		public static const SPR_SCIENCETIS:Class;
		
		[Embed(source = '../Assets/Sprites/sprScienceTube.png')]
		public static const SPR_SCIENCETUBE:Class;
		
		[Embed(source = '../Assets/Sprites/sprScienceTubeBreak.png')]
		public static const SPR_SCIENCETUBEBREAK:Class;
		
		[Embed(source = '../Assets/Sprites/steamPart.png')]
		public static const SPR_STEAMPART:Class;
		
		[Embed(source = '../Assets/Sprites/sprRecharger.png')]
		public static const SPR_RECHARGER:Class;
		
		[Embed(source = '../Assets/Sprites/sprRechargerEffect.png')]
		public static const SPR_RECHARGEREFFECT:Class;
		
		[Embed(source = '../Assets/Sprites/sprMedal.png')]
		public static const SPR_MEDAL:Class;
		
		//Backgrounds
		[Embed(source = '../Assets/Backgrounds/wood.JPG')]
		public static const BG_PAPER:Class;


	}

}