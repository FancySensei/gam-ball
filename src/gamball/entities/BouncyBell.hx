package gamball.entities;
import engine.entities.PhysicObject;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Circle;
import pixi.core.graphics.Graphics;

class BouncyBell extends PhysicObject
{
	private var radius:Float;
	
	public function new(x:Float, y:Float, radius:Float) 
	{
		super(BodyType.STATIC, Vec2.get(x, y));
		this.radius = radius;
		
		body.shapes.add(new Circle(radius, null, Material.rubber()));
		body.space = physics.worldSpace;
		
		var bell = new Graphics();
		bell.beginFill(0xFF7437);
		bell.drawCircle(0, 0, radius);
		bell.beginFill(0xFFFFFF);
		bell.drawCircle(0, 0, radius * 0.25);
		bell.endFill();
		addChild(bell);
		
		#if debug
		addDebugDraw();
		#end
	}
	
	override private function addDebugDraw():Void 
	{
		super.addDebugDraw();
		debugDraw.lineStyle(2, 0x6CFDCE);
		debugDraw.drawCircle(0, 0, radius);
		debugDraw.lineStyle(2, 0xFF402B);
		debugDraw.moveTo(0, 0);
		debugDraw.lineTo(radius, 0);
		debugDraw.drawCircle(0, 0, 3);
	}
}