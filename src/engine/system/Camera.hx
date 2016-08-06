package engine.system;
import pixi.core.display.Container;
import pixi.core.display.DisplayObject;
import pixi.core.math.Point;

class Camera
{
	// Stage is the main Container that camera will "follow"(modify) with
	public var stage(default, null):Container;
	
	// The following target
	public var target(default, null):Point;
	public var isEnabled(default, null):Bool = true;
	public var centrePoint(default, null):Point;
	
	public var position(default, default):Point = new Point();
	public var offset(default, default):Point = new Point();
	public var additionalScale(default, default):Point =  new Point(1.0, 1.0);
	public var zoom(default, default):Float = 1.0;
	
	public function new(stage:Container)
	{
		this.stage = stage;
		
		centrePoint = new Point( -Engine.instance.width / 2, -Engine.instance.height / 2);
		position = new Point();
		offset = new Point();
	}
	
	public function follow(target:Point, ?offset:Point):Void
	{
		this.target = target;
		if (offset != null)
		{
			this.offset = offset;
		}
	}
	
	public function lateUpdate():Void
	{
		if (!isEnabled || target == null) return;
		
		position.copy(target);
		position.x *= additionalScale.x * zoom;
		position.y *= additionalScale.y * zoom;
		position.x += offset.x + centrePoint.x;
		position.y += offset.y + centrePoint.y;
		stage.position.set(-position.x, -position.y);
		stage.scale.set(additionalScale.x * zoom, additionalScale.y * zoom);
	}
	
}