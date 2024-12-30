package;

import flash.filters.GlowFilter;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.input.mouse.FlxMouseEvent;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import objects.Door;
import objects.DoubleDoor;
import objects.Enemy;
import objects.InteractObject;
import objects.Vent;
import openfl.display.FPS;
import util.InteractPopup;

class PlayState extends FlxState
{
	var player:Player;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	var interactLockerOffice:InteractObject;
	var lockerOfficePopup:InteractPopup;

	var interactLockerAlmacen:InteractObject;
	var lockerAlmacenPopup:InteractPopup;

	var ovenKitchen:InteractObject;
	var ovenKitchenPopup:InteractPopup;

	var interactDoorOffice:Door;
	var doorOfficePopup:InteractPopup;

	var doorAlmacen:Door;
	var doorAlmacenPopup:InteractPopup;

	var doorBath2:Door;
	var doorBath2Popup:InteractPopup;

	var doorOfficeBottom:Door;
	var doorOfficeBottomPopup:InteractPopup;

	var doorStorage2:DoubleDoor;
	var doorStorage2Popup:InteractPopup;

	var bathroom2Sink:InteractObject;
	var bathroom2SinkPopup:InteractPopup;

	var lockerOfficeBottom:InteractObject;
	var lockerBottomPopup:InteractPopup;

	var interactGroup:FlxTypedGroup<InteractObject>;
	var collideObjects:FlxTypedGroup<FlxSprite>;

	public static var equippedObject:String = 'NOTHING';

	var ventOffice:Vent;
	var ventAlmacen:Vent;

	var doorOfficeIsOpened:Bool = false;

	var shadow:FlxSprite;

	var bossFish:Enemy;

