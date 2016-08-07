package gamball.ui;
import engine.entities.FancyBitmapText;
import engine.entities.GameObject;
import gamball.stages.GameStage;
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
	
	override public function update():Void 
	{
		if (lastCurrency != stage.currency)
		{
			currencyText.text = getCurrencyFormat(stage.currency);
			lastCurrency = stage.currency;
		}
	}
}