package gamball;
import engine.Engine;
import engine.entities.Stage;
import engine.system.Physics;
import gamball.stages.PreloadStage;
import gamball.stages.TestStage;
import pixi.core.renderers.Detector.RenderingOptions;

@:keep
@:expose("GamBall")
class GamBall
{
	static public var screenWidth(default, null):Int = 1280;
	static public var screenHeight(default, null):Int = 720;
	static public var targetFPS(default, null):Int = 60;
	
	static private var _instance(default, null):GamBall;
	static public var instance(get, never):GamBall;
	static private function get_instance()
	{
		return _instance == null ? new GamBall() : _instance;
	}

	public var engine(default, null):Engine;
	public var currentStage(default, null):Stage;
	
	private function new()
	{
		if (_instance != null) throw "You can't instantiate more than one Racing Game!";
		_instance = this;
		
		var options:RenderingOptions =
		{
			backgroundColor: 0x54315B,
			transparent: false,
			autoResize: false,
			resolution: 1.0,
			clearBeforeRender: true,
			antialias: false,
			forceFXAA: false,
			preserveDrawingBuffer: false
		}
		
		engine = Engine.instance.init(screenWidth, screenHeight, options, RendererType.AUTO);
	}
	
	static public function run(?width:Int, ?height:Int, ?fps:Int):Void
	{
		if (width != null) screenWidth = width;
		if (height != null) screenHeight = height;
		if (fps != null) targetFPS = fps;
		instance.start();
	}
	
	public function start():Void
	{
		engine.start(new PreloadStage(), targetFPS);
	}
	
	public function changeStage(stage:Stage):Void
	{
		if (currentStage != null)
		{
			engine.removeStage(currentStage);
		}
		engine.addStage(currentStage = stage);
	}
}