package gamball.levels;
import engine.entities.GameObject;
import engine.entities.IGameObject;
import engine.utils.MathR;
import gamball.entities.BalancedTriangle;
import gamball.entities.BouncyBell;
import gamball.entities.RotatorPlank;
import gamball.entities.SineRotator;
import gamball.entities.StripedRect;
import gamball.stages.GameStage;
import pixi.core.graphics.Graphics;

class Level implements IGameObject
{
	private var stage:GameStage;
	
	public function new(stage:GameStage)
	{
		this.stage = stage;
		
		buildLevel();
	}
	
	private function buildLevel()
	{
		// background
		var bg = new Graphics();
		bg.beginFill(0x8DFFA5);
		bg.drawRect( -1000, -2000, 2000, 2000);
		bg.endFill();
		stage.gameplayLayer.addChildAt(bg, 0);
		
		// top triangles
		var tri = new BalancedTriangle(-600, -1300, 450, 60);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		tri = new BalancedTriangle(600, -1300, 450, 60);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		// bottom triangles
		tri = new BalancedTriangle(-200, -100, 140, 80);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		tri = new BalancedTriangle(200, -100, 140, 80);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		tri = new BalancedTriangle(-600, -100, 140, 80);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		tri = new BalancedTriangle(600, -100, 140, 80);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		// Rotators
		var rotator = new RotatorPlank(-360, -550, 250, 50, MathR.PI);
		stage.gameplayLayer.addChildWithUpdate(rotator);
		
		rotator = new RotatorPlank(360, -550, 250, 50, -MathR.PI);
		stage.gameplayLayer.addChildWithUpdate(rotator);
		
		var sineRotator = new SineRotator(0, -1150, 200, 60, MathR.PI_2);
		stage.gameplayLayer.addChildWithUpdate(sineRotator);
		
		// Bells
		var bell = new BouncyBell(0, -400, 60);
		stage.gameplayLayer.addChildWithUpdate(bell);
		
		var bell = new BouncyBell(-270, -950, 60);
		stage.gameplayLayer.addChildWithUpdate(bell);
		
		var bell = new BouncyBell(270, -950, 60);
		stage.gameplayLayer.addChildWithUpdate(bell);
		
		
		// left and right wall
		var rect = new StripedRect(-600, -1000, 2000, 500, MathR.PI_HALF);
		stage.gameplayLayer.addChildWithUpdate(rect);
		
		rect = new StripedRect(600, -1000, 2000, 500, -MathR.PI_HALF);
		stage.gameplayLayer.addChildWithUpdate(rect);
	}
	
	public function fixedUpdate():Void {}
	public function update():Void {}
	public function lateUpdate():Void {}
}