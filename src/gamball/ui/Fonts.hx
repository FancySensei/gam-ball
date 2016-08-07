package gamball.ui;
import engine.entities.FancyBitmapText;
import pixi.loaders.Loader;
import pixi.loaders.LoaderOptions;

class Fonts
{
	static public inline var CALIBRI_32_BOLD:String = "Calibri 32 Bold";
	static public inline var CALIBRI_64_BOLD:String = "Calibri 64 Bold";
	static public inline var CONSOLAS_64_BOLD:String = "Consolas 64 Bold";
	static public inline var CONSOLAS_NUMBERS_72_BOLD:String = "Consolas Numbers 72 Bold";
	static public inline var LUCIDA_CONSOLE_14_BOLD:String = "Lucida Console 14 Bold";
	
	private function new() {}
	
	static public function load(?callback:Void->Void):Void
	{
		var loadOption:LoaderOptions = { crossOrigin: false };
		
		new Loader()
		.add("assets/fonts/calibri_32_bold.fnt", loadOption)
		.add("assets/fonts/calibri_64_bold.fnt", loadOption)
		.add("assets/fonts/consolas_64_bold.fnt", loadOption)
		.add("assets/fonts/consolas_numbers_72_bold.fnt", loadOption)
		.add("assets/fonts/lucida_console_14_bold.fnt", loadOption)
		.load(callback);
	}
	
	static public function getFancyText(text:String, size:Int, font:String, ?colour:Int, isAutoCentred:Bool = true):FancyBitmapText
	{
		if (colour == null) colour = 0xFFFFFF;
		
		return new FancyBitmapText(text, { font: Std.string(size) + "px " + font, tint:colour }, isAutoCentred);
	}
}