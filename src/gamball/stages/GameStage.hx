package gamball.stages;
import engine.entities.Stage;
import engine.system.Input;
import engine.system.KeyCode;
import engine.system.Physics;
import engine.utils.MathR;
import gamball.configs.GameConfig;
import gamball.entities.Ball;
import gamball.entities.Ball.BallConfig;
import gamball.levels.Level;
import gamball.ui.SidePanel;
import pixi.core.math.Point;

class GameStage extends Stage
{
	public var currency(default, null):Int = 2500;
	public var gameConfig(default, null):GameConfig;
	public var level(default, null):Level;
	public var sidePanel(default, null):SidePanel;
	
	private function new(gameConfig:GameConfig)
	{
		super();
		this.gameConfig = gameConfig;
		
		physics.worldSpace.gravity.y = Physics.meterToPixel(15.0);
		
		addChildWithUpdate(level = new Level(this));
		
		uiLayer.addChildWithUpdate(sidePanel = new SidePanel(this));
		gameplayLayer.addChild(physics.debugDraw);
		
		camera.follow(new Point(), new Point(sidePanel.panelWidth * 0.5, -GamBall.screenHeight * 0.5));
		camera.zoom = 0.5;
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
			var ball = new Ball(MathR.randomFloat(-50, 50), -1200, ballConfig);
			gameplayLayer.addChildWithUpdate(ball, false, 0);
		}
	}
	
	override public function update():Void 
	{
		super.update();
		
		#if debug
		if (Input.isKeyUp(KeyCode.FIVE))
		{
			physics.debugDraw.visible = !physics.debugDraw.visible;
		}
		#end
	}
}