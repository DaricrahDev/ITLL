import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Lib;
import openfl.filters.BitmapFilter;
import openfl.filters.BlurFilter;
import openfl.filters.ShaderFilter;

class Player extends FlxSprite
{
	static inline var SPEED:Float = 340;

	public var curHealth:Float = 1;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(Paths.image('character'));
		health = 50;

		drag.x = drag.y = 450;
	}

	function doMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		var any:Bool = false;

		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up)
		{
			velocity.y = -SPEED;
			flipX = false;
			flipY = false;
			angle = 0;
		}
		if (down)
		{
			velocity.y = SPEED;
			flipX = false;
			flipY = true;
		}
		if (left)
		{
			velocity.x = -SPEED;
			flipX = false;
			flipY = false;
			angle = -90;
		}
		if (right)
		{
			velocity.x = SPEED;
			flipX = true;
			flipY = false;
			angle = 90;
		}

		/*if (up || down || left || right)
			{
				var newAngle:Float = 0;
				if (up)
				{
					flipY = false;
					if (left)
					{
						newAngle -= 45;
					}
					else if (right)
					{
						newAngle += 45;
					}
				}
				else if (down)
				{
					flipY = true;
					if (left)
					{
						angle = 45;
						newAngle += 45;
					}
					else if (right)
					{
						newAngle -= 45;
						angle = -45;
					}
				}
				else if (left)
				{
					newAngle = 180;
					flipX = false;
				}
				else if (right)
				{
					newAngle = 0;
					flipX = true;
				}

				velocity.setPolarDegrees(SPEED, newAngle);
		}*/
	}

	override function update(elapsed:Float)
	{
		doMovement();

		curHealth = FlxMath.lerp(curHealth, health, .2 / (120 / 60));

		super.update(elapsed);
	}
}
