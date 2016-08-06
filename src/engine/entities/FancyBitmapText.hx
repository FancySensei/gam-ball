package engine.entities;
import pixi.extras.BitmapText;

class FancyBitmapText extends GameObject
{
	public var isAutoCentred(default, default):Bool;
	
	public var bitmapText(default, null):BitmapText;
	
	public function new(text:String, ?style:BitmapTextStyle, isAutoCentred:Bool = true)
	{
		super();
		this.isAutoCentred = isAutoCentred;
		
		bitmapText = new BitmapText(text, style);
		if (isAutoCentred) centreText();
		addChild(bitmapText);
	}
	
	public var text(get, set):String;
	private function get_text():String
	{
		return bitmapText.text;
	}
	private function set_text(value:String):String
	{
		bitmapText.text = value;
		if (isAutoCentred) centreText();
		return bitmapText.text;
	}
	
	public inline function centreText():Void
	{
		bitmapText.pivot.set(bitmapText.textWidth * 0.5, bitmapText.textHeight * 0.5);
	}
}