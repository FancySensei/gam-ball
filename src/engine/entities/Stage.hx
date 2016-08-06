package engine.entities;
import engine.entities.GameObject;
import engine.system.Camera;
import engine.system.Physics;
import pixi.core.display.Container;
import pixi.core.display.DisplayObject;

using Std;

class Stage extends GameObject
{
	// shortcuts
	public var engine(default, null):Engine;
	public var physics(default, null):Physics;
	public var camera(default, null):Camera;
	
	// layers
	public var backgroundLayer(default, null):GameObject;
	public var gameplayLayer(default, null):GameObject;
	public var uiLayer(default, null):GameObject;
	
	public function new()
	{
		super();
		engine = Engine.instance;
		physics = Physics.instance;
		
		addChildWithUpdate(backgroundLayer = new GameObject());
		addChildWithUpdate(gameplayLayer = new GameObject());
		addChildWithUpdate(uiLayer = new GameObject());
		
		camera = new Camera(gameplayLayer);
	}
	
	override public function lateUpdate():Void 
	{
		super.lateUpdate();
		camera.lateUpdate();
	}
}