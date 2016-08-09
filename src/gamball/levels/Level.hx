package gamball.levels;
import engine.debug.Measurer;
import engine.entities.GameObject;
import engine.entities.IGameObject;
import engine.utils.MathR;
import gamball.entities.BalancedTriangle;
import gamball.entities.BouncyBell;
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
		
		#if debug
		drawDebugMeasurers();
		#end
	}
	
	private function drawDebugMeasurers()
	{
		var measurer = Measurer.colouredCentred();
		stage.gameplayLayer.addChild(measurer);
		
		measurer = Measurer.colouredCentred();
		measurer.position.set( -500, -1000);
		stage.gameplayLayer.addChild(measurer);
		
		measurer = Measurer.colouredCentred();
		measurer.position.set( 500, -1000);
		stage.gameplayLayer.addChild(measurer);
		
		measurer = Measurer.colouredCentred();
		measurer.position.set( 0, -500);
		stage.gameplayLayer.addChild(measurer);
	}
	
	private function buildLevel()
	{
		// background
		var bg = new Graphics();
		bg.beginFill(0x8DFFA5);
		bg.drawRect( -1000, -2000, 2000, 2000);
		bg.endFill();
		stage.gameplayLayer.addChildAt(bg, 0);
		
		// bottom triangles
		var tri = new BalancedTriangle(-200, -100, 150, 80);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		tri = new BalancedTriangle(200, -100, 150, 80);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		tri = new BalancedTriangle(-600, -100, 150, 80);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		tri = new BalancedTriangle(600, -100, 150, 80);
		stage.gameplayLayer.addChildWithUpdate(tri);
		
		// Bells
		var bell = new BouncyBell(0, -600, 60);
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