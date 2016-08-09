package gamball.entities;
import engine.entities.PhysicObject;
import engine.utils.MathR;
import gamball.utils.Utils;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import pixi.core.graphics.Graphics;

class BalancedTriangle extends PhysicObject
{
	private var polyData:Array<Float>;
	
	public function new(x:Float, y:Float, xRad:Float, yRad:Float, rotation:Float = 0)
	{
		super(BodyType.STATIC, Vec2.get(x, y));
		
		var polys = Polygon.regular(xRad, yRad, 3, -MathR.PI_HALF + rotation);
		body.shapes.add(new Polygon(polys, Material.steel()));
		body.position.y -= yRad / 2;
		body.space = physics.worldSpace;
		
		polyData = Utils.ConvertVec2Poly(polys);
		
		var tri = new Graphics();
		tri.beginFill(0xFF5A73);
		tri.drawPolygon(polyData);
		tri.endFill();
		addChild(tri);
		
		#if debug
		addDebugDraw();
		#end
	}
	
	override private function addDebugDraw():Void 
	{
		super.addDebugDraw();
		debugDraw.lineStyle(2, 0xFFFFFF);
		debugDraw.drawPolygon(polyData);
	}
}