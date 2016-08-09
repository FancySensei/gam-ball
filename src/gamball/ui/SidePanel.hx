package gamball.ui;
import engine.entities.GameObject;
import gamball.entities.Ball;
import gamball.stages.GameStage;
import gamball.ui.Button.ButtonConfig;
import pixi.core.graphics.Graphics;

class SidePanel extends GameObject
{
	public var currencyPanel(default, null):CurrencyPanel;
	public var timeWarpPanel(default, null):TimeWarpPanel;
	public var panelWidth(default, null):Float;
	
	private var stage:GameStage;
	private var bg:Graphics;
	
	public function new(stage:GameStage)
	{
		super();
		this.stage = stage;
		
		panelWidth = GamBall.screenHeight * 0.41;
		x = GamBall.screenWidth - panelWidth;
		y = -1; // extra padding
		
		bg = new Graphics();
		bg.beginFill(0x41454D);
		bg.drawRect(0, 0, panelWidth + 1, GamBall.screenHeight + 2); // with extra paddings
		bg.endFill();
		addChild(bg);
		
		currencyPanel = new CurrencyPanel(stage);
		currencyPanel.position.set(Math.round(panelWidth * 0.5), 90);
		addChildWithUpdate(currencyPanel);
		
		timeWarpPanel = new TimeWarpPanel();
		timeWarpPanel.position.set(Math.round(panelWidth * 0.5), GamBall.screenHeight - 100);
		addChildWithUpdate(timeWarpPanel);
		
		var btnY = Math.round(GamBall.screenHeight * 0.45);
		createBallButton(Ball.BALL_CANDY_ID, btnY);
		btnY += 120;
		createBallButton(Ball.BALL_8_ID, btnY);
		btnY += 120;
		createBallButton(Ball.BALL_POKEMON_ID, btnY);
	}
	
	private function createBallButton(id:String, y:Float)
	{
		var ballConfig = stage.gameConfig.ballConfigs.get(id);
		var ballBtn = new BallButton(ballConfig.texture, ballConfig.cost, function():Void
		{
			stage.generateBall(id, ballConfig);
		});
		ballBtn.position.set(currencyPanel.x, y);
		addChild(ballBtn);
	}
}