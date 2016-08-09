package gamball.entities;
import engine.entities.GameObject;
import engine.entities.IGameObject;
import gamball.stages.GameStage;
import pixi.core.sprites.Sprite;

class BonusArea extends GameObject
{
	private var stage:GameStage;
	
	public function new(stage:GameStage)
	{
		super();
		this.stage = stage;
		
		var candySpr = Sprite.fromImage(Ball.PATH + "ball_candy.png", false);
		candySpr.scale.set(32 / 128);
		var sensor = new BonusSensor(200, 50, 0x4D90FF, candySpr, "bonus:x2", onCandyHit);
	}
	
	private function onCandyHit():Void
	{
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		
	}
}