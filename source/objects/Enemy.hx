package objects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;

class Enemy extends FlxSprite
{
	static inline var WALK_SPEED:Float = 200;
	static inline var CHASE_SPEED:Float = 270;

	var brain:FSM;
	var idleTimer:Float;
	var moveDirection:Float;

	public var seesPlayer:Bool;
	public var playerPosition:FlxPoint;
	public var staticHitbox:FlxObject;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(Paths.image('monster'));
		drag.x = drag.y = 10;

		staticHitbox = new FlxObject(x, y, this.width * 3, this.height * 3);

		brain = new FSM(idle);
		idleTimer = 0;
		playerPosition = FlxPoint.get();
	}

	function idle(elapsed:Float)
	{
		if (seesPlayer)
		{
			brain.activeState = chase;
		}
		else if (idleTimer <= 0)
		{
			// 95% chance to move
			if (FlxG.random.bool(95))
			{
				moveDirection = FlxG.random.int(0, 8) * 45;

				velocity.setPolarDegrees(WALK_SPEED, moveDirection);
			}
			else
			{
				moveDirection = -1;
				velocity.x = velocity.y = 0;
			}
			idleTimer = FlxG.random.int(1, 4);
		}
		else
			idleTimer -= elapsed;
	}

	function chase(elapsed:Float)
	{
		if (!seesPlayer)
		{
			brain.activeState = idle;
		}
		else
		{
			FlxVelocity.moveTowardsPoint(this, playerPosition, CHASE_SPEED);
		}
	}

	override public function update(elapsed:Float)
	{
		staticHitbox.setPosition(this.x, this.y);
		if (velocity.x != 0 || velocity.y != 0)
		{
			if (Math.abs(velocity.x) > Math.abs(velocity.y))
			{
				if (velocity.x < 0)
					facing = LEFT;
				else
					facing = RIGHT;
			}
			else
			{
				if (velocity.y < 0)
					facing = UP;
				else
					facing = DOWN;
			}
		}

		brain.update(elapsed);

		super.update(elapsed);
	}
}
