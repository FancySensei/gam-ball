package gamball.stages;
import engine.debug.Measurer;
import engine.entities.Stage;

class TestStage extends Stage
{
	public function new()
	{
		super();
		var testObj = Measurer.colouredCentred();
		testObj.x = GamBall.screenWidth * 0.5;
		testObj.y = GamBall.screenWidth * 0.5;
		addChild(testObj);
	}
}