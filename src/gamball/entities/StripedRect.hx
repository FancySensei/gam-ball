package gamball.entities;
import engine.entities.PhysicObject;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import pixi.core.graphics.Graphics;

class StripedRect extends PhysicObject
{
	private var bodyWidth:Float;
	private var bodyHeight:Float;
	
	public function new(x:Float, y:Float, width:Float, height:Float, rotation:Float = 0)
	{
		super(BodyType.STATIC, Vec2.get(x, y));
		this.bodyWidth = width;
		this.bodyHeight = height;
		
		body.shapes.add(new Polygon(Polygon.rect(-bodyWidth / 2, 0, bodyWidth, bodyHeight, true), Material.steel()));
		body.rotation = rotation;
		body.space = physics.worldSpace;
		
		var box = new Graphics();
		box.beginFill(0xFF5A73);
		box.drawRect( -bodyWidth / 2, 0, bodyWidth, bodyHeight);
		box.endFill();
		box.beginFill(0xFFFFFF);
		box.drawRect( -bodyWidth / 2, 10, bodyWidth, 10);
		box.endFill();
		addChild(box);
		
		#if debug
		addDebugDraw();
		#end
	}
	
	override private function addDebugDraw():Void 
	{
		super.addDebugDraw();
		debugDraw.lineStyle(2, 0x3EFF22);
		debugDraw.drawRect(-bodyWidth / 2, 0, bodyWidth, bodyHeight);
	}
}