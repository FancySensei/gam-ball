package engine.debug;
import pixi.core.Pixi;
import pixi.core.sprites.Sprite;
import pixi.core.textures.Texture;

class Measurer extends Sprite
{
	private function new(imagePath:String)
	{
		super(Texture.fromImage(imagePath, false, Pixi.SCALE_MODES.NEAREST));
	}
	
	static public function colouredCartesian():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_cartesian_coloured.png");
		measure.pivot.set(32, 224);
		return measure;
	}
	
	static public function blackCartesian():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_cartesian_black.png");
		measure.pivot.set(32, 224);
		return measure;
	}
	
	static public function whiteCartesian():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_cartesian_white.png");
		measure.pivot.set(32, 224);
		return measure;
	}
	
	static public function colouredWin():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_win_coloured.png");
		measure.pivot.set(32, 32);
		return measure;
	}
	
	static public function blackWin():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_win_black.png");
		measure.pivot.set(32, 32);
		return measure;
	}
	
	static public function whiteWin():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_win_white.png");
		measure.pivot.set(32, 32);
		return measure;
	}
	
	static public function colouredCentred():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_centred_coloured.png");
		measure.pivot.set(256, 256);
		return measure;
	}
	
	static public function blackCentred():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_centred_black.png");
		measure.pivot.set(256, 256);
		return measure;
	}
	
	static public function whiteCentred():Measurer
	{
		var measure = new Measurer("assets/debug/measurer_centred_white.png");
		measure.pivot.set(256, 256);
		return measure;
	}
}