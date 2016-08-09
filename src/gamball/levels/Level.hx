package gamball.levels;
import engine.debug.Measurer;
import engine.entities.GameObject;
import engine.entities.IGameObject;
import engine.utils.MathR;
import gamball.entities.BalancedTriangle;
import gamball.entities.StripedRect;
import gamball.stages.GameStage;

class Level implements IGameObject
{
	private var stage:GameStage;
	
	public function new(stage:GameStage)
	{
		this.stage = stage;
		
		#if debug
		drawDebugMeasurers();
		#end
		
		buildLevel();
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
		// left
		var rect = new StripedRect(-600, -1000, 2000, 1000, MathR.PI_HALF);
		stage.gameplayLayer.addChildWithUpdate(rect);
		
		// right
		rect = new StripedRect(600, -1000, 2000, 1000, -MathR.PI_HALF);
		stage.gameplayLayer.addChildWithUpdate(rect);
		
		// right
		rect = new StripedRect(0, -200, 1000, 100, 0);
		stage.gameplayLayer.addChildWithUpdate(rect);
		
		var tri = new BalancedTriangle(0, -500, 300, 100, -MathR.PI_HALF);
		stage.gameplayLayer.addChildWithUpdate(tri);
	}
	
	public function fixedUpdate():Void {}
	public function update():Void {}
	public function lateUpdate():Void {}
}