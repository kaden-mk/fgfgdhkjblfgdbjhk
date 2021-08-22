package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	var daStage = PlayState.curStage;
	var daBf:String = '';

	public function new(x:Float, y:Float)
	{
		switch (daStage)
		{
			case 'school':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'schoolEvil':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'nevada':
				stageSuffix = '-clown';
				daBf = 'bf-signDeath';
			case 'nevadaSpook':
				stageSuffix = '-clown';
				daBf = 'bf-signDeath';
			case 'auditorHell':
				stageSuffix = '-clown';
				daBf = 'bf-signDeath';
			default:
				daBf = 'bf';
		}

		if (PlayState.SONG.song.toLowerCase() == "stress")
			daBf = 'bf-holding-gf-dead';

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		if (daBf == 'bf-signDeath')
		{
			FlxG.sound.play(Paths.sound('BF_Deathsound'));
			FlxG.sound.play(Paths.sound('fnf_loss_sfx-clown'));
			Conductor.changeBPM(200);
		}
		else
 		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		if (daBf == 'bf-signDeath')
		{
			bf.playAnim('firstDeath');
			bf.animation.resume();
		}
		else
		bf.playAnim('firstDeath');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
		}

	if (daStage != 'nevada' || daStage != 'nevadaSpook' || daStage != 'auditorHell')
	{
		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}
	}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			if (PlayState.SONG.song.toLowerCase() == "ugh" || PlayState.SONG.song.toLowerCase() == "guns" || PlayState.SONG.song.toLowerCase() == "stress")
			FlxG.sound.play(Paths.sound('jeffGameover-' + FlxG.random.int(1, 25) + stageSuffix), 999);
			else
			FlxG.sound.music.stop();
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			if (daBf == 'bf-signDeath')
			{
				bf.playAnim('deathLoop', true);
			}
		}

		else if (bf.animation.curAnim.finished && bf.animation.curAnim.name != 'deathConfirm' && daBf == 'bf-signDeath')
		{
			bf.playAnim('deathLoop', true);
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