	override public function create()
	{
		super.create();
		bgColor = FlxColor.BLACK;
		FlxG.sound.playMusic('assets/music/ambient.ogg', 0.3);
		FlxG.sound.play('assets/music/horror-wind.ogg', 0.5, true);
		FlxSprite.defaultAntialiasing = true;
		interactGroup = new FlxTypedGroup<InteractObject>();
		collideObjects = new FlxTypedGroup<FlxSprite>();

		map = new FlxOgmo3Loader(Paths.levelOGMO('test_level'), Paths.levelJSON('test_level'));
		walls = map.loadTilemap(Paths.image("grid"), "walls");
		walls.follow();
		walls.setTileProperties(1, ANY);
		walls.setTileProperties(2, NONE);
		walls.setTileProperties(3, NONE);
		add(walls);

		player = new Player(20, 20);
		map.loadEntities(placeEntities, "entities");

		var chair = new FlxSprite(512, 128, Paths.image('objects/chair'));
		chair.solid = chair.immovable = true;
		collideObjects.add(chair);

		var table = new FlxSprite(383, 128, Paths.image('objects/table'));
		table.solid = table.immovable = true;
		collideObjects.add(table);

		var lockerAlmacenLeft = new FlxSprite(768, 192, Paths.image('objects/locker'));
		lockerAlmacenLeft.solid = lockerAlmacenLeft.immovable = true;
		collideObjects.add(lockerAlmacenLeft);

		var bathroom1Sink = new FlxSprite(256, 832, Paths.image('objects/sink'));
		bathroom1Sink.solid = bathroom1Sink.immovable = true;
		collideObjects.add(bathroom1Sink);

		var tableKitchen1 = new FlxSprite(1152, 128, Paths.image('objects/table_kitchen'));
		tableKitchen1.solid = tableKitchen1.immovable = true;
		collideObjects.add(tableKitchen1);

		var tableKitchen2 = new FlxSprite(1344, 128, Paths.image('objects/table_kitchen'));
		tableKitchen2.solid = tableKitchen2.immovable = true;
		collideObjects.add(tableKitchen2);

		var oven1 = new FlxSprite(1152, 256, Paths.image('objects/ovenRotated'));
		oven1.solid = oven1.immovable = true;
		collideObjects.add(oven1);

		var tableKitchen3 = new FlxSprite(1152, 384, Paths.image('objects/table_kitchen'));
		tableKitchen3.solid = tableKitchen3.immovable = true;
		collideObjects.add(tableKitchen3);

		var tableKitchen4 = new FlxSprite(1408, 384, Paths.image('objects/table_kitchen'));
		tableKitchen4.solid = tableKitchen4.immovable = true;
		collideObjects.add(tableKitchen4);

		var oven2 = new FlxSprite(1920, 128, Paths.image('objects/oven2'));
		oven2.solid = oven2.immovable = true;
		collideObjects.add(oven2);

		var oven3 = new FlxSprite(2048, 128, Paths.image('objects/oven1'));
		oven3.solid = oven3.immovable = true;
		collideObjects.add(oven3);

		var bathNoCollision = new FlxSprite(128, 1088, Paths.image('objects/toilet'));
		add(bathNoCollision);
		var bathCollision = new FlxSprite(256, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var bathCollision = new FlxSprite(384, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var bathCollision = new FlxSprite(512, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var bathCollision = new FlxSprite(704, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var bathCollision = new FlxSprite(832, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var bathCollision = new FlxSprite(960, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var bathCollision = new FlxSprite(1088, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var bathCollision = new FlxSprite(1216, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var bathCollision = new FlxSprite(1344, 1088, Paths.image('objects/toilet'));
		bathCollision.solid = bathCollision.immovable = true;
		collideObjects.add(bathCollision);
		var tableComedor = new FlxSprite(832, 1472, Paths.image('objects/table_kitchen'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(832, 1536, Paths.image('objects/table_kitchen'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1344, 1472, Paths.image('objects/table_kitchenRotated'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1408, 1472, Paths.image('objects/table_kitchenRotated'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1024, 1728, Paths.image('objects/table_kitchenRotated'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1088, 1728, Paths.image('objects/table_kitchenRotated'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(832, 2048, Paths.image('objects/table_kitchenRotated'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(896, 2048, Paths.image('objects/table_kitchenRotated'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1152, 2240, Paths.image('objects/table_kitchenRotated'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1216, 2240, Paths.image('objects/table_kitchenRotated'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1344, 1856, Paths.image('objects/table_kitchen'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1344, 1920, Paths.image('objects/table_kitchen'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1536, 2368, Paths.image('objects/table_kitchen'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1536, 2432, Paths.image('objects/table_kitchen'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableComedor = new FlxSprite(1536, 2496, Paths.image('objects/table_kitchen'));
		tableComedor.solid = tableComedor.immovable = true;
		collideObjects.add(tableComedor);
		var tableOfficeV2 = new FlxSprite(320, 1664, Paths.image('objects/table_kitchenRotated'));
		tableOfficeV2.solid = tableOfficeV2.immovable = true;
		collideObjects.add(tableOfficeV2);
		var tableOfficeV2 = new FlxSprite(384, 1664, Paths.image('objects/table_kitchenRotated'));
		tableOfficeV2.solid = tableOfficeV2.immovable = true;
		collideObjects.add(tableOfficeV2);
		var tableOfficeV2 = new FlxSprite(320, 1856, Paths.image('objects/table_kitchenRotated'));
		tableOfficeV2.solid = tableOfficeV2.immovable = true;
		collideObjects.add(tableOfficeV2);
		var tableOfficeV2 = new FlxSprite(384, 1664, Paths.image('objects/table_kitchenRotated'));
		tableOfficeV2.solid = tableOfficeV2.immovable = true;
		collideObjects.add(tableOfficeV2);
		var lockerV2 = new FlxSprite(128, 2752, Paths.image('objects/locker'));
		lockerV2.solid = lockerV2.immovable = true;
		collideObjects.add(lockerV2);
		var atravesar = new FlxSprite(128, 1280, Paths.image('objects/vent'));
		add(atravesar);
		var atravesar = new FlxSprite(192, 1280, Paths.image('objects/vent'));
		add(atravesar);

		ventOffice = new Vent(640, 128, function()
		{
			ventOffice.doTeleport(player, {x: 896, y: 192});
		});
		add(ventOffice);

		ventAlmacen = new Vent(896, 128, function()
		{
			ventAlmacen.doTeleport(player, {x: 640, y: 192});
		});
		add(ventAlmacen);

		interactLockerOffice = new InteractObject(128, 128, 'locker');
		interactLockerOffice.immovable = true;
		interactGroup.add(interactLockerOffice);

		interactDoorOffice = new Door(576, 468, 'door');
		interactDoorOffice.immovable = true;
		add(interactDoorOffice);

		add(interactGroup);
		add(collideObjects);

		lockerOfficePopup = new InteractPopup(30, 20, FlxKey.E);
		lockerOfficePopup.interactCall = showNothinText;
		lockerOfficePopup.scrollFactor.set();

		ovenKitchen = new InteractObject(1152, 256, 'ovenRotated');
		ovenKitchen.immovable = true;
		interactGroup.add(ovenKitchen);

		ovenKitchenPopup = new InteractPopup(30, 20, FlxKey.E);
		ovenKitchenPopup.interactCall = function()
		{
			showFound("BOTTOM OFFICE KEY");
		};
		ovenKitchenPopup.scrollFactor.set();

		lockerOfficeBottom = new InteractObject(128, 2944, 'locker');
		lockerOfficeBottom.immovable = true;
		interactGroup.add(lockerOfficeBottom);

		lockerBottomPopup = new InteractPopup(30, 20, FlxKey.E);
		lockerBottomPopup.interactCall = function()
		{
			throw('YOU ESCAPED! THANKS FOR PLAYING!');
		};
		lockerBottomPopup.scrollFactor.set();

		doorOfficeBottom = new Door(640, 2580, 'door', true);
		doorOfficeBottom.itemToUnlock = "BOTTOM OFFICE KEY";
		doorOfficeBottom.immovable = true;
		doorOfficeBottom.angle = 90;
		add(doorOfficeBottom);

		doorOfficeBottomPopup = new InteractPopup(30, 20, FlxKey.F);
		doorOfficeBottomPopup.interactCall = function()
		{
			doorOfficeBottom.open();
		};
		doorOfficeBottomPopup.scrollFactor.set();

		doorOfficePopup = new InteractPopup(30, 20, FlxKey.F);
		doorOfficePopup.interactCall = function()
		{
			interactDoorOffice.open();
		};
		doorOfficePopup.scrollFactor.set();

		doorAlmacen = new Door(896, 468, 'door', true);
		doorAlmacen.immovable = true;
		add(doorAlmacen);

		doorStorage2 = new DoubleDoor(1747, 576, 'double_door', true);
		doorStorage2.itemToUnlock = "STORAGE 2 KEY";
		doorStorage2.immovable = true;
		add(doorStorage2);

		doorStorage2Popup = new InteractPopup(30, 20, FlxKey.F);
		doorStorage2Popup.interactCall = function()
		{
			doorStorage2.open();
		};
		doorStorage2Popup.scrollFactor.set();

		doorBath2 = new Door(768, 789, 'door', true);
		doorBath2.itemToUnlock = "BATHROOM KEY";
		doorBath2.immovable = true;
		add(doorBath2);

		bathroom2Sink = new InteractObject(1024, 832, 'sink');
		bathroom2Sink.immovable = true;
		interactGroup.add(bathroom2Sink);

		bathroom2SinkPopup = new InteractPopup(30, 20, FlxKey.E);
		bathroom2SinkPopup.interactCall = function()
		{
			showFound('Storage 2 Key');
		};
		bathroom2SinkPopup.scrollFactor.set();

		interactLockerAlmacen = new InteractObject(1024, 192, 'locker');
		interactLockerAlmacen.sumWidthValue = 30;
		interactLockerAlmacen.flipX = true;
		interactLockerAlmacen.immovable = true;
		interactGroup.add(interactLockerAlmacen);

		lockerAlmacenPopup = new InteractPopup(30, 20, FlxKey.E);
		lockerAlmacenPopup.interactCall = function()
		{
			showFound('Bathroom Key');
		};
		lockerAlmacenPopup.scrollFactor.set();

		FlxG.camera.follow(player, TOPDOWN, 0.7);

		var bar = new FlxBar(152 - 2, 604 - 2, LEFT_TO_RIGHT, 435, 59, player, 'curHealth', 0, 50);
		bar.createImageBar(Paths.image('ui/empty'), Paths.image('ui/fill'));
		bar.scale.set(0.9, 0.9);
		bar.updateHitbox();
		bar.scrollFactor.set();

		var container = new FlxSprite(7, 540, Paths.image('ui/healthbar_empy'));
		container.scale.set(0.9, 0.9);
		container.updateHitbox();
		container.scrollFactor.set();

		bossFish = new Enemy(1856, 256);
		add(bossFish);

		doorBath2Popup = new InteractPopup(30, 20, FlxKey.F);
		doorBath2Popup.interactCall = function()
		{
			doorBath2.open();
			new FlxTimer().start(2.2, function(a)
			{
				add(bossFish);
			});
		};
		doorBath2Popup.scrollFactor.set();

		FlxG.watch.add(bossFish, 'y');

		add(player);

		shadow = new FlxSprite(0, 0, Paths.image('shadow'));
		shadow.scale.set(1.5, 1.5);
		shadow.centerOrigin();
		shadow.centerOffsets();
		add(shadow);

		add(bar);
		add(container);
	}

	function showNothinText()
	{
		var randomDialogue:String = "";
		switch (FlxG.random.int(0, 1))
		{
			case 0:
				randomDialogue = "There's nothing here...";
			case 1:
				randomDialogue = "You didn't find anything.";
		}
		var newShit = new FlxText(0, 0, FlxG.width, randomDialogue);
		var bgnew = new FlxSprite(0, 0).makeGraphic(Std.int(newShit.width - 730), Std.int(newShit.height + 85), FlxColor.BLACK);
		bgnew.screenCenter();
		bgnew.y += 250;
		bgnew.alpha = 0.75;
		bgnew.scrollFactor.set();
		add(bgnew);
		newShit.setFormat(Paths.font('general.TTF'), 45, FlxColor.RED, CENTER, OUTLINE, FlxColor.BLACK);
		newShit.borderSize = 2.5;
		newShit.screenCenter();
		newShit.scrollFactor.set();
		newShit.y += 250;
		newShit.alpha = 0;
		FlxTween.tween(newShit, {alpha: 1}, 0.3, {
			ease: FlxEase.cubeOut,
			onComplete: function(a)
			{
				new FlxTimer().start(1.3, function(a)
				{
					newShit.alpha = 0;
					bgnew.alpha = 0;
				});
			}
		});
		add(newShit);
	}

	function showFound(itemFound:String)
	{
		var newShit = new FlxText(0, 0, FlxG.width, 'You found ' + itemFound + '!');
		var bgnew = new FlxSprite(0, 0).makeGraphic(Std.int(newShit.width - 730), Std.int(newShit.height + 85), FlxColor.BLACK);
		bgnew.screenCenter();
		bgnew.scrollFactor.set();
		bgnew.y += 250;
		bgnew.alpha = 0.75;
		add(bgnew);
		newShit.setFormat(Paths.font('general.TTF'), 45, FlxColor.GREEN, CENTER, OUTLINE, FlxColor.BLACK);
		newShit.borderSize = 2.5;
		newShit.screenCenter();
		newShit.y += 250;
		newShit.scrollFactor.set();
		newShit.alpha = 0;
		FlxTween.tween(newShit, {alpha: 1}, 0.3, {
			ease: FlxEase.cubeOut,
			onComplete: function(a)
			{
				new FlxTimer().start(1.3, function(a)
				{
					newShit.alpha = 0;
					bgnew.alpha = 0;
				});
			}
		});
		add(newShit);
		equippedObject = itemFound.toUpperCase();
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		flixel.FlxG.collide(player, walls);
		FlxG.collide(player, collideObjects);

		FlxG.collide(bossFish, walls);
		checkEnemyVision(bossFish);

		if (FlxG.overlap(player, bossFish))
		{
			damagePlayer();
		}

		if (player.health == 0)
			FlxG.resetState();

		if (FlxG.overlap(player, ovenKitchen.object1))
			add(ovenKitchenPopup);
		else
			remove(ovenKitchenPopup);

		shadow.x = player.x - (shadow.width / 2) + (player.width / 2);
		shadow.y = player.y - (shadow.height / 2) + (player.height / 2);

		if (FlxG.overlap(player, interactLockerOffice.object1))
			add(lockerOfficePopup);
		else
			remove(lockerOfficePopup);

		if (FlxG.overlap(player, bathroom2Sink.object1))
			add(bathroom2SinkPopup);
		else
			remove(bathroom2SinkPopup);

		if (FlxG.overlap(player, interactLockerAlmacen.object1))
			add(lockerAlmacenPopup);
		else
			remove(lockerAlmacenPopup);

		if (FlxG.overlap(player, doorBath2.doorHitbox))
			add(doorBath2Popup);
		else
			remove(doorBath2Popup);

		if (FlxG.overlap(player, doorOfficeBottom.doorHitbox))
			add(doorOfficeBottomPopup);
		else
			remove(doorOfficeBottomPopup);

		if (FlxG.overlap(player, doorStorage2.doorHitbox))
			add(doorStorage2Popup);
		else
			remove(doorStorage2Popup);

		if (FlxG.overlap(player, interactDoorOffice.object1))
			add(doorOfficePopup);
		else
			remove(doorOfficePopup);

		if (FlxG.overlap(player, ventOffice.ventHitbox))
			ventOffice.showIcon(true);
		else
			ventOffice.showIcon(false);

		if (FlxG.overlap(player, ventAlmacen.ventHitbox))
			ventAlmacen.showIcon(true);
		else
			ventAlmacen.showIcon(false);

		if (FlxG.keys.justPressed.SPACE)
		{
			player.health -= 20;
			FlxG.camera.shake(0.01);
		}

		FlxG.collide(player, interactGroup);
		interactDoorOffice.addCollision(player);
		doorAlmacen.addCollision(player);
		doorBath2.addCollision(player);
		doorStorage2.addCollision(player);
		doorOfficeBottom.addCollision(player);
		FlxG.collide(player, ventOffice);
		FlxG.collide(player, ventAlmacen);
	}

	function damagePlayer()
	{
		player.health -= 20;
		bossFish.y -= 40;
		player.y += 40;
	}

	function checkEnemyVision(enemy:Enemy)
	{
		if (walls.ray(enemy.getMidpoint(), player.getMidpoint()))
		{
			enemy.seesPlayer = true;
			enemy.playerPosition = player.getMidpoint();
		}
		else
		{
			enemy.seesPlayer = false;
		}
	}
}
