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

using StringTools;

class Caching extends MusicBeatState
{
    var done = 0;

    var text:FlxText;
    var logo:FlxSprite;

	override function create()
    {
        FlxG.mouse.visible = false;
    
        FlxG.worldBounds.set(0,0);
    
        text = new FlxText(FlxG.width / 2, FlxG.height / 2 + 300,0,"Loading The Shit");
        text.size = 34;
        text.alignment = FlxTextAlign.CENTER;
    
        logo = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic(Paths.image('logo'));
        logo.x -= logo.width / 2;
        logo.y -= logo.height / 2 + 100;
        text.y -= logo.height / 2 - 125;
        text.x -= 170;
        logo.setGraphicSize(Std.int(logo.width * 0.6));
    
        add(logo);
        add(text);
    
        trace('Startin to cache shit');
            
        sys.thread.Thread.create(() -> {
            cache();
        });
    
    
            super.create();
        }

    function cache()
    {
        var music = [];
        var images = [];
        var fard = [];

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
        {
            music.push(i);
        }

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
        {
            if (!i.endsWith(".png"))
                continue;
            images.push(i);
        }

        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/exThings")))
        {
            fard.push(i);
        }

        for (i in music)
        {
            FlxG.sound.cache(Paths.inst(i));
            FlxG.sound.cache(Paths.voices(i));
            trace("cached " + i);
            done++;
        }

        for (i in fard)
        {
            var replaceded = i.replace(".png","");
            FlxG.bitmap.add(Paths.image("exThings/" + replaceded,"shared"));
            trace("cached " + replaceded);
            done++;
        }

        for (i in images)
        {
            var replaced = i.replace(".png","");
            FlxG.bitmap.add(Paths.image("characters/" + replaced,"shared"));
            trace("cached " + replaced);
            done++;
        }

        trace('caching = done');

        FlxG.switchState(new TitleState());       
    }
}