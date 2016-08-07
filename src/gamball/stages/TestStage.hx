package gamball.stages;
import engine.debug.Measurer;
import engine.entities.Stage;
import gamball.ui.Fonts;

class TestStage extends Stage
{
	public function new()
	{
		super();
		var testObj = Measurer.colouredCentred();
		testObj.x = GamBall.screenWidth * 0.5;
		testObj.y = GamBall.screenWidth * 0.5;
		addChild(testObj);
		
		Fonts.load(function():Void
		{
			var bitmapText = Fonts.getFancyText("Blah blah blah", 32, Fonts.CALIBRI_64_BOLD);
			bitmapText.x = 100;
			bitmapText.y = 300;
			addChild(bitmapText);
		});
	}
}