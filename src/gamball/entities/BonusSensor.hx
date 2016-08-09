package gamball.entities;
import engine.entities.GameObject;
import gamball.ui.Fonts;
import pixi.core.graphics.Graphics;
import pixi.core.sprites.Sprite;

class BonusSensor extends GameObject
{
	public function new(width:Float, height:Float, colour:Int, icon:Sprite, text:String, onBallHit:Void->Void)
	{
		super();
		
		var stripe = new Graphics();
		stripe.beginFill(colour);
		stripe.drawRect(0, 0, width, height);
		stripe.endFill();
		addChild(stripe);
		
		icon.anchor.set(0.5, 0.5);
		icon.position.set(width * 0.5, height * 0.3);
		addChild(icon);
		
		var bonusText = Fonts.getFancyText(text, 14, Fonts.CONSOLAS_NUMBERS_72_BOLD);
		bonusText.position.set(width * 0.5, height * 0.65);
		addChild(bonusText);
	}
	
}