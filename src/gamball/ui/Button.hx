package gamball.ui;
import engine.entities.GameObject;
import js.html.EventTarget;
import motion.Actuate;
import motion.easing.Back;
import pixi.core.graphics.Graphics;
import pixi.core.math.shapes.Rectangle;

class Button extends GameObject
{
	public var isCooldown(default, null):Bool = false;
	public var config(default, null):ButtonConfig;
	
	private var callback:Void->Void;
	
	private var base:Graphics;
	private var surface:Graphics;
	private var sfx:WaudSound;
	
	public function new(config:ButtonConfig, callback:Void->Void)
	{
		super();
		this.config = config;
		this.callback = callback;
		
		var ext = Waud.isMP3Supported() ? ".mp3" : ".ogg";
		var option:WaudSoundOptions = {
			loop: false,
			autoplay: false,
			volume: 0.7
		};
		sfx = new WaudSound("assets/sfx/" + "button_click" + ext, option);
		
		base = new Graphics();
		var baseHeight = Math.floor(config.height / 2);
		base.beginFill(config.baseColour);
		base.drawRect(0, baseHeight, config.width, baseHeight);
		base.endFill();
		base.pivot.set(config.width / 2, baseHeight);
		addChild(base);
		
		surface = new Graphics();
		surface.beginFill(config.surfaceColour);
		surface.drawRect(0, 0, config.width, config.height);
		surface.endFill();
		surface.pivot.set(config.width / 2, config.height / 2);
		surface.y = -config.springHeight;
		addChild(surface);
		
		interactive = true;
		// Generate Hit Area -- better user experience and performance
		interactiveChildren = false; 
		hitArea = new Rectangle( -config.width / 2, -config.height / 2 - config.springHeight,
			config.width, config.height + config.springHeight);
		// Down
		on("mousedown", onButtonDown);
		on("touchstart", onButtonDown);
		// Up
		on("mouseup", onButtonUp);
		on("touchend", onButtonUp);
		// Over
		on("mouseover", onButtonOver);
		// Out
		on("mouseout", onButtonOut);
	}
	
	private function onButtonDown(event:EventTarget):Void
	{
		Actuate.tween(surface, 0.3, { y: 0 } );
	}
	
	private function onButtonUp(event:EventTarget):Void
	{
		Actuate.tween(surface, 0.3, { y: -config.springHeight } ).ease(Back.easeOut);
		if (!isCooldown)
		{
			isCooldown = true;
			callback();
			sfx.play();
			Actuate.timer(config.cooldown).onComplete(function():Void
			{
				isCooldown = false;
			});
		}
	}
	
	private function onButtonOver(event:EventTarget):Void
	{
		Actuate.tween(surface, 0.3, { y: -Math.floor(config.springHeight * 0.8) } );
	}
	
	private function onButtonOut(event:EventTarget):Void
	{
		Actuate.tween(surface, 0.3, { y: -config.springHeight } ).ease(Back.easeOut);
	}
}

typedef ButtonConfig =
{
	var width:Int;
	var height:Int;
	var surfaceColour:Int;
	var baseColour:Int;
	var springHeight:Int;
	var cooldown:Float;
}