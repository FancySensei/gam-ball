package gamball.stages;
import engine.entities.Stage;
import gamball.ui.SidePanel;

class GameStage extends Stage
{
	public var currency(default, null):Int = 1000;
	
	public function new()
	{
		super();
		
		uiLayer.addChild(new SidePanel(this));
	}
}