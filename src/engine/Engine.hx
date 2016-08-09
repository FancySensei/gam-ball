package engine;
import engine.entities.Stage;
import engine.system.Input;
import engine.system.KeyCode;
import engine.system.Physics;
import engine.system.Time;
import engine.utils.SmoothActuator;
import js.Browser;
import js.html.CanvasElement;
import js.html.Element;
import js.html.Event;
import motion.Actuate;
import pixi.core.display.Container;
import pixi.core.renderers.canvas.CanvasRenderer;
import pixi.core.renderers.Detector;
import pixi.core.renderers.Detector.RenderingOptions;
import pixi.core.renderers.SystemRenderer;
import pixi.core.renderers.webgl.WebGLRenderer;

class Engine
{
	static private var _instance:Engine;
	static public var instance(get, never):Engine;
	static private function get_instance():Engine
	{
		return _instance == null ? new Engine() : _instance;
	}
	
	static private var rootStages(default, never):Array<Stage> = [];
	
	public var canvas(default, null):CanvasElement;
	public var renderer(default, null):SystemRenderer;
	public var rootContainer(default, null):Container;
	
	public var physics(default, null):Physics;
	
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var renderingOptions(default, null):RenderingOptions;
	
	public var physicsUpdateTime:Float = 0;
	public var othersUpdateTime:Float = 0;
	public var renderingTime:Float = 0;
	
	private var lastTimeStamp:Float = 0;
	private var extraTimeStamp:Float = 0;
	private var cappedFPS:Bool = false;
	private var targetDeltaStamp:Float = 0;
	
	#if debug
	private var stepByStep:Bool = false;
	#end
	
	private function new()
	{
		if (_instance != null) throw "You can't instantiate more than one Engine!";
		_instance = this;
	}
	
	public function init(width:Int, height:Int, options:RenderingOptions, type:RendererType, ?parentDom:Element):Engine
	{
		this.width = width;
		this.height = height;
		this.renderingOptions = options;
		
		switch (type)
		{
			case RendererType.AUTO:
				renderer = Detector.autoDetectRenderer(width, height, options);
			case RendererType.CANVAS:
				renderer = new CanvasRenderer(width, height, options);
			case RendererType.WEBGL:
				renderer = new WebGLRenderer(width, height, options);
		}
		
		canvas = renderer.view;
		renderer.view.style.display = "block";
		renderer.view.style.margin = "auto";
		
		if (parentDom == null)
		{
			Browser.document.body.appendChild(renderer.view);
		}
		else
		{
			parentDom.appendChild(renderer.view);
		}
		
		if (options.autoResize)
		{
			Browser.window.onresize = onWindowResize;
		}
		
		Browser.window.requestAnimationFrame(onRequestAnimationFrame);
		
		rootContainer = new Container();
		physics = Physics.instance;
		Input.init();
		
		// Init Waud sound engine
		Waud.init();
		
		#if actuate_manual_update
		Actuate.defaultActuator = SmoothActuator;
		#end
		
		return this;
	}
	
	public function start(?stage:Stage, ?targetFPS:Int):Void
	{
		if (targetFPS != null && targetFPS < 60)
		{
			cappedFPS = true;
			Time.targetFPS = targetFPS;
			targetDeltaStamp = 1000 / targetFPS;
		}
		
		if (stage != null)
		{
			addStage(stage);
		}
	}
	
	public function addStage(stage:Stage, ?at:Int):Stage
	{
		rootStages.push(stage);
		if (at != null)
		{
			rootContainer.addChildAt(stage, at);
		}
		else
		{
			rootContainer.addChild(stage);
		}
		return stage;
	}
	
	public function removeStage(stage:Stage):Stage
	{
		rootStages.remove(stage);
		this.rootContainer.removeChild(stage);
		return stage;
	}
	
	private function onRequestAnimationFrame(now:Float):Bool
	{
		var deltaStamp = now - lastTimeStamp;
		Browser.window.requestAnimationFrame(onRequestAnimationFrame);
		
		if (cappedFPS)
		{
			if (deltaStamp >= targetDeltaStamp)
			{
				update(deltaStamp - extraTimeStamp);
				var before = Date.now().getTime();
				renderer.render(rootContainer);
				renderingTime = Date.now().getTime() - before;
				extraTimeStamp = deltaStamp % targetDeltaStamp;
				lastTimeStamp = now - extraTimeStamp;
			}
		}
		else
		{
			update(deltaStamp);
			var before = Date.now().getTime();
			renderer.render(rootContainer);
			renderingTime = Date.now().getTime() - before;
			lastTimeStamp = now;
		}
		
		return true;
	}
	
	private function updatePhysics():Void
	{
		#if debug
		if (Input.isKeyPressed(KeyCode.CLOSED_BRACKET))
		{
			stepByStep = true;
		}
		if (Input.isKeyUp(KeyCode.OPEN_BRACKET))
		{
			stepByStep = !stepByStep;
		}
		if (stepByStep && !Input.isKeyPressed(KeyCode.CLOSED_BRACKET))
		{
			return;
		}
		#end
		
		for (n in 0...Physics.interactionsPerFrame)
		{
			// physics updates (update velocity, hacks, etc.)
			for (i in 0...rootStages.length)
			{
				rootStages[i].fixedUpdate();
			}
			
			// forward one physics step
			physics.update();
		}
	}
	
	private function update(ds:Float):Void
	{
		// from milliseconds (engine ticks) to seconds
		Time.tick(ds);
		
		var physicsUpdateBefore = Date.now().getTime();
		
		updatePhysics();
		
		var physicsUpdateAfter = Date.now().getTime();
		physicsUpdateTime = physicsUpdateAfter - physicsUpdateBefore;
		
		// general updates (update positions, scales, etc.)
		for (i in 0...rootStages.length)
		{
			rootStages[i].update();
		}
		
		// late updates (for things require final positions, i.e. Camera)
		for (i in 0...rootStages.length)
		{
			rootStages[i].lateUpdate();
		}
		
		Input.clearCache();
		
		othersUpdateTime = Date.now().getTime() - physicsUpdateAfter;
	}
	
	@:noCompletion function onWindowResize(event:Event)
	{
		width = Browser.window.innerWidth;
		height = Browser.window.innerHeight;
		renderer.resize(width, height);
		canvas.style.width = width + "px";
		canvas.style.height = height + "px";
	}
}

enum RendererType
{
	AUTO;
	WEBGL;
	CANVAS;
}