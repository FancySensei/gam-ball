package engine.utils;
import haxe.Timer;
import motion.actuators.SimpleActuator;

class SmoothActuator<T, U> extends SimpleActuator<T, U>
{
	static private var timer:Timer;
	
	public function new(target:T, duration:Float, properties:Dynamic)
	{
		super(target, duration, properties);
		
		setFPS(60);
	}
	
	static public function setFPS(fps:Int):Void
	{
		if (timer != null)
		{
			timer.stop();
		}
		
		initTimer(fps);
	}
	
	static private function initTimer(fps):Void
	{
		timer = new Timer(Std.int(1000 / fps));
		timer.run = SimpleActuator.stage_onEnterFrame;
	}
}