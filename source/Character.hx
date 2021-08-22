package;

import cpp.abi.Abi;
import flixel.FlxG;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.display.InteractiveObject;
import openfl.display3D.textures.Texture;
import flixel.util.FlxSort;
import flixel.animation.FlxAnimationController;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var exSpikes:FlxSprite;

	public var animations:Array<FlxAnimationController> = [];

	public var holdTimer:Float = 0;

	public var otherFrames:Array<Character>;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			// 1: gf code

			case 'gf':
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'gf-tied':
				tex = Paths.getSparrowAtlas('characters/EX Tricky GF','shared');
				frames = tex;

				animation.addByIndices('danceLeft','GF Ex Tricky',[0,1,2,3,4,5,6,7,8], "", 24, false);
				animation.addByIndices('danceRight','GF Ex Tricky',[9,10,11,12,13,14,15,16,17,18,19], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-hell':
				tex = Paths.getSparrowAtlas('hellclwn/GF/gf_phase_3','clown');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

				// 2: dad character code code

			case 'trickyH':
				tex = Paths.getSparrowAtlas('hellThings/Idle', 'shared');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Phase 3 Tricky Idle', 24);
				
				// they have to be left right up down, in that order.
				// cuz im too lazy to dynamicly get these names
				// cry about it

				otherFrames = new Array<Character>();

				
				otherFrames.push(new Character(100, 100, 'trickyHLeft'));
				otherFrames.push(new Character(100, 100, 'trickyHRight'));
				otherFrames.push(new Character(100, 100, 'trickyHUp'));
				otherFrames.push(new Character(100, 100, 'trickyHDown'));

				animations.push(animation);
				for (i in otherFrames)
					animations.push(animation);

				trace('poggers');

				addOffset("idle", 325, 0);
				playAnim('idle');
			case 'trickyHDown':
				tex = Paths.getSparrowAtlas('hellThings/Down', 'shared');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Down', 24);

				addOffset("idle",475, -450);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHUp':
				tex = Paths.getSparrowAtlas('hellThings/Up', 'shared');


				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Up', 24);

				addOffset("idle", 575, -450);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHRight':
				tex = Paths.getSparrowAtlas('hellThings/right', 'shared');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Right', 24);

				addOffset("idle",485, -300);

				y -= 2000;
				x -= 1400;

				playAnim('idle');
			case 'trickyHLeft':
				tex = Paths.getSparrowAtlas('hellThings/Left', 'shared');

				frames = tex;

				graphic.persist = true;
				graphic.destroyOnNoUse = false;

				animation.addByPrefix('idle','Proper Left', 24);

				addOffset("idle", 516, 25);

				y -= 2000;
				x -= 1400;
				
				playAnim('idle');

			case 'dad':
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST');
				frames = tex;
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'mom-car':
				tex = Paths.getSparrowAtlas('characters/momCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('characters/Monster_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('characters/monsterChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'bf-hell':
				var tex = Paths.getSparrowAtlas('hellclwn/BF/BF_3rd_phase','clown');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('stunned', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);

				addOffset('scared', -4);

				playAnim('idle');
	
				flipX = true;

			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');

			case 'pico-speaker':
				tex = Paths.getSparrowAtlas('characters/picoSpeaker', 'shared');
				frames = tex;
				animation.addByPrefix('shoot1', 'Pico shoot 1', 24, false);
				animation.addByPrefix('shoot2', 'Pico shoot 2', 24, false);
				animation.addByPrefix('shoot3', 'Pico shoot 3', 24, false);
				animation.addByPrefix('shoot4', 'Pico shoot 4', 24, false);

				addOffset('shoot1');
				addOffset('shoot2', -1, -128);
				addOffset('shoot3', 412, -64);
				addOffset('shoot4', 439, -19);

				loadMappedAnims();

				playAnim('shoot1');

			case 'tankman':
				flipX = true;
				tex = Paths.getSparrowAtlas('characters/tankmanCaptain');
				frames = tex;
				animation.addByPrefix('idle', 'Tankman Idle Dance instance', 24);
				animation.addByPrefix('singUP', 'Tankman UP note instance', 24);
				animation.addByPrefix('singRIGHT', 'Tankman Note Left instance', 24);
				animation.addByPrefix('singLEFT', 'Tankman Right Note instance', 24);
				animation.addByPrefix('singDOWN', 'Tankman DOWN note instance', 24);
				animation.addByPrefix('singUP-alt', 'TANKMAN UGH instance', 24);
				animation.addByPrefix('pg', 'PRETTY GOOD tankman instance ', 24);

				addOffset('idle');
				addOffset('singUP', 24, 56);
				addOffset('singRIGHT', -1, -7);
				addOffset('singLEFT', 100, -14);
				addOffset('singDOWN', 98, -90);
				addOffset('singUPalt', 24, 56);
				addOffset('singDOWNalt', 98, -90);

				playAnim('idle');

			case 'gf-tankmen':
				tex = Paths.getSparrowAtlas('characters/gfTankmen','shared');
				frames = tex;
				animation.addByIndices('idle', 'GF Dancing at Gunpoint', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('sad', 'GF Crying at Gunpoint ', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing at Gunpoint', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing at Gunpoint', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);

				addOffset('sad', 0, -18);
				addOffset('danceLeft', 0, 0);
				addOffset('danceRight', 0, 0);

				playAnim('danceRight');

			case 'bf-holding-gf':
				var tex = Paths.getSparrowAtlas('characters/bfAndGF');
				frames = tex;
				animation.addByPrefix("idle", "BF idle dance w gf", 24, false);
				animation.addByPrefix("singDOWN", "BF NOTE DOWN0", 24, false);
				animation.addByPrefix("singLEFT", "BF NOTE LEFT0", 24, false);
				animation.addByPrefix("singRIGHT", "BF NOTE RIGHT0", 24, false);
				animation.addByPrefix("singUP", "BF NOTE UP0", 24, false);
				animation.addByPrefix("singDOWNmiss", "BF NOTE DOWN MISS", 24, false);
				animation.addByPrefix("singLEFTmiss", "BF NOTE LEFT MISS", 24, false);
				animation.addByPrefix("singRIGHTmiss", "BF NOTE RIGHT MISS", 24, false);
				animation.addByPrefix("singUPmiss", "BF NOTE UP MISS", 24, false);
				animation.addByPrefix("bfCatch", "BF catches GF", 24, false);

				addOffset('idle', 0, 0);
				addOffset('singUP', -29, 10);
				addOffset('singRIGHT', -41, 23);
				addOffset('singLEFT', 12, 7);
				addOffset('singDOWN', -10, -10);
				addOffset('singUPmiss', -29, 10);
				addOffset('singRIGHTmiss', -41, 23);
				addOffset('singLEFTmiss', 12, 7);
				addOffset('singDOWNmiss', -10, -10);
				addOffset('bfCatch', 0, 0);

				playAnim("idle");

				flipX = true;

			case "bf-holding-gf-dead":
				var tex = Paths.getSparrowAtlas('characters/bfHoldingGF-DEAD');
				frames = tex;
				animation.addByPrefix("firstDeath", "BF Dies with GF", 24, false);
				animation.addByPrefix("deathLoop", "BF Dead with GF Loop", 24, true);
				animation.addByPrefix("deathConfirm", "RETRY confirm holding gf", 24, false);

				addOffset('firstDeath', 37, 14);
				addOffset('deathLoop', 37, -3);
				addOffset('deathConfirm', 37, 28);

				playAnim("firstDeath");

				flipX = true;

			case 'bf-signDeath':
				frames = Paths.getSparrowAtlas('signDeath','clown');
				animation.addByPrefix('firstDeath', 'BF dies', 24, false);
				animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, false);
				animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
				
				playAnim('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop');
				addOffset('deathConfirm', 0, 40);

				animation.pause();

				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'exTricky':
				frames = Paths.getSparrowAtlas('characters/EXTRICKY');
				exSpikes = new FlxSprite(x - 350,y - 170);
				exSpikes.frames = Paths.getSparrowAtlas('exThings/FloorSpikes','shared');
				exSpikes.visible = false;

				exSpikes.animation.addByPrefix('spike','Floor Spikes', 24, false);

				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('Hank', 'Hank', 24, true);

				addOffset('idle');
				addOffset('Hank');
				addOffset("singUP", 0, 100);
				addOffset("singRIGHT", -209,-29);
				addOffset("singLEFT",127,20);
				addOffset("singDOWN",-100,-340);

				playAnim('idle');

			case 'tricky':
				tex = Paths.getSparrowAtlas('tricky','clown');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -75);
				addOffset("singUP", 93, -76);
				addOffset("singRIGHT", 16, -176);
				addOffset("singLEFT", 103, -72);
				addOffset("singDOWN", 6, -84);

				playAnim('idle');
			
			case 'trickyMask':
				tex = Paths.getSparrowAtlas('TrickyMask','clown');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -117);
				addOffset("singUP", 93, -100);
				addOffset("singRIGHT", 16, -164);
				addOffset("singLEFT", 194, -95);
				addOffset("singDOWN", 32, -168);

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function addOtherFrames()
	{
		
		for (i in otherFrames)
			{
				PlayState.staticVar.add(i);
				i.visible = false;
			}
	}

	override function update(elapsed:Float)
	{
		if (!isPlayer)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				if (curCharacter != 'trickyHLeft' && curCharacter != 'trickyHRight' && curCharacter != 'trickyHDown' && curCharacter != 'trickyHUp')
				{
					dance();
					holdTimer = 0;
				}
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
			case 'pico-speaker':
				if (animationNotes.length > 0 && Conductor.songPosition > animationNotes[0][0])
				{
					var shootAnim = 1;
					if (animationNotes[0][1] >= 2)
						shootAnim = 3;

					shootAnim += FlxG.random.int(0, 1);
					playAnim("shoot" + shootAnim, true);
					animationNotes.shift();
				}
				if (animation.curAnim != null && animation.curAnim.finished)
				{
					playAnim(animation.curAnim.name, false, false, animation.curAnim.frames.length - 3);
				}
			case 'exTricky':
				if (exSpikes.animation.frameIndex >= 3 && animation.curAnim.name == 'singUP')
				{
					// removed trace cuz the fucking terminal is gonna kill my pc
					exSpikes.animation.pause();
				}
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel' | 'gf-tankmen' | 'gf-tied' | 'gf-hell':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'pico-speaker':
					{
						//Fuck you dumbass
						// also fuck ur mom ez :hewh:
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
			if (debugMode && otherFrames != null)
			{
				/*if (AnimationDebug.dad != null)
				{
					trace('debug play anim ' + AnimName);
					AnimationDebug.dad.alpha = 0.6;
					for(i in otherFrames)
					{
						i.visible = false;
					}

					
					switch(AnimName)
					{
						case 'singLEFT':
							otherFrames[0].visible = true;
							otherFrames[0].playAnim('idle', Force, Reversed, Frame);
						case 'singRIGHT':
							otherFrames[1].visible = true;
							otherFrames[1].playAnim('idle', Force, Reversed, Frame);
						case 'singUP':
							otherFrames[2].visible = true;
							otherFrames[2].playAnim('idle', Force, Reversed, Frame);
						case 'singDOWN':
							otherFrames[3].visible = true;
							otherFrames[3].playAnim('idle', Force, Reversed, Frame);
						default:
							AnimationDebug.dad.alpha = 1;
							animation.play('idle', Force, Reversed, Frame);
					}
				}*/
			}
			else if (otherFrames != null && PlayState.dad != null && PlayState.generatedMusic)
				{
					visible = false;
					for(i in otherFrames)
					{
						i.visible = false;
						i.x = x;
						i.y = y + 60;
					}

					switch(AnimName)
					{
						case 'singLEFT':
							otherFrames[0].visible = true;
							otherFrames[0].playAnim('idle', Force, Reversed, Frame);
						case 'singRIGHT':
							otherFrames[1].visible = true;
							otherFrames[1].playAnim('idle', Force, Reversed, Frame);
						case 'singUP':
							otherFrames[2].visible = true;
							otherFrames[2].playAnim('idle', Force, Reversed, Frame);
							otherFrames[2].y += 20;
						case 'singDOWN':
							otherFrames[3].visible = true;
							otherFrames[3].playAnim('idle', Force, Reversed, Frame);
						default:
							visible = true;

							animation.play(AnimName, Force, Reversed, Frame);

							var daOffset = animOffsets.get(AnimName);
							if (animOffsets.exists(AnimName))
								offset.set(daOffset[0], daOffset[1]);
							else
								offset.set(0, 0);
					}
				}
				else if (otherFrames != null && PlayState.dad != null)
				{
					visible = true;
					animation.play('idle', Force, Reversed, Frame);
					
					var daOffset = animOffsets.get('idle');
					if (animOffsets.exists('idle'))
						offset.set(daOffset[0], daOffset[1]);
					else
						offset.set(0, 0);
				}
		else
		{
			animation.play(AnimName, Force, Reversed, Frame);

			if (curCharacter == 'exTricky')
			{
				if (AnimName == 'singUP')
				{
					trace('spikes');
					exSpikes.visible = true;
					if (exSpikes.animation.finished)
						exSpikes.animation.play('spike');
				}
				else if (!exSpikes.animation.finished)
				{
					exSpikes.animation.resume();
					trace('go back spikes');
					exSpikes.animation.finishCallback = function(pog:String) {
						trace('finished');
						exSpikes.visible = false;
						exSpikes.animation.finishCallback = null;
					}
				}
			}

			var daOffset = animOffsets.get(AnimName);
			if (animOffsets.exists(AnimName))
			{
				offset.set(daOffset[0], daOffset[1]);
			}
			else
				offset.set(0, 0);
			if (curCharacter == 'gf')
			{
				if (AnimName == 'singLEFT')
				{
					danced = true;
				}
				else if (AnimName == 'singRIGHT')
				{
					danced = false;
				}
	
				if (AnimName == 'singUP' || AnimName == 'singDOWN')
				{
					danced = !danced;
				}
			}
		}
	}
	public var animationNotes:Array<Dynamic> = [];

	public function loadMappedAnims()
	{
		var swagshit = Song.loadFromJson("pico-speaker", "stress");

		var notes = swagshit.notes;

		for (section in notes)
		{
			for (idk in section.sectionNotes)
			{
				animationNotes.push(idk);
			}
		}

		TankmenBG.animationNotes = animationNotes;

		animationNotes.sort(sortAnims);
	}

	function sortAnims(val1:Array<Dynamic>, val2:Array<Dynamic>):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, val1[0], val2[0]);
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
