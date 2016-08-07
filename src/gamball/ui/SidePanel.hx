package gamball.ui;
import engine.entities.GameObject;
import gamball.stages.GameStage;
import gamball.ui.Button.ButtonConfig;
import pixi.core.graphics.Graphics;

class SidePanel extends GameObject
{
	public var currencyPanel(default, null):CurrencyPanel;
	
	private var stage:GameStage;
	private var panelWidth:Float;
	private var bg:Graphics;
	
	public function new(stage:GameStage)
	{
		super();
		this.stage = stage;
		
		panelWidth = GamBall.screenWidth * 0.35;
		x = GamBall.screenWidth - panelWidth;
		y = -1; // extra padding
		
		bg = new Graphics();
		bg.beginFill(0x000000, 0.65);
		bg.drawRect(0, 0, panelWidth + 1, GamBall.screenHeight + 2); // with extra paddings
		bg.endFill();
		addChild(bg);
		
		currencyPanel = new CurrencyPanel(stage);
		currencyPanel.x = Math.round(panelWidth * 0.5);
		currencyPanel.y = 80;
		addChildWithUpdate(currencyPanel);
		
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
		btn.y = 600;
		addChild(btn);
	}
}