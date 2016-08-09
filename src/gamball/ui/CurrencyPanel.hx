package gamball.ui;
import engine.entities.FancyBitmapText;
import engine.entities.GameObject;
import gamball.stages.GameStage;
import motion.Actuate;
import motion.easing.Cubic;
import motion.easing.Linear;
import pixi.core.sprites.Sprite;

class CurrencyPanel extends GameObject
{
	private var stage:GameStage;
	private var currencyText:FancyBitmapText;
	private var lastCurrency:Int;
	
	public function new(stage:GameStage)
	{
		super();
		this.stage = stage;
		
		var panel = Sprite.fromImage("assets/textures/ui/currency_panel.png", false);
		panel.anchor.set(0.5, 0.5);
		addChild(panel);
		
		currencyText = Fonts.getFancyText(getCurrencyFormat(stage.currency), 32, Fonts.CONSOLAS_64_BOLD);
		currencyText.x = 20;
		addChild(currencyText);
		
		lastCurrency = stage.currency;
	}
	
	public static function getCurrencyFormat(value:Int):String
	{
		var valueStr = Std.string(value);
		var result = "";
		if (valueStr.length > 3)
		{
			var isExact = valueStr.length % 3 == 0;
			for (i in 1...Math.floor(valueStr.length / 3) + (isExact ? 0 : 1))
			{
				result = "," + valueStr.substr(valueStr.length - i * 3, 3) + result; 
			}
			result = valueStr.substr(0, isExact ? 3 : valueStr.length % 3) + result;
			
			return result;
		}
		
		return valueStr;
	}
	
	private function addFloatingText(diff:Int):Void
	{
		var text:FancyBitmapText;
		
		if (diff < 0)
		{
			text = Fonts.getFancyText(getCurrencyFormat(diff), 32 , Fonts.CONSOLAS_64_BOLD, 0xFF1717);
		}
		else
		{
			text = Fonts.getFancyText("+" + getCurrencyFormat(diff), 52 , Fonts.CONSOLAS_64_BOLD, 0x04FF17);
		}
		text.position.set(currencyText.x, 30);
		addChild(text);
		
		Actuate.tween(text, 1.2, {alpha: 0}).ease(Linear.easeNone);
		Actuate.tween(text.position, 1.2, {y: 100}).ease(Cubic.easeOut).onComplete(function():Void
		{
			removeChild(text);
			text.destroy();
		});
	}
	
	override public function update():Void 
	{
		if (lastCurrency != stage.currency)
		{
			currencyText.text = getCurrencyFormat(stage.currency);
			addFloatingText(stage.currency - lastCurrency);
			lastCurrency = stage.currency;
		}
	}
}