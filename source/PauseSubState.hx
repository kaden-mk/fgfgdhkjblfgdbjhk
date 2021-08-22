package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class PauseSubState extends MusicBeatSubstate
{
	public static var pracMode:Bool = false;
	public static var blueCount:Int = 0;
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var	difficultyChoices = ["EASY", "NORMAL", "HARD", "BACK"];
	var menuItems:Array<String> = ['Resume', 'Restart Song', 'Toggle Practice Mode', 'Change Difficulty', 'Exit to menu'];
	var curSelected:Int = 0;

	var pauseMusic:FlxSound;

	var offsetChanged:Bool = false;

	public function new(x:Float, y:Float)
	{
		super();

		pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
		levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		var blueBalled:FlxText = new FlxText(20, 15 + 64, 0, "", 32);
		blueBalled.text += "Blue balled: " + blueCount;
		blueBalled.scrollFactor.set();
		blueBalled.setFormat(Paths.font('vcr.ttf'), 32);
		blueBalled.updateHitbox();
		add(blueBalled);

		if (pracMode == true)
		{
			var pracText:FlxText = new FlxText(20, 15 + 96, 0, "", 32);
			pracText.text += "PRACTICE MODE";
			pracText.scrollFactor.set();
			pracText.setFormat(Paths.font('vcr.ttf'), 32);
			pracText.updateHitbox();
			add(pracText);
			
			pracText.alpha = 0;
			pracText.x = FlxG.width - (pracText.width + 20);
			FlxTween.tween(pracText, {alpha: 1, y: pracText.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.9});
		}

		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;
		blueBalled.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
		blueBalled.x = FlxG.width - (blueBalled.width + 20);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(blueBalled, {alpha: 1, y: blueBalled.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (accepted)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Resume":
					close();
				case "Restart Song":
					FlxG.resetState();
				case "Exit to menu":
					FlxG.switchState(new MainMenuState());
				case "Toggle Practice Mode":
                    if (pracMode == true)
					{
                        pracMode = false;
                    }
					else
                    {
                        pracMode = true;
                    }
					case "Change Difficulty":
						grpMenuShit.clear();
	
						menuItems = ['Back', 'Easy', 'Normal', 'Hard'];
						curSelected = 0;
	
						for (i in 0...menuItems.length)
						{
							var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
							songText.isMenuItem = true;
							songText.targetY = i;
							grpMenuShit.add(songText);
						}
	
						changeSelection();
	
						cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
						offsetChanged = true;
					case "Back":
						grpMenuShit.clear();
	
						menuItems = ['Resume', 'Restart Song', 'Toggle Practice Mode', "Change Difficulty", 'Exit to menu'];
						curSelected = 0;
	
						for (i in 0...menuItems.length)
						{
							var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
							songText.isMenuItem = true;
							songText.targetY = i;
							grpMenuShit.add(songText);
						}
	
						changeSelection();
	
						cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
						offsetChanged = true;
					case "Easy":
						PlayState.storyDifficulty = 0;
						PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + '-easy', StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
						FlxG.resetState();
					case "Normal":
						PlayState.storyDifficulty = 1;
						PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + '', StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
						FlxG.resetState();
					case "Hard":
						PlayState.storyDifficulty = 2;
						PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + '-hard', StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
						FlxG.resetState();
			}
		}

		if (FlxG.keys.justPressed.J)
		{
			// for reference later!
			// PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxKey.J, null);
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
