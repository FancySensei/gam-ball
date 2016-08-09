package engine.entities;
import engine.system.Physics;
import nape.dynamics.Arbiter;
import nape.dynamics.CollisionArbiter;
import nape.dynamics.ContactList;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import pixi.core.graphics.Graphics;

class PhysicObject extends GameObject
{
	// Shortcuts
	public var physics(default, null):Physics;
	
	// Physic Object has at least one Body
	public var body(default, null):Body;
	public var debugDraw(default, null):Graphics;
	
	public var contactBodyList(default, null):Array<Body>;
	
	public function new(bodyType:BodyType, ?position:Vec2)
	{
		super();
		physics = Physics.instance;
		body = new Body(bodyType, position);
		contactBodyList = new Array();
	}
	
	private function addDebugDraw():Void
	{
		removeDebugDraw();
		debugDraw = new Graphics();
		physics.debugDraw.addChild(debugDraw);
	}
	
	private function removeDebugDraw():Void
	{
		if (debugDraw != null)
		{
			physics.debugDraw.removeChild(debugDraw);
			debugDraw.destroy(true, true);
			debugDraw = null;
		}
	}
	
	private function onCollisionEnter(body:Body, ?contacts:ContactList):Void { }
	
	private function onCollisionExit(body:Body):Void { }
	
	private function syncTransform():Void
	{
		position.set(body.position.x, body.position.y);
		rotation = body.rotation;
	}
	
	override public function fixedUpdate():Void
	{
		if (!isEnabled) return;
		
		super.fixedUpdate();
		
		syncTransform();
		
		// Update contact bodies
		var length = body.arbiters.length;
		if (length > 0)
		{
			var listCopy = contactBodyList.copy();
			for (arbiter in body.arbiters)
			{
				var otherBody:Body = arbiter.body1 == body ? arbiter.body2 : arbiter.body1;
				
				// Add the body into the list and fire the event
				if (contactBodyList.indexOf(otherBody) < 0)
				{
					contactBodyList.push(otherBody);
					onCollisionEnter(otherBody, arbiter.isCollisionArbiter() ? arbiter.collisionArbiter.contacts : null);
				}
				
				// Remove the existing body from the list copy
				listCopy.remove(otherBody);
			}
			// Bodies which remaining in the list --> no longer contact with the body
			for (remainBody in listCopy)
			{
				contactBodyList.remove(remainBody);
				onCollisionExit(remainBody);
			}
		}
		else
		{
			// We pop out one by one, make sure the body is not in the list when call the function
			for (i in 0...contactBodyList.length)
			{
				var otherBody:Body = contactBodyList.pop();
				onCollisionExit(otherBody);
			}
		}
	}
	
	override public function update():Void 
	{
		if (!isEnabled) return;
		
		super.update();
		
		// Update the debug draw
		if (debugDraw != null)
		{
			debugDraw.position.copy(position);
			debugDraw.rotation = body.rotation;
		}
	}
	
	override public function destroy():Void 
	{
		removeDebugDraw();
		body.space = null;
		super.destroy();
	}
}