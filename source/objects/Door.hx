package objects;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Door extends InteractObject
{
	public var doorIsOpen:Bool = false;
	public var doorIsLocked:Bool = false;
	public var itemToUnlock:String;

	private var spr:FlxSprite;

	public var doorHitbox:FlxObject;

	public function new(x:Float, y:Float, doorImage:String, isLocked:Bool = false)
	{
		super(x, y, doorImage);
		this.doorIsLocked = isLocked;

		spr = new FlxSprite(x, y, Paths.image('objects/$doorImage'));
		add(spr);
		doorHitbox = new FlxObject(x - 10, y, spr.width * 2, spr.height * 2);
	}

	public function open()
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

	public function addCollision(object1:FlxBasic)
	{
		if (!doorIsOpen)
			FlxG.collide(object1, this);
	}
}
