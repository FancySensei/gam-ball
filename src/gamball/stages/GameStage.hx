package gamball.stages;
import engine.entities.Stage;
import engine.system.Input;
import engine.system.KeyCode;
import engine.system.Physics;
import engine.utils.MathR;
import gamball.configs.GameConfig;
import gamball.entities.Ball;
import gamball.entities.Ball.BallConfig;
import gamball.entities.BonusArea;
import gamball.levels.Level;
import gamball.ui.SidePanel;
import pixi.core.math.Point;

class GameStage extends Stage
{
	static private inline var WORLD_BOTTOM:Float = 100;
	
	public var currency(default, null):Int = 2500;
	public var gameConfig(default, null):GameConfig;
	public var level(default, null):Level;
	public var sidePanel(default, null):SidePanel;
	public var balls(default, null):Array<Ball> = [];
	public var bonusArea(default, null):BonusArea;
	
	private var ballSpawnPosX:Float = -550;
	
	private function new(gameConfig:GameConfig)
	{
		super();
		this.gameConfig = gameConfig;
		
		physics.worldSpace.gravity.y = Physics.meterToPixel(15.0);
		
		addChildWithUpdate(bonusArea = new BonusArea(this));
		
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
	
	public function generateBall(ballID:String, ballConfig:BallConfig):Void
	{
		if (currency >= ballConfig.cost)
		{
			ballSpawnPosX *= -1.0;
			currency -= ballConfig.cost;
			var ball = new Ball(ballSpawnPosX, -1500, ballID, ballConfig);
			balls.push(ball);
			gameplayLayer.addChildWithUpdate(ball);
		}
	}
	
	public function rewardCurrency(cost:Int, bonus:Int):Void
	{
		currency += cost * bonus;
	}
	
	override public function update():Void 
	{
		super.update();
		
		var removeList:Array<Int> = [];
		for (i in 0...balls.length)
		{
			if (balls[i].y > WORLD_BOTTOM)
			{
				gameplayLayer.removeChildWithUpdate(balls[i]);
				removeList.push(i);
			}
		}
		for (index in removeList)
		{
			balls.splice(index, 1);
		}
		
		#if debug
		if (Input.isKeyUp(KeyCode.FIVE))
		{
			physics.debugDraw.visible = !physics.debugDraw.visible;
		}
		#end
	}
}