package gamball.entities;
import engine.entities.GameObject;
import engine.entities.IGameObject;
import engine.system.Time;
import gamball.stages.GameStage;
import pixi.core.sprites.Sprite;

class BonusArea implements IGameObject
{
	static private inline var SPEED:Float = 200;
	static private inline var BOUNDS_LEFT:Float = -600;
	static private inline var POS_Y:Float = -100;
	static private inline var TOTAL_WIDTH:Float = (600 + 400 + 200 + 70) * 2;
	
	private var stage:GameStage;
	private var sensors:Array<BonusSensor> = [];
	
	public function new(stage:GameStage)
	{
		this.stage = stage;
		
		createBallSensor(Ball.BALL_CANDY_ID, -600, 605, 0x4D90FF, "bonus:x", onNormalAreaHit);
		createBallSensor(Ball.BALL_8_ID, 0, 405, 0xBB4FFF, "bonus:x", onNormalAreaHit);
		createBallSensor(Ball.BALL_POKEMON_ID, 400, 205, 0xFF7A22, "bonus:x", onNormalAreaHit);
		
		var crown = Sprite.fromImage("assets/textures/sprites/crown.png", false);
		var sensor = new BonusSensor(null, 72, 100, 0xFF2740, crown, null, onCrownHit);
		sensor.position.set(600, POS_Y);
		stage.gameplayLayer.addChild(sensor);
		sensors.push(sensor);
		
		createBallSensor(Ball.BALL_CANDY_ID, 670, 605, 0x4D90FF, "bonus:x", onNormalAreaHit);
		createBallSensor(Ball.BALL_8_ID, 1270, 405, 0xBB4FFF, "bonus:x", onNormalAreaHit);
		createBallSensor(Ball.BALL_POKEMON_ID, 1670, 205, 0xFF7A22, "bonus:x", onNormalAreaHit);
		
		crown = Sprite.fromImage("assets/textures/sprites/crown.png", false);
		sensor = new BonusSensor(null, 72, 100, 0xFF2740, crown, null, onCrownHit);
		sensor.position.set(1870, POS_Y);
		stage.gameplayLayer.addChild(sensor);
		sensors.push(sensor);
	}
	
	private function createBallSensor(id:String, x:Float, width:Float, colour:Int, text:String, callback:Ball->Void):Void
	{
		var config = stage.gameConfig.ballConfigs.get(id);
		var spr = Sprite.fromImage(Ball.PATH + config.texture, false);
		spr.scale.set(48 / 128);
		var sensor = new BonusSensor(id, width, 100, colour, spr, text + Std.string(config.bonus), callback);
		sensor.position.set(x, POS_Y);
		stage.gameplayLayer.addChild(sensor);
		sensors.push(sensor);
	}
	
	private function onNormalAreaHit(ball:Ball):Void
	{
		stage.rewardCurrency(ball.config.cost, ball.config.bonus);
	}
	
	private function onCrownHit(ball:Ball):Void
	{
		stage.rewardCurrency(ball.config.cost, 30);
	}
	
	public function fixedUpdate():Void 
	{
		for (ball in stage.balls)
		{
			for (sensor in sensors)
			{
				sensor.hitTest(ball);
			}
		}
	}
	
	public function update():Void
	{
		var dist = SPEED * Time.dt;
		for (i in 0...sensors.length)
		{
			var sensor = sensors[i];
			if (sensor.x + sensor.sensorWidth <= BOUNDS_LEFT)
			{
				sensor.x = TOTAL_WIDTH - sensor.sensorWidth + BOUNDS_LEFT;
			}
			sensor.x -= dist;
		}
	}
	
	public function lateUpdate():Void {}
}