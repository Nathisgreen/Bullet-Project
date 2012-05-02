package  
{
	import Hazards.*;
	import Hazards.Lazers.*;
	import Platforms.*;
	import flash.display.Sprite;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Nathan Williams
	 */
	public class Player extends Entity 
	{
		public var sprPlayer:Spritemap = new Spritemap(GC.SPR_PLAYER, 16, 16);
		public var sprBullet:Spritemap = new Spritemap(GC.SPR_BULLET, 12, 8) ;
		
		private var _state:String = "robot";
		
		private var fuelBar:FuelBar = new FuelBar();
		
		//init all the variables.
		private var _speed:Point = new Point(0, 0);		//Vertical and Horizontal speed of the player
		private var _acceleration:Number = 0.5;			//Horizontal acceleration of the player (left/right)
		private var _friction:Number = 0.5;				//Horizontal friction of the player (slows player down when not moving)
		private var _gravity:Number = 0.2;				//how fast the player is pulled down
		private var _jump:Number = 4.3;					//how high the character can jump
		private var _maxSpeed:Number = 1;				//the max horizontal speed of the player (left/right)
		private var _maxSpeedV:Number = 5;				//how fast the player falls
		private var _canChange:int = 0;					//timer for changing control
		private var _hasLanded:Boolean = true;			//stores if landed after shooting
		private var _collisionTypes:Array = new Array(GC.TYPE_LEVEL, GC.TYPE_HOZPLAT);				//store the collision types
		private var _startPosition:Point;
		private var _onPlatform:Boolean = false;

		
		//Bullet variables
		private var _bRotateSpeed:Number = 4;
		private var _bFriction:Number = 0.95;
		private var _bMaxSpeed:Number = 0.05;
		private var _bAngle:Number = 0;
		private var _prevSpeed:Point = new Point(0, 0);
		private var _bCollisionTypes:Array = new Array(GC.TYPE_LEVEL,GC.TYPE_HOZPLAT);
		private var _bNormalSpeed:Number = 100;
		private var _bBoostSpeed:Number = 200;
		private var _bVelocity:Number = _bNormalSpeed;
		private var _turnDirection:Boolean;
		private var _turnDirection1:Boolean; // used for right and left
		
		private var isActive:Boolean =  true;
		
		public function Player(x:int, y:int) 
		{
			//Player setup
			this.x = x;
			this.y = y;
			_startPosition = new Point(x, y);
			
			//create animation frames
			sprPlayer.add("stand", [0], 0, false);
			sprPlayer.add("walk", [8,10, 11, 12,13,14,15], 11, true);
			sprPlayer.play("stand");
			sprPlayer.x = 8;
			//set the graphic
			graphic = sprPlayer;
			//set the collision type
			type = GC.TYPE_PLAYER;
		
			sprPlayer.originX = 8;
			
			//define inputs
			Input.define("left", Key.LEFT);
			Input.define("right", Key.RIGHT);
			Input.define("up", Key.UP);
			Input.define("down", Key.DOWN);
			Input.define("jump", Key.Z, Key.A, Key.UP);
			Input.define("shoot", Key.X, Key.S);
			Input.define("boost", Key.Z);
			
			setHitbox(10, 16,-3);
			
			//Bullet setup
			sprBullet.originX = 6;
			sprBullet.originY = 4;
			sprBullet.smooth = true;
			sprBullet.x = 4;
			sprBullet.y = 4;
			
			//define inputs
			//Input.define("up", Key.LEFT);
			//Input.define("down" , Key.RIGHT);
			
			layer = -3;
		}
		
		override public function update():void 
		{	
			//controls delay between when can turn to bullet
			if (isActive)
			{
				focusAlarm();
				
				if (_state == "robot")
				{
					//we are a robot
					robotUpdate()
				}
				else
				{
					//we are a bullet
					bulletUpdate();
				}
								
				if (collide(GC.TYPE_SPIKE, x, y))
				{
					died();
				}
				
				if (collide(GC.TYPE_LAZER, x, y))
				{
					var a:LazerTop;
					a = collide(GC.TYPE_LAZER, x, y) as LazerTop;
					if (a != null)
					{
						if (a.getOn() == true)
						{
							died();
						}
					}
					
					var b:LazerHoz;
					b = collide(GC.TYPE_LAZER, x, y) as LazerHoz;
					if (b != null)
					{
						if (b.getOn() == true)
						{
							died();
						}
					}
				}
				
				if (collide(GC.TYPE_EXIT, x, y))
				{
					LevelController.player.x = 0;
					LevelController.player.y = 0;;
					LevelController.fuelBar.setFuel(1);
					LevelController.finished = true;
				}
				
				super.update();
			}

		}
		
		private function robotUpdate():void
		{
				//If we're holding left ...
				if (Input.check("left") && !Input.check("right"))
				{
					sprPlayer.play("walk");		//set our animation to walk left
					sprPlayer.scaleX = -1;
					_speed.x -= _acceleration;	//descrease our horizontal speed 
				}
				
				//If we're holding right ...
				if (Input.check("right") && !Input.check("left"))
				{
					sprPlayer.play("walk");			//set our animation to walk right
					sprPlayer.scaleX = 1;
					_speed.x += _acceleration ;		//increase our horizontal speed 
				}
				
				//both pressed
				if (Input.check("right") && Input.check("left"))
				{
					stopMoving();
				}
				
				// if we're not holding right/left ...
				if (!Input.check("left") && !Input.check("right"))
				{
					stopMoving();
				}
				
				if (Input.check("shoot") && _hasLanded == true)
				{
					//if not on robot block grid
					if (!collideTypes(_bCollisionTypes, x, y))
					{
						//if enough time has passed sense last shot
						if (_canChange > 10) 
						{
							//if we have more than 10 fuel
							if (LevelController.fuelBar.getFuel() > 10)
							{
							//change to bullet
							changeFocus();
							}
						}
					}
				}
				
				if (Input.check(Key.ENTER))
				{
					LevelController.fuelBar.addFuel(20);
				}
				
				// Moving platform code
				if (collide(GC.TYPE_HOZPLAT, x, y + 1) && !collide(GC.TYPE_LEVEL, x, y + 1))
				{
					_onPlatform = true;
				}
				if (collide(GC.TYPE_HOZPLAT, x, y + 1) && _onPlatform)
				{
					var a:HorizontalPlat; 
					a = collide(GC.TYPE_HOZPLAT, x , y + 1) as HorizontalPlat;
					if (a != null)
					{
						if (a.on == false)
						{
							a.turnOn();
						}
						
						if (!collideTypes(_collisionTypes, x+FP.sign(a.xSpeed) + (a.xSpeed * FP.elapsed), y))
						{
							x += Math.round(a.xSpeed * FP.elapsed);
						}	
					}	
				}
				if (_onPlatform && !collide(GC.TYPE_HOZPLAT, x, y + 1) )
				{
					_onPlatform = false;
				}
				
				//if we're holing jump, and there's a floor below us, jump
				if (Input.pressed("jump") && collideTypes(_collisionTypes, x, y + 1)) { _speed.y = - _jump; }
				
				//if we're moving upwards, and we're not holding jump, make us fall faster (variable _jumping)
				if (!Input.check("jump") && _speed.y < 0) { _speed.y += _gravity; }
				
				//increase vertical speed (gravity)
				if (_speed.y < _maxSpeedV)
				{
				_speed.y += _gravity;
				}
				
				/* this makes the player move left/right. The loop below makes it so that the player has pixel
				* perfect collisions. What we do, is run through each pixel that he is going to move, and check
				* if there is a solid thing in the way. If there is, we stop moving, and set our _speed to 0.
				* Otherwise, we move in whatever direction we should be moving */
				for (var i:int = 0; i < Math.abs(_speed.x); i += 1)
				{
					//Check if there is a wall 1 pixel left/right of us
					//FP.sign returns 1 if _speed.x is positive, -1 is _speed.x is negative, and 0 if _speed.x is 0
					if (!collideTypes(_collisionTypes, x + FP.sign(_speed.x), y)) 
					{
						//no wall? Move 1 pixel left/right
						x += FP.sign(_speed.x); 
					}
					else 
					{ 
						//oh, there is a wall? Set our animation to the standing animation
						//if(_speed.x > 0) { sprPlayer.play("standRight"); } else { sprPlayer.play("standLeft"); }
						//set our _speed to nothing
						sprPlayer.play("stand");
						_speed.x = 0; 
					}
				}
		
				//this is exactly the same as the previous loop, just for vertical movement
				for (i = 0; i < Math.abs(_speed.y); i += 1)
				{
					if (!collideTypes(_collisionTypes, x, y + FP.sign(_speed.y))) { y += FP.sign(_speed.y); } else { _speed.y = 0; }
				}
				
				// if we're not holding right/left ...
				if (!Input.check("left") && !Input.check("right"))
				{
					//if we're moving right
					if (_speed.x > 0) 
					{ 
						//descrease _speed by _friction, play the standRight animation
						//sprPlayer.play("standRight");
						_speed.x -= _friction;
						if (_speed.x < 0) { _speed.x = 0; }
					}
					
					//if we're moving left
					if (_speed.x < 0) 
					{
						//increase _speed by _friction, play the standLeft animation
						//sprPlayer.play("standLeft");
						_speed.x += _friction;
						if (_speed.x > 0) { _speed.x = 0; }
					}
				}
				
				/* if our _speed is larger than max _speed, set our _speed to the max _speed.
				 * this may look kind of confusing, but it's quite simple
				 * Math.abs returns the absolute of any value (ex. Math.abs(-7) returns 7, Math.abs(3) returns 3
				 * So if the absolute of _speed.x is larger than max _speed, we set _speed.x to the max _speed * the direction of the _speed. */
				if (Math.abs(_speed.x) > _maxSpeed) { _speed.x = FP.sign(_speed.x) * _maxSpeed; }
				
				//if we fell out of the room, tell the game to reset, and freeze us.
				//if (y > FP.height * 4) {  LevelController.restart =  true; /*frozen = true;*/ }
				
				//we have landed sense shooting so set to be true
				if (collideTypes(_collisionTypes, x, y + 1) && _hasLanded == false)
				{
					_hasLanded = true;
				}
				
				if (collide(GC.TYPE_BULLETBLOCK, x, y))
				{
					died();
				}
		}
		
		private function stopMoving():void
		{
				sprPlayer.play("stand");
				//if we're moving right
				if (_speed.x > 0) 
				{ 
					_speed.x -= _friction;
					if (_speed.x < 0) { _speed.x = 0; }
				}
				
				//if we're moving left
				if (_speed.x < 0) 
				{
					_speed.x += _friction;
					if (_speed.x > 0) { _speed.x = 0; }
				}
		}
		
		private function floorPosition():void
		{
			x = Math.floor(x);
			y = Math.floor(y);
		}
		
		private function focusAlarm():void
		{
			if (_canChange > 15){_canChange = 15;}else{_canChange ++;}
		}
		
		private function bulletUpdate():void
		{
			_speed.x += Math.cos((_bAngle) * Math.PI / 180) * _bVelocity  * FP.elapsed;;
			trace("Speed.x" + _speed.x)
			_speed.y += Math.sin((_bAngle) * Math.PI / 180) * _bVelocity  * FP.elapsed;;
			trace("Speed.Y" + _speed.y)
			_speed.normalize(2);
			sprBullet.angle = Math.round(-_bAngle);
			
			if (LevelController.fuelBar.getFuel() > 1)
			{
				LevelController.fuelBar.subtractFuel(0.3); 
				bulletControlls();
			}
			else
			{
				noFuel();
			}
			
				
			for each(var i:GravityGrabber in LevelController.GravityList)
			{
				var b:int = distanceToPoint(i.x, i.y, false)
				if (b < 100)
				{
					i.isActive = true;
					var a:Point = new Point();
					a.x = x - i.x;
					a.y = y - i.y;
					
					if (b < 101 && b > 80) { a.normalize(0.2); }
					if (b < 81 && b > 60) { a.normalize(0.4); }
					if (b < 61 && b > 40) { a.normalize(0.6); }
					if (b < 41) { a.normalize(0.8); }
					
					_speed.x -= a.x;
					_speed.y -= a.y;
				}
				else
				{
					i.isActive = false;
				}	
			}
				
			//store the way the bullet is moving horizontally
			if (FP.sign(_speed.x) != 0)
			{
				if (FP.sign(_speed.x) != _prevSpeed.x)
				{
					_prevSpeed.x = FP.sign(_speed.x);
				}
			}
			if (FP.sign(_speed.y) != 0)
			{
				if (FP.sign(_speed.y) != _prevSpeed.y)
				{
					_prevSpeed.y = FP.sign(_speed.y);
				}
			}
				
			checkBulletCollision();
			
			if (_bAngle > 360)
			{
				_bAngle = 0;
			}
			if (_bAngle < 0)
			{
				_bAngle = 359;
			}
			
			_speed.x = 0;
			_speed.y = 0;
			
			trace(_bAngle);
	
		}
		
		/*override public function render():void 
		{
			if (_state == "robot")
			{
				Draw.graphic(sprPlayer, x, y);
			}
			else
			{
				Draw.graphic(sprBullet, Math.floor(x), Math.floor(y));
				//Draw.graphic(sprBullet, x, y);
			}
			//super.render();
		}*/
		
		private function checkBulletCollision():void
		{
				//let the ugly stuff BEGIN!
				//store if we changed state yet or not
				var hasChanged:Boolean = false;
				
				x += _speed.x ;
				
				if (collideTypes(_bCollisionTypes, x, y))
				{
					trace("xspeed: " + FP.sign(_speed.x));
					trace("yspeed: " + FP.sign(_speed.y));
						if (FP.sign(_prevSpeed.x) > 0)
						{
							//moving right
							_speed.x = 0;
							if (hasChanged == false) { changeFocus(); hasChanged = true; }
							x = Math.floor(x / 16) * 16 + 16 - sprPlayer.width;
							trace("right");
						}
						else
						{
							//moving left
							_speed.x = 0;
							if (hasChanged == false) { changeFocus(); hasChanged = true; }
							x = Math.floor(x / 16) * 16 + 16;
							trace("left");
						}
				}
				
				y += _speed.y ;
				
				if (collideTypes(_bCollisionTypes, x, y))
				{
					trace("xspeed: " + FP.sign(_speed.x));
					trace("yspeed: " + FP.sign(_speed.y));

					if (FP.sign(_prevSpeed.y) > 0)
					{
						//moving up
						_speed.y = 0;
						if (hasChanged == false) { changeFocus(); hasChanged = true;}
						y = Math.floor(y / 16) * 16 +16 - sprPlayer.height;
						trace("up");
					}
					else
					{
						//moving down
						_speed.y = 0;
						if (hasChanged == false) { changeFocus(); hasChanged = true;}
						y = Math.floor(y / 16) * 16 + 16;
							
						//hack to get out of floor :(
						if (FP.sign(_speed.x) == 0) {
							while (collideTypes(_bCollisionTypes, x, y)) { y -= 1;}
						}
							
						trace("down");
					}
				}
				
				//hack
				if (collideTypes(_bCollisionTypes, x, y))
				{
					//if still in wall move left to get out of wall
					while (collideTypes(_bCollisionTypes, x, y))
					{
						x -= 1 ;
					}
				}
				
				//if changed to robot stop the graphical error
				if (hasChanged == true) {
					floorPosition(); 
				}
				//I hate collisions, but one day, ill show them
		}
		
		private function bulletControlls():void
		{
			//up
			if (Input.check("up"))
			{
				if (_bAngle != 90)
				{
					if (FP.sign(_speed.x) > 0)
					{
						_turnDirection = true;
					}
					else
					{
						_turnDirection = false;
					}
					
					if (_turnDirection)
					{
						if ( _bAngle > 271 || _bAngle == 0 || _bAngle < 90)
						{
							_bAngle -= _bRotateSpeed;
						}
						else
						{
							_bAngle = 270;
						}
					}
					else
					{
						if (_bAngle < 267)
						{
							_bAngle += _bRotateSpeed;
						}
						else
						{
							_bAngle = 270;
						}
					}
				}
			}
			
			//Down
			if (Input.check("down"))
			{
				if (_bAngle != 270)
				{
					if (FP.sign(_speed.x) > 0)
					{
						_turnDirection = true;
					}
					else
					{
						_turnDirection = false;
					}
					
					if (_turnDirection)
					{
						if ( _bAngle < 88 || _bAngle > 270)
						{
							_bAngle += _bRotateSpeed;
						}
						else
						{
							_bAngle = 90;
						}
					}
					else
					{
						if (_bAngle > 90)
						{
							_bAngle -= _bRotateSpeed;
						}
						else
						{
							_bAngle = 90;
						}
					}
				}
			}
			
			//right
			if (Input.check("right"))
			{
				if (FP.sign(_speed.x) > 0)
				{
					_turnDirection = true;
				}
				else
				{
					_turnDirection = false;
				}
				
				if (_turnDirection || _bAngle == 270)
				{
					if (_bAngle > 180)
					{
						_turnDirection1 = true;
					}
					else
					{
						_turnDirection1 = false;
					}
					
					if (_turnDirection1)
					{
						if (_bAngle < 359)
						{
							_bAngle += _bRotateSpeed;
						}
						else
						{
							_bAngle = 0;
						}
					}
					else
					{
						if (_bAngle > 3)
						{
							_bAngle -= _bRotateSpeed;
						}
						else
						{
							_bAngle = 0;
						}
					}
				}
				else
				{
					if (_bAngle != 180)
					{
						if (_bAngle > 180)
						{
							_bAngle += _bRotateSpeed;
						}
						else
						{
							_bAngle -= _bRotateSpeed;
						}	
					}
				}
			}
			
			//left
			if (Input.check("left"))
			{
				if (FP.sign(_speed.x) > 0)
				{
					_turnDirection = true;
				}
				else
				{
					_turnDirection = false;
				}
				
				if (!_turnDirection || _bAngle == 270)
				{
					if (_bAngle > 180)
					{
						_turnDirection1 = true;
					}
					else
					{
						_turnDirection1 = false;
					}
					
					if (_turnDirection1)
					{
						if (_bAngle > 183)
						{
							_bAngle -= _bRotateSpeed;
						}
						else
						{
							_bAngle = 180;
						}
					}
					else
					{
						if (_bAngle < 178)
						{
							_bAngle += _bRotateSpeed;
						}
						else
						{
							_bAngle = 180;
						}
					}
				}
				else
				{
					if (_bAngle != 180)
					{
						if (_bAngle > 180)
						{
							_bAngle -= _bRotateSpeed;
						}
						else
						{
							_bAngle += _bRotateSpeed;
						}	
					}
				}
			}
		}
		
		private function noFuel():void
		{
			if (_bVelocity > _bNormalSpeed)
				{
					_bVelocity -= 10;
				}
				
				if (_bAngle <= 135 && _bAngle >= 45)
				{	
					if (!Input.check("left") && !Input.check("right"))
					{
						bulletFall()
					}
					else
					{
						if (Input.check("left"))
						{
							if (_bAngle < 135)
							{
								sprBullet.angle -=  _bRotateSpeed;
								_bAngle +=  _bRotateSpeed;
							}
							else
							{
								_bAngle = 135;
								sprBullet.angle = -135;
							}
							
						}
						
						if (Input.check("right"))
						{
							if (_bAngle > 45)
							{
								_bAngle -= _bRotateSpeed;
								sprBullet.angle += _bRotateSpeed;
							}
							else
							{
								_bAngle = 45;
								sprBullet.angle = -45;
							}
							
						}
					}
				}
				else
				{
					bulletFall();
				}
		}
		
		//change between robot and bullet
		private function changeFocus():void
		{
			if (_state == "robot") { _state = "bullet" } else { _state = "robot" };
			
			if (_state == "robot")
			{
				x = Math.floor(x);
				y = Math.floor(y);
				graphic = sprPlayer;
				setHitbox(10, 16,-3);
			}
			else
			{
				_bVelocity = _bNormalSpeed;
				graphic = sprBullet;
				setHitbox(8, 8);
				if (sprPlayer.scaleX > 0)
				{
					_bAngle = 0;
					_prevSpeed.x = 1;
				}
				else
				{
					_bAngle = 180;
					_prevSpeed.x = -1;
				}
				sprBullet.angle = _bAngle;
			}
			
			_canChange = 0;
			_hasLanded = false;
		}
		
		public function died():void
		{
			x = _startPosition.x;
			y = _startPosition.y;
			FP.camera.x = x-150;
			FP.camera.y = y-200;
			
			if (_state != "robot")
			{
				changeFocus();
			}
			
			for each(var fuelObject:FuelCan in LevelController.FuelList)
			{
				if (fuelObject.visible == false)
				{
					fuelObject.visible = true;
				}
			}
			
			for each (var platObject:HorizontalPlat in LevelController.platformList)
			{
				if (platObject.isStatic == "true")
				{
					platObject.on = false;
					platObject.x = platObject.startPosition.x
					platObject.y = platObject.startPosition.y
					platObject.xSpeed = platObject.start_xSpeed;
				}
			}
			//set the fuel back to empty (which is 1);
			LevelController.fuelBar.setFuel(1);
		}
		
		private function bulletFall():void
		{
					if (_bAngle < 270 && _bAngle > 90)
					{
						_bAngle -= _bRotateSpeed;
						sprBullet.angle += _bRotateSpeed;
					}
					else
					{
						if (_bAngle >= 90 && _bAngle < 180)
						{
							_bAngle = 90;
						}
						else
						{
							_bAngle += _bRotateSpeed;
							sprBullet.angle -= _bRotateSpeed;
						}
						
					}
					
					//keep them within 360
					if (_bAngle < 0)
					{
						_bAngle = 360;
						sprBullet.angle = 0;
					}
					if (_bAngle > 359)
					{
						_bAngle = 0;
						sprBullet.angle = 360;
					}
		}
		
		//////////////
		//Accessors//
		////////////
		
		public function getState():String
		{
			return _state;
		}
		
		public function getYSpeed():int
		{
			return _prevSpeed.y;
		}
		
		public function setStartPosition(aPoint:Point):void
		{
			_startPosition = aPoint;
		}
		
		public function setActive(abool:Boolean):void
		{
			isActive = abool;
		}
		
		public function getActive():Boolean
		{
			return isActive;
		}
		
		public function getSpeed():Point
		{
			return _speed;
		}
	}

}