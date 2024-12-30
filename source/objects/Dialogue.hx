package objects;

import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

enum DialogueCharPosition
{
	LEFT;
	RIGHT;
}

class Dialogue extends FlxSpriteGroup
{
	public var characterPosition:DialogueCharPosition = LEFT;

	private var textContainer:FlxText;
	private var labelContainer:FlxTypeText;
	private var characterSpr:FlxSprite;

	public function new(x:Float, y:Float, label:String, charPosition:DialogueCharPosition)
	{
		super();
		this.characterPosition = charPosition;

		textContainer = new FlxTypeText(x + 12.3, y + 9, 684, label);
		textContainer.color = FlxColor.WHITE;
		textContainer.setBorderStyle(OUTLINE, FlxColor.BLACK,)
	}
}
