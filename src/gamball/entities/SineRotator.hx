package gamball.entities;
import engine.entities.PhysicObject;
import engine.system.Time;
import engine.utils.MathR;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import pixi.core.graphics.Graphics;

class SineRotator extends PhysicObject
{
	private var bodyWidth:Float;
	private var bodyHeight:Float;
	private var angularVel:Float;
	private var fixedTimer:Float = 0;
	
	public function new(x:Float, y:Float, width:Float, height:Float, angularVel:Float = 0) 
	{
		super(BodyType.KINEMATIC, Vec2.get(x, y));
		this.bodyWidth = width;
		this.bodyHeight = height;
		this.angularVel = angularVel;
		
		body.shapes.add(new Polygon(Polygon.box(bodyWidth, bodyHeight, true), Material.rubber()));
		body.angularVel = angularVel;
		body.space = physics.worldSpace;
		
		var plank = new Graphics();
		plank.beginFill(0x0EADFF);
		plank.drawRect( -bodyWidth / 2, -bodyHeight / 2, bodyWidth, bodyHeight);
		plank.endFill();
		plank.beginFill(0xFFFFFF);
		plank.drawCircle(0, 0, height * 0.25);
		plank.endFill();
		addChild(plank);
		
		#if debug
		addDebugDraw();
		#end
	}
	
	override private function addDebugDraw():Void 
	{
		super.addDebugDraw();
		debugDraw.lineStyle(2, 0x3EFF22);
		debugDraw.drawRect(-bodyWidth / 2, -bodyHeight / 2, bodyWidth, bodyHeight);
	}
	
	override public function fixedUpdate():Void 
	{
		super.fixedUpdate();
		fixedTimer += Time.fixedDT;
		if (fixedTimer > MathR.PI_2) fixedTimer -= MathR.PI_2;
		body.angularVel = Math.sin(fixedTimer) * angularVel;
	}
}