package;

import haxe.Exception;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import sys.FileSystem;
import sys.io.File;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.ui.FlxBar;

using StringTools;

class LoadingScreen extends PlayState
{
    var loadingBar:FlxBar;
    var loadingScreen:FlxSprite;

    override function create()
    {
        FlxG.mouse.visible = false;

        loadingScreen = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic(Paths.image('funkay'));
        loadingScreen.x -= loadingScreen.width / 2;
        loadingScreen.y -= loadingScreen.height / 2 + 100;
        loadingScreen.height / 2 - 125;
        loadingScreen.setGraphicSize(Std.int(loadingScreen.width * 69));

        loadingBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 1000, 10, this, "variableToTrack", 0, 100, true);
        loadingBar.createFilledBar(FlxColor.PINK, FlxColor.PINK, true, FlxColor.PINK);

        add(loadingScreen);
        add(loadingBar);

        trace("loading da scren");

        super.create();
    }

    override function update(elapsed:Float)
    {
        if (loadingBar.value == 100)
        {
            FlxG.switchState(new PlayState());
        }

        super.update(elapsed);
    }
}