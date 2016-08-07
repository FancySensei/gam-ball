package gamball.ui;
import engine.entities.GameObject;
import gamball.ui.Button.ButtonConfig;
import pixi.core.graphics.Graphics;

class SidePanel extends GameObject
{
	private var panelWidth:Float;
	private var bg:Graphics;
	
	public function new()
	{
		super();
		panelWidth = GamBall.screenWidth * 0.35;
		x = GamBall.screenWidth - panelWidth;
		y = -1;
		
		bg = new Graphics();
		bg.beginFill(0x000000, 0.65);
		bg.drawRect(0, 0, panelWidth + 1, GamBall.screenHeight + 2);
		bg.endFill();
		addChild(bg);
		
		var buttonConfig:ButtonConfig =
		{
			width: 200,
			height: 50,
			surfaceColour: 0xFFFF00,
			baseColour: 0xD78C02,
			springHeight: 15,
			cooldown: 0.2
		}
		var btn = new Button(buttonConfig, null);
		btn.x = 100;
		btn.y = 100;
		addChild(btn);
	}
}