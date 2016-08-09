package gamball.utils;
import nape.geom.Vec2;

class Utils
{
	private function new() {}
	
	static public function ConvertVec2Poly(vec2Poly:Array<Vec2>):Array<Float>
	{
		var result:Array<Float> = [];
		
		for (vec2 in vec2Poly)
		{
			result.push(vec2.x);
			result.push(vec2.y);
		}
		return result;
	}
}