package engine.system;
import engine.utils.MathR;

class Time
{
	static public inline var DEFAULT_FPS:Int = 60;
	
	static public var maxDT(default, default):Float = 1.0;
	
	static public var dt(default, null):Float = 0;
	static public var fixedDT(default, null):Float = 1.0 / DEFAULT_FPS / Physics.interactionsPerFrame;
	static public var time(default, null):Float = 0;
	
	static public function tick(deltaStamp:Float):Void
	{
		unscaledDT = deltaStamp / 1000.0;
		time += unscaledDT;
	}
	
	static public var unscaledDT(default, set):Float = 0;
	static private function set_unscaledDT(value:Float):Float
	{
		// Lag Protection, prevent to explode the delta time (i.e. switch tab)
		unscaledDT = Math.min(value, maxDT);
		dt = unscaledDT * timeScale;
		return unscaledDT;
	}
	
	static public var unscaledFixedDT(default, null):Float = 1.0 / DEFAULT_FPS / Physics.interactionsPerFrame;
	
	static public var timeScale(default, set):Float = 1.0;
	static private function set_timeScale(value:Float):Float
	{
		timeScale = value;
		dt = unscaledDT * timeScale;
		fixedDT = unscaledFixedDT * timeScale;
		return timeScale;
	}
	
	static public var targetFPS(default, set):Int = DEFAULT_FPS;
	static private function set_targetFPS(value:Int):Int
	{
		targetFPS = Std.int(MathR.clamp(value, 1, 60));
		unscaledFixedDT = 1.0 / targetFPS / Physics.interactionsPerFrame;
		fixedDT = unscaledFixedDT * timeScale;
		return targetFPS;
	}
	
	static public function format(t:Float):String
	{
		var date = Date.fromTime(t * 1000);
		var m = Std.string(date.getMinutes());
		var s = Std.string(date.getSeconds());
		if (s.length == 1)
		{
			s = "0" + s;
		}
		var ms = Std.string(Math.floor((t - Math.ffloor(t)) * 1000));
		if (ms.length == 1)
		{
			ms = "00" + ms;
		}
		else if (ms.length == 2)
		{
			ms = "0" + ms;
		}
		
		return m + ":" + s + "." + ms;
	}
}