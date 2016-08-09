package gamball.configs;
import gamball.entities.Ball.BallConfig;
import pixi.loaders.Loader;
import pixi.loaders.Resource;

using Reflect;

class GameConfig
{
	public var ballConfigs(default, null):Map<String, BallConfig> = new Map();
	
	private function new(ballCfgData:Dynamic)
	{
		for (key in ballCfgData.fields())
		{
			ballConfigs.set(key, ballCfgData.field(key));
		}
	}
	
	static public function load(callback:GameConfig->Void):Void
	{
		var ballConfigs:Dynamic = null;
		new Loader().add("balls", "assets/configs/ball_config.json", null, function(resource:Resource):Void
		{
			ballConfigs = resource.data;
		}).load(function():Void
		{
			callback(new GameConfig(ballConfigs));
		});
	}
}