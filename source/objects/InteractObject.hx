package objects;

import flash.filters.GlowFilter;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFilterFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.input.mouse.FlxMouseEvent;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.filters.BitmapFilter;

class InteractObject extends FlxSpriteGroup
{
	// when the key needed for the interaction to be made is pressed this callback is enabled
	public var interactCall:Void->Void;

	private var interactSpr:FlxSprite;

	public var object1:FlxObject;
	public var sumWidthValue:Int = 15;
	public var sumHeightValue:Int = 15;

	public function new(x:Float, y:Float, pathToImage:String)
	{
		super();

		interactSpr = new FlxSprite(x, y).loadGraphic(Paths.image('objects/$pathToImage'));
		// interactSpr.setSize(interactSpr.width - 10, interactSpr.height - 10);

		object1 = new FlxObject(x, y, interactSpr.width + sumWidthValue, interactSpr.height + sumHeightValue);

		add(interactSpr);
	}
}
