package gamball.entities;
import engine.utils.MathR;
import gamball.ui.Fonts;
import motion.Actuate;
import motion.easing.Expo;
import motion.easing.Linear;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.sprites.Sprite;

class BonusSensor extends Container
{
	public var sensorWidth(default, null):Float;
	public var sensorHeight(default, null):Float;
	
	private var ballID:String = null;
	private var onBallHit:Ball->Void;
	private var boarder:Graphics;
	
	public function new(ballID:String, width:Float, height:Float, colour:Int, icon:Sprite, text:String, onBallHit:Ball->Void)
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
		
		boarder = new Graphics();
		boarder.lineStyle(10, 0xFFFFFF);
		boarder.drawRect( -width / 2, -height / 2, width, height);
		boarder.position.set(width / 2, height / 2);
		boarder.alpha = 0;
		addChild(boarder);
		
		icon.anchor.set(0.5, 0.5);
		icon.position.set(width * 0.5, height * (text != null ? 0.35 : 0.5));
		addChild(icon);
		
		if (text != null)
		{
			var bonusText = Fonts.getFancyText(text, 38, Fonts.CALIBRI_32_BOLD);
			bonusText.position.set(width * 0.5, height * 0.75);
			addChild(bonusText);
		}
	}
	
	public function hitTest(ball:Ball):Void
	{
		// Once the ball in the area, it's done
		if (!ball.isDone
			&& MathR.isBetween(ball.y, y, y + sensorHeight)
			&& MathR.isBetween(ball.x, x, x + sensorWidth))
		{
			ball.isDone = true;
			// If it's the right ball (or crown), reward the player
			if (ballID == null || ball.id == ballID)
			{
				onBallHit(ball);
				boarder.alpha = 1.0;
				Actuate.tween(boarder, 0.3, {alpha: 0}).ease(Linear.easeNone);
				boarder.scale.set(0.9, 0.9);
				Actuate.tween(boarder.scale, 0.3, {x: 1.0, y: 1.05}).ease(Expo.easeOut);
			}
		}
	}
}