package gamball.entities;
import engine.utils.MathR;
import gamball.ui.Fonts;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.sprites.Sprite;

class BonusSensor extends Container
{
	private var ballID:String;
	private var onBallHit:Void->Void;
	private var sensorWidth:Float;
	private var sensorHeight:Float;
	
	public function new(ballID:String, width:Float, height:Float, colour:Int, icon:Sprite, text:String, onBallHit:Void->Void)
	{
		super();
		this.ballID = ballID;
		this.onBallHit = onBallHit;
		this.sensorWidth = width;
		this.sensorHeight = height;
		
		var stripe = new Graphics();
		stripe.beginFill(colour);
		stripe.drawRect(0, 0, width, height);
		stripe.endFill();
		addChild(stripe);
		
		icon.anchor.set(0.5, 0.5);
		icon.position.set(width * 0.5, height * 0.35);
		addChild(icon);
		
		var bonusText = Fonts.getFancyText(text, 32, Fonts.CONSOLAS_64_BOLD);
		bonusText.position.set(width * 0.5, height * 0.75);
		addChild(bonusText);
	}
	
	public function hitTest(ball:Ball):Void
	{
		if (!ball.hasScored && ballID == ballID
			&& MathR.isBetween(ball.x, x, x + sensorWidth) && MathR.isBetween(ball.y, y, y + sensorHeight))
		{
			ball.hasScored = true;
			onBallHit();
		}
	}
}