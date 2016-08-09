package gamball.entities;
import engine.entities.GameObject;
import engine.entities.IGameObject;
import engine.system.Time;
import gamball.stages.GameStage;
import pixi.core.sprites.Sprite;

class BonusArea implements IGameObject
{
	static private inline var SPEED:Float = 150;
	static private inline var BOUNDS_LEFT:Float = -600;
	static private inline var TOTAL_WIDTH:Float = (600 + 400 + 200 + 70) * 2;
	
	private var stage:GameStage;
	private var sensors:Array<BonusSensor> = [];
	
	public function new(stage:GameStage)
	{
		this.stage = stage;
		
		createBallSensor(Ball.BALL_CANDY_ID, -600, 600, 0x4D90FF, "bonus:x2", onCandyHit);
		createBallSensor(Ball.BALL_8_ID, 0, 400, 0xBB4FFF, "bonus:x5", onEightHit);
		createBallSensor(Ball.BALL_POKEMON_ID, 400, 200, 0xFF7A22, "bonus:x10", onPokemonHit);
		
		var crown = Sprite.fromImage("assets/textures/sprites/crown.png", false);
		var sensor = new BonusSensor(null, 70, 100, 0xFF2740, crown, null, onCrownHit);
		sensor.position.set(600, -200);
		stage.gameplayLayer.addChild(sensor);
		sensors.push(sensor);
		
		createBallSensor(Ball.BALL_POKEMON_ID, 670, 200, 0xFF7A22, "bonus:x10", onPokemonHit);
		createBallSensor(Ball.BALL_8_ID, 870, 400, 0xBB4FFF, "bonus:x5", onEightHit);
		createBallSensor(Ball.BALL_CANDY_ID, 1270, 600, 0x4D90FF, "bonus:x2", onCandyHit);
		
		crown = Sprite.fromImage("assets/textures/sprites/crown.png", false);
		sensor = new BonusSensor(null, 70, 100, 0xFF2740, crown, null, onCrownHit);
		sensor.position.set(1870, -200);
		stage.gameplayLayer.addChild(sensor);
		sensors.push(sensor);
	}
	
	private function createBallSensor(id:String, x:Float, width:Float, colour:Int, text:String, callback:Void->Void):Void
	{
		var spr = Sprite.fromImage(Ball.PATH + stage.gameConfig.ballConfigs.get(id).texture, false);
		spr.scale.set(48 / 128);
		var sensor = new BonusSensor(id, width, 100, colour, spr, text, callback);
		sensor.position.set(x, -200);
		stage.gameplayLayer.addChild(sensor);
		sensors.push(sensor);
	}
	
	private function onCandyHit():Void
	{
		trace("candy!");
	}
	
	private function onEightHit():Void
	{
		trace("888!");
	}
	
	private function onPokemonHit():Void
	{
		trace("pokemon!");
	}
	
	private function onCrownHit():Void
	{
		trace("crown!");
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