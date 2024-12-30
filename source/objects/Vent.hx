package objects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.input.mouse.FlxMouseEvent;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Vent extends FlxSpriteGroup
{
	var ventIcon:FlxSprite;
	var ventSpr:FlxSprite;

	public var clickcall:Void->Void;
	public var ventHitbox:FlxObject;

	public function new(x:Float, y:Float, clickcall:Void->Void)
	{
		super();
		this.clickcall = clickcall;
		ventSpr = new FlxSprite(x, y);
		ventSpr.solid = ventSpr.immovable = true;
		ventSpr.loadGraphic(Paths.image('objects/vent'));
		add(ventSpr);

		ventIcon = new FlxSprite(x + 15, y + 13, Paths.image('ui/vent'));
		ventIcon.scale.set(1.1, 1.1);
		ventIcon.updateHitbox();
		ventIcon.visible = false;
		add(ventIcon);

		ventHitbox = new FlxObject(x, y, ventSpr.width + 10, ventSpr.height + 10);

		FlxMouseEvent.add(ventIcon, function(_)
		{
			clickcall();
		}, null, function(_)
		{
			ventIcon.color = FlxColor.YELLOW;
		}, function(_)
		{
			ventIcon.color = FlxColor.WHITE;
		});
	}

	public function doTeleport(object:Player, pos:{x:Float, y:Float})
	{
		new FlxTimer().start(0.2, function(a)
		{
			object.setPosition(pos.x, pos.y);
		});
	}

	public function showIcon(state:Bool)
	{
		if (state)
			ventIcon.visible = true;
		else
			ventIcon.visible = false;
	}
}
