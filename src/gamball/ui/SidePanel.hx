package gamball.ui;
import engine.entities.GameObject;
import gamball.stages.GameStage;
import gamball.ui.Button.ButtonConfig;
import pixi.core.graphics.Graphics;

class SidePanel extends GameObject
{
	public var currencyPanel(default, null):CurrencyPanel;
	
	private var stage:GameStage;
	private var panelWidth:Float;
	private var bg:Graphics;
	
	public function new(stage:GameStage)
	{
		super();
		this.stage = stage;
		
		panelWidth = GamBall.screenHeight * 0.41;
		x = GamBall.screenWidth - panelWidth;
		y = -1; // extra padding
		
		bg = new Graphics();
		bg.beginFill(0x000000, 0.65);
		bg.drawRect(0, 0, panelWidth + 1, GamBall.screenHeight + 2); // with extra paddings
		bg.endFill();
		addChild(bg);
		
		currencyPanel = new CurrencyPanel(stage);
		currencyPanel.position.set(Math.round(panelWidth * 0.5), 80);
		addChildWithUpdate(currencyPanel);
		
		var ballBtn1 = new BallButton("ball_candy.png", 3, function():Void
		{
			
		});
		ballBtn1.position.set(currencyPanel.x, GamBall.screenHeight * 0.5);
		addChild(ballBtn1);
		
		var ballBtn2 = new BallButton("ball_8.png", 8, function():Void
		{
			
		});
		ballBtn2.position.set(currencyPanel.x, ballBtn1.y + 110);
		addChild(ballBtn2);
		
		var ballBtn3 = new BallButton("ball_pokemon.png", 25, function():Void
		{
			
		});
		ballBtn3.position.set(currencyPanel.x, ballBtn2.y + 110);
		addChild(ballBtn3);
	}
}