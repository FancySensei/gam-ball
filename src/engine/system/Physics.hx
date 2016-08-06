package engine.system;
import engine.entities.PhysicObject;
import nape.geom.Vec2;
import nape.space.Space;
import pixi.core.display.Container;

class Physics
{
	static public inline var PIX_METER_UNIT:Float = 100.0;
	static public inline var DEFAULT_GRAVITY:Float = 9.8;
	
	static public var interactionsPerFrame(default, null):Int = 8;
	static public var velocityInteractions(default, null):Int = 3;
	static public var positionInteractions(default, null):Int = 3;
	
	static private var _instance:Physics;
	static public var instance(get, never):Physics;
	static private function get_instance():Physics
	{
		return _instance == null ? new Physics() : _instance;
	}
	
	public var worldSpace(default, null):Space;
	public var gravity(default, null):Vec2;
	public var isEnabled:Bool = true;
	
	public var debugDraw(default, null):Container;

	private function new()
	{
		if (_instance != null) throw "You can't instantiate more than one Physics World!";
		_instance = this;
		
		init();
	}
	
	private function init():Void
	{
		gravity = Vec2.get(0, meterToPixel(DEFAULT_GRAVITY));
		worldSpace = new Space(gravity);
		debugDraw = new Container();
		debugDraw.visible = false;
	}
	
	public function resetWorld():Void
	{
		worldSpace.clear();
	}
	
	public function setPhysicsInteractions(?interactionsPerFrame:Int, ?velocityInteractions:Int, ?positionInteractions:Int):Void
	{
		if (interactionsPerFrame != null && interactionsPerFrame > 0)
		{
			Physics.interactionsPerFrame = interactionsPerFrame;
		}
		if (velocityInteractions != null && velocityInteractions > 0)
		{
			Physics.velocityInteractions = velocityInteractions;
		}
		if (positionInteractions != null && positionInteractions > 0)
		{
			Physics.positionInteractions = positionInteractions;
		}
	}
	
	public function update():Void
	{
		if (Time.fixedDT > 0 && isEnabled)
		{
			worldSpace.step(Time.fixedDT, velocityInteractions, positionInteractions);
		}
	}
	
	static public function meterToPixel(meter:Float):Float
	{
		return meter * PIX_METER_UNIT;
	}
	
	static public function pixelToMeter(pixel:Float):Float
	{
		return pixel / PIX_METER_UNIT;
	}
}