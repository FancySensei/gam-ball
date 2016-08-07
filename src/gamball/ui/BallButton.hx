package gamball.ui;
import gamball.ui.Button.ButtonConfig;
import pixi.core.sprites.Sprite;

class BallButton extends Button
{
	static private inline var PATH:String = "assets/textures/sprites/";
	
	public function new(fileName:String, cost:Int, callback:Void->Void)
	{
		var btnConfig:ButtonConfig =
		{
			width: 180,
			height: 75,
			surfaceColour: 0xFF3297,
			baseColour: 0xB8095F,
			springHeight: 16,
			cooldown: 0.1
		}
		
		super(btnConfig, callback);
		
		var icon = Sprite.fromImage(PATH + fileName, false);
		icon.anchor.set(0.5, 0.5);
		icon.scale.set(0.5, 0.5);
		icon.position.set(45, Math.round(btnConfig.height / 2));
		surface.addChild(icon);
		
		var costText = Fonts.getFancyText("£" + CurrencyPanel.getCurrencyFormat(cost), 48, Fonts.CONSOLAS_64_BOLD);
		costText.position.set(125, icon.y);
		surface.addChild(costText);
	}
	
}