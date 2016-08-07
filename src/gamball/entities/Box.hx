package gamball.entities;
import engine.entities.PhysicObject;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;

class Box extends PhysicObject
{
	private var bodyWidth:Float;
	private var bodyHeight:Float;
	
	public function new(x:Float, y:Float, width:Float, height:Float)
	{
		super(BodyType.STATIC, Vec2.get(x, y));
		this.bodyWidth = width;
		this.bodyHeight = height;
		
		body.shapes.add(new Polygon(Polygon.box(bodyWidth, bodyHeight, true), Material.steel()));
		body.space = physics.worldSpace;
		
		#if debug
		addDebugDraw();
		#end
	}
	
	override private function addDebugDraw():Void 
	{
		super.addDebugDraw();
		debugDraw.lineStyle(2, 0xFFFFFF);
		debugDraw.drawRect(-bodyWidth / 2, -bodyHeight / 2, bodyWidth, bodyHeight);
	}
}