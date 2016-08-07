package gamball.configs;
import gamball.entities.Ball.BallConfig;
import pixi.loaders.Loader;
import pixi.loaders.Resource;

class GameConfig
{
	public var ballConfigs(default, null):Array<BallConfig>;
	
	private function new(ballConfigs:Dynamic)
	{
		this.ballConfigs = ballConfigs;
	}
	
	static public function load(callback:GameConfig->Void):Void
	{
		var ballConfigs:Array<BallConfig> = null;
		new Loader().add("balls", "assets/configs/ball_config.json", null, function(resource:Resource):Void
		{
			ballConfigs = resource.data;
		}).load(function():Void
		{
			callback(new GameConfig(ballConfigs));
		});
	}
}