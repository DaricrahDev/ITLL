package util;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class InteractPopup extends FlxSpriteGroup
{
	public var interactKey:FlxKey;
	public var interactCall:Void->Void;

	public function new(x:Float, y:Float, interactKey:FlxKey)
	{
		super();

		this.interactKey = interactKey;

		var t = new FlxText(x, y, FlxG.width, 'Press ${Std.string(interactKey)} to interact');
		t.setFormat(Paths.font('general.TTF'), 50, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		t.borderSize = 2.5;

		var bg = new FlxSprite(x - 10, y).makeGraphic(Std.int(t.width - 65), Std.int(t.height), FlxColor.BLACK);
		bg.alpha = 0.75;
		add(bg);

		add(t);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([interactKey]))
		{
			interactCall();
		}
	}
}
