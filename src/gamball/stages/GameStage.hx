package gamball.stages;
import engine.entities.Stage;
import gamball.ui.SidePanel;

class GameStage extends Stage
{
	public function new()
	{
		super();
		
		uiLayer.addChild(new SidePanel());
	}
}