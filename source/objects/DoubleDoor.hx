package objects;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class DoubleDoor extends Door
{
	private var sprDbl:FlxSprite;

	public function new(x:Float, y:Float, doorImage:String, isLocked:Bool = false)
	{
		super(x, y, doorImage);
		this.doorIsLocked = isLocked;

		spr = new FlxSprite(x, y, Paths.image('objects/$doorImage'));
		// spr.updateHitbox();
		add(spr);
		doorHitbox = new FlxObject(x - 10, y, spr.width * 4, spr.height);
	}

	override public function open()
	{
		if (!doorIsLocked)
		{
			doorIsOpen = true;
			FlxG.sound.play('assets/sounds/open-door.ogg', 1.0, false);
			remove(spr);
			new FlxTimer().start(1.2, function(a)
			{
				FlxG.sound.play('assets/sounds/close-door.ogg', 1.0, false);
				doorIsOpen = false;
				add(spr);
			});
		}
		else if (doorIsLocked && PlayState.equippedObject == itemToUnlock)
		{
			doorIsLocked = false;
			doorIsOpen = true;
			FlxG.sound.play('assets/sounds/open-door.ogg', 1.0, false);
			remove(spr);
			new FlxTimer().start(1.2, function(a)
			{
				FlxG.sound.play('assets/sounds/close-door.ogg', 1.0, false);
				doorIsOpen = false;
				add(spr);
			});
		}
		else if (doorIsLocked && PlayState.equippedObject != itemToUnlock)
		{
			FlxG.sound.play('assets/sounds/door-locked.ogg', 1.0, false);
		}
	}

	override public function addCollision(object1:FlxBasic)
	{
		if (!doorIsOpen)
			FlxG.collide(object1, this);
	}
}
