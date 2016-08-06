package engine.entities;
import pixi.core.display.Container;

interface IGameObject
{
	public function fixedUpdate():Void;
	public function update():Void;
	public function lateUpdate():Void;
}