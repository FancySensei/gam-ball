package gamball.stages;
import engine.entities.Stage;
import engine.system.Input;
import engine.system.KeyCode;
import engine.utils.MathR;
import gamball.configs.GameConfig;
import gamball.entities.Ball;
import gamball.entities.Ball.BallConfig;
import gamball.entities.Box;
import gamball.ui.SidePanel;

class GameStage extends Stage
{
	public var currency(default, null):Int = 2500;
	public var gameConfig(default, null):GameConfig;
	
	private function new(gameConfig:GameConfig)
	{
		super();
		this.gameConfig = gameConfig;
		
		uiLayer.addChildWithUpdate(new SidePanel(this));
		gameplayLayer.addChild(physics.debugDraw);
		
		var box = new Box(0, 0, 2000, 50);
		addChildWithUpdate(box);
	}
	
	static public function load(callback:GameStage->Void):Void
	{
		GameConfig.load(function(gameConfig:GameConfig):Void
		{
			callback(new GameStage(gameConfig));
		});
	}
	
	public function generateBall(ballConfig:BallConfig):Void
	{
		if (currency >= ballConfig.cost)
		{
			currency -= ballConfig.cost;
			var ball = new Ball(MathR.randomFloat(-50, 50), -600, ballConfig);
			camera.follow(ball.position);
			camera.zoom = 0.5;
			gameplayLayer.addChildWithUpdate(ball, false, 0);
		}
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.isKeyUp(KeyCode.FIVE))
		{
			physics.debugDraw.visible = !physics.debugDraw.visible;
		}
	}
}