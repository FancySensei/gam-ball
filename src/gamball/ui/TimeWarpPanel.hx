package gamball.ui;
import engine.entities.GameObject;
import engine.system.Time;
import gamball.ui.Button.ButtonConfig;
import motion.Actuate;
import motion.easing.Cubic;

class TimeWarpPanel extends GameObject
{
	private var timeScale:Float = 1.0;
	
	public function new() 
	{
		super();
		
		var title = Fonts.getFancyText("Time Warp (Just for Fun)", 28, Fonts.CALIBRI_32_BOLD);
		addChild(title);
		
		var buttonConfig:ButtonConfig =
		{
			width: 70,
			height: 38,
			surfaceColour: 0xFF31B9,
			baseColour: 0xC11787,
			springHeight: 12,
			cooldown: 0.2
		}
		var button = new Button(buttonConfig, onButtonPressed.bind(0.2));
		var text = Fonts.getFancyText("x0.2", 24, Fonts.CALIBRI_32_BOLD);
		text.position.set(35, 20);
		button.surface.addChild(text);
		button.position.set( -90, 60);
		addChild(button);
		
		button = new Button(buttonConfig, onButtonPressed.bind(1.0));
		text = Fonts.getFancyText("x1.0", 24, Fonts.CALIBRI_32_BOLD);
		text.position.set(35, 20);
		button.surface.addChild(text);
		button.position.set( 0, 60);
		addChild(button);
		
		button = new Button(buttonConfig, onButtonPressed.bind(1.5));
		text = Fonts.getFancyText("x1.5", 24, Fonts.CALIBRI_32_BOLD);
		text.position.set(35, 20);
		button.surface.addChild(text);
		button.position.set( 90, 60);
		addChild(button);
	}
	
	private function onButtonPressed(multiplier:Float):Void
	{
		Actuate.tween(this, 1.0, {timeScale: multiplier}).ease(Cubic.easeIn).onUpdate(function()
		{
			Time.timeScale = timeScale;
		});
	}
}