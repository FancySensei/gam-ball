package engine.system;
import engine.entities.GameObject;
import engine.entities.Stage;
import js.Browser;
import js.html.DOMWindow;
import js.html.KeyboardEvent;
import js.html.MouseEvent;

class Input
{
	static private inline var EVENT_KEYCODE:String = "keyCode";

	static public var rightClickCallbacks(default, null):Array<MouseEvent->Void> = [];
	static private var downKeys:Array<Int> = [];
	static private var upKeys:Array<Int> = [];
	static private var pressedKeys:Array<Int> = [];
	static private var touchLayer:TouchLayer = new TouchLayer();

	private function new() {}

	static public function init():Void
	{
		var window:DOMWindow = Browser.window.parent != null ? Browser.window.parent : Browser.window;
		window.onkeydown = onKeyDown;
		window.onkeyup = onKeyUp;
		
		// Disabled right click context menu and added a callback for it
		Browser.document.body.oncontextmenu = function(e:MouseEvent):Bool
		{
			for (callback in rightClickCallbacks)
			{
				callback(e);
			}
			return false;
		};
	}

	static private function onKeyDown(event:KeyboardEvent):Void
	{
		var keyCode = event.keyCode;
		if (downKeys.indexOf(keyCode) < 0)
		{
			downKeys.push(keyCode);
			pressedKeys.push(keyCode);
		}
	}
	
	static private function onKeyUp(event:KeyboardEvent):Void
	{
		var keyCode = event.keyCode;
		downKeys.remove(keyCode);
		upKeys.push(keyCode);
	}
	
	static public function clearCache():Void
	{
		pressedKeys = [];
		upKeys = [];
	}
	
	static public function isKeyDown(keycode:Int):Bool
	{
		return downKeys.indexOf(keycode) >= 0;
	}
	
	static public function isKeyUp(keycode:Int):Bool
	{
		return upKeys.indexOf(keycode) >= 0;
	}
	
	static public function isKeyPressed(keycode:Int):Bool
	{
		return pressedKeys.indexOf(keycode) >= 0;
	}
	
	static public var isTouching(get, never):Bool;
	static private function get_isTouching():Bool
	{
		return touchLayer.touches > 0 || touchLayer.isMouseDown;
	}
	
	static public function addTouchBeginCallback(callback:Void->Void):Void
	{
		touchLayer.onTouchBegin.push(callback);
	}
	
	static public function removeTouchBeginCallback(callback:Void->Void):Void
	{
		touchLayer.onTouchBegin.remove(callback);
	}
	
	static public function addTouchFinishedCallback(callback:Void->Void):Void
	{
		touchLayer.onTouchFinished.push(callback);
	}
	
	static public function removeTouchFinishedCallback(callback:Void->Void):Void
	{
		touchLayer.onTouchFinished.remove(callback);
	}
	
	static public function bindTouchLayer(gameObject:GameObject, ?index:Int):Void
	{
		// Slightly dirty but it works
		if (touchLayer.parent != null)
		{
			touchLayer.cleanUp();
			var parent:GameObject = cast touchLayer.parent;
			if (parent != null)
			{
				parent.removeChildWithUpdate(touchLayer);
			}
		}
		
		gameObject.addChildWithUpdate(touchLayer, false, index);
	}
}
