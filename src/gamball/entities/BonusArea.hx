package gamball.entities;
import engine.entities.GameObject;
import engine.entities.IGameObject;
import gamball.stages.GameStage;
import pixi.core.sprites.Sprite;

class BonusArea implements IGameObject
{
	private var stage:GameStage;
	private var sensors:Array<BonusSensor> = [];
	
	public function new(stage:GameStage)
	{
		this.stage = stage;
		
		var spr = Sprite.fromImage(Ball.PATH + stage.gameConfig.ballConfigs.get(Ball.BALL_CANDY_ID).texture, false);
		spr.scale.set(48 / 128);
		var sensor = new BonusSensor(Ball.BALL_CANDY_ID, 400, 100, 0x4D90FF, spr, "bonus:x2", onCandyHit);
		sensor.position.set(0, -200);
		stage.gameplayLayer.addChild(sensor);
		sensors.push(sensor);
		
		var spr = Sprite.fromImage(Ball.PATH + stage.gameConfig.ballConfigs.get(Ball.BALL_8_ID).texture, false);
		spr.scale.set(32 / 128);
		var sensor = new BonusSensor(Ball.BALL_8_ID, 200, 50, 0x4D90FF, spr, "bonus:x2", onCandyHit);
		sensors.push(sensor);
	}
	
	private function onCandyHit():Void
	{
		trace("bola!");
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
	
	public function update():Void {}
	
	public function lateUpdate():Void {}
}