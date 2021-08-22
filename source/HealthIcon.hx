package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		switch (char)
		{
			case 'trickyMask' | 'tricky':
				loadGraphic(Paths.image('IconGridTricky','clown'), true, 150, 150);

				antialiasing = true;
				animation.add('tricky', [2, 3], 0, false, isPlayer);
				animation.add('trickyMask', [0, 1], 0, false, isPlayer);
			case 'trickyH':
				loadGraphic(Paths.image('hellclwn/hellclownIcon','clown'), true, 150, 150);
				animation.add('trickyH', [0, 1], 0, false, isPlayer);
				y -= 25;
			default:
				loadGraphic(Paths.image('iconGrid'), true, 150, 150);

			animation.add('bf', [0, 1], 0, false, isPlayer);
			animation.add('bf-hell', [0, 1], 0, false, isPlayer);
			animation.add('bf-holding-gf', [0, 1], 0, false, isPlayer);
			animation.add('bf-car', [0, 1], 0, false, isPlayer);
			animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
			animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
			animation.add('spooky', [2, 3], 0, false, isPlayer);
			animation.add('bf-spooky', [2, 3], 0, false, isPlayer);
			animation.add('pico', [4, 5], 0, false, isPlayer);
			animation.add('pico-speaker', [4, 5], 0, false, isPlayer);
			animation.add('mom', [6, 7], 0, false, isPlayer);
			animation.add('mom-car', [6, 7], 0, false, isPlayer);
			animation.add('tankman', [8, 9], 0, false, isPlayer);
			animation.add('face', [10, 11], 0, false, isPlayer);
			animation.add('dad', [12, 13], 0, false, isPlayer);
			animation.add('senpai', [22, 22], 0, false, isPlayer);
			animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
			animation.add('spirit', [23, 23], 0, false, isPlayer);
			animation.add('exTricky', [24, 25], 0, false, isPlayer);
			animation.add('bf-old', [14, 15], 0, false, isPlayer);
			animation.add('gf', [16], 0, false, isPlayer);
			animation.add('gf-hell', [16], 0, false, isPlayer);
			animation.add('gf-tankmen', [16], 0, false, isPlayer);
			animation.add('parents-christmas', [17], 0, false, isPlayer);
			animation.add('monster', [19, 20], 0, false, isPlayer);
			animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
		}
		antialiasing = true;
		animation.play(char);
		scrollFactor.set();
	}
	// thanks tiky

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}