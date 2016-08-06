package engine.entities;
import pixi.core.display.Container;
import pixi.core.display.DisplayObject;

using Std;

class GameObject extends Container implements IGameObject
{
	public var isEnabled(default, default):Bool = true;
	public var updateList(default, null):Array<IGameObject>;
	
	public function addChildWithUpdate(child:IGameObject, updateOnly = false, ?atIndex:Int):IGameObject 
	{
		if (updateList == null) updateList = [];
		
		updateList.push(child);
		if (!updateOnly && child.is(DisplayObject))
		{
			if (atIndex != null)
			{
				addChildAt(cast child, atIndex);
			}
			else
			{
				addChild(cast child);
			}
		}
		return child;
	}
	
	public function removeChildWithUpdate(child:IGameObject, updateOnly = false):IGameObject 
	{
		if (updateList == null) updateList = [];
		
		if (child.is(DisplayObject))
		{
			updateList.remove(cast child);
			if (!updateOnly)
			{
				removeChild(cast child);
			}
		}
		return child;
	}
	
	public function fixedUpdate():Void
	{
		if (!isEnabled || updateList == null) return;
		
		for (i in 0...updateList.length)
		{
			updateList[i].fixedUpdate();
		}
	}
	
	public function update():Void
	{
		if (!isEnabled || updateList == null) return;
		
		for (i in 0...updateList.length)
		{
			updateList[i].update();
		}
	}
	
	public function lateUpdate():Void
	{
		if (!isEnabled || updateList == null) return;
		
		for (i in 0...updateList.length)
		{
			updateList[i].lateUpdate();
		}
	}
	
	override public function destroy():Void
	{
		updateList = null;
		super.destroy();
	}
}