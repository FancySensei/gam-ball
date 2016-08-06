package engine.system;
import engine.Engine;
import engine.entities.GameObject;
import pixi.core.math.shapes.Rectangle;
import pixi.interaction.EventTarget;

class TouchLayer extends GameObject
{
	public var onTouchBegin(default, null):Array<Void->Void> = [];
	public var onTouchFinished(default, null):Array<Void->Void> = [];
	public var touches(default, null):Int = 0;
	public var isMouseDown(default, null):Bool = false;
	
	public function new()
	{
		super();
		interactive = true;
		interactiveChildren = false;
		hitArea = new Rectangle(0, 0, Engine.instance.width, Engine.instance.height);
		
		on("mousedown", onPlayerToucheStart);
		on("touchstart", onPlayerToucheStart);
		on("mouseup", onPlayerToucheEnd);
		on("touchend", onPlayerToucheEnd);
	}
	
	public function cleanUp():Void
	{
		onTouchBegin = [];
		onTouchFinished = [];
		touches = 0;
		
		removeAllListeners();
		on("mousedown", onPlayerToucheStart);
		on("touchstart", onPlayerToucheStart);
		on("mouseup", onPlayerToucheEnd);
		on("touchend", onPlayerToucheEnd);
	}
	
	private function onPlayerToucheStart(event:EventTarget):Void
	{
		if (event.type == "mousedown" || ++touches == 1)
		{
			isMouseDown = true;
			for (callback in onTouchBegin)
			{
				callback();
			}
		}
	}
	
	private function onPlayerToucheEnd(event:EventTarget):Void
	{
		if (event.type == "mouseup" || --touches <= 0)
		{
			isMouseDown = false;
			for (callback in onTouchFinished)
			{
				callback();
			}
		}
	}
}