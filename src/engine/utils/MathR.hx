package engine.utils;
import nape.geom.Vec2;
import pixi.core.math.Point;

class MathR
{
	static public inline var PI:Float = 3.141592653589793;
	static public inline var PI_HALF:Float = PI / 2;
	static public inline var PI_2:Float = PI * 2;
	
	static public inline var RAD_TO_DEGREE:Float = 180.0 / PI;
	static public inline var DEGREE_TO_RAD:Float = PI / 180.0;
	
	static public function toPixiPoint(point:Vec2):Point
	{
		return new Point(point.x, point.y);
	}
	
	static public function toVec2(point:Point, weak:Bool = false):Vec2
	{
		return Vec2.get(point.x, point.y, weak);
	}
	
	static public function toRadians(value:Float):Float
	{
		return value * DEGREE_TO_RAD;
	}
	
	static public function toDegrees(value:Float):Float
	{
		return value * RAD_TO_DEGREE;
	}
	
	static public function distance(a:Point, b:Point):Float
	{
		return Math.sqrt(distanceSqr(a, b));
	}
	
	static public function distanceSqr(a:Point, b:Point):Float
	{
		var x = b.x - a.x;
		var y = b.y - a.y;
		return x * x + y * y;
	}
	
	static public function state(current:Float, from:Float, to:Float):Float
	{
		return clamp01((current - from) / (to - from));
	}
	
	static public function lerp(t:Float, from:Float, to:Float):Float
	{
		return (to - from) * clamp01(t) + from;
	}
	
	static public function smoothStep(t:Float, from:Float, to:Float):Float
	{
		t = clamp01(t);
		t = -2.0 * t * t * t + 3.0 * t * t;
		return to * t + from * (1.0 - t);
	}
	
	static public function smoothStep01(t:Float):Float
	{
		return smoothStep(t, 0, 1.0);
	}
	
	static public function smoothCubicIn(t:Float):Float
	{
		t = clamp01(t);
		return t * t * t;
	}
	
	static public function smoothCubicOut(t:Float):Float
	{
		t = clamp01(t) - 1.0;
		return t * t * t + 1.0;
	}
	
	static public function smoothQuadIn(t:Float):Float
	{
		t = clamp01(t);
		return t * t;
	}
	
		static public function smoothQuadOut(t:Float):Float
	{
		t = clamp01(t);
		return -t * (t - 2.0);
	}
	
	static public function clamp01(t:Float):Float
	{
		return t > 1.0 ? 1.0 : t < 0 ? 0 : t;
	}
	
	static public function clamp(value:Float, min:Float, max:Float):Float
	{
		return value > max ? max : value < min ? min : value;
	}
	
	static public function randomInt(min:Int, max:Int):Int
	{
		return Std.int(Math.random() * (max - min + 1) + min);
	}
	
	static public function randomFloat(min:Float, max:Float):Float
	{
		return Math.random() * (max - min) + min;
	}
	
	static public function randomArrayItem<T>(array:Array<T>):T
	{
		return array[randomInt(0, array.length - 1)];
	}
	
	static public function isOddNumber(value:Int):Bool
	{
		return value % 2 > 0;
	}
	
	static public function isEvenNumber(value:Int):Bool
	{
		return !isOddNumber(value);
	}
	
	static public function getFloorEvenInt(value:Float):Int
	{
		var result = Math.floor(value);
		return isOddNumber(result) ? ++result : result;
	}
	
	static public function isBetween(value:Float, a:Float, b:Float):Bool
	{
		return a < b ? value > a && value < b : value > b && value < a;
	}
	
	static public function fixedFloat(value:Float, precision:Int = 2):Float
	{
		var pow = Math.pow(10, precision);
		return Math.round(value * pow) / pow;
	}
	
	static public function pointFromPolar(length:Float, angle:Float):Point
	{
		return setFromPolar(new Point(), length, angle);
	}
	
	static public function setFromPolar(target:Point, length:Float, angle:Float):Point
	{
		target.set(length * Math.cos(angle), length * Math.sin(angle));
		return target;
	}
}