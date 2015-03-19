import starling.display.Sprite;
import starling.display.Image;
import starling.events.Event;
import starling.events.EnterFrameEvent;
import starling.events.KeyboardEvent;

class Game extends Sprite{
	public var rootSprite:Sprite;
	private var map:Array<Array<Int>>;

	// Numerical key codes for WASD
		public var K_UP : Int	 = 87;
		public var K_LEFT : Int	 = 65;
		public var K_DOWN : Int	 = 83;
		public var K_RIGHT : Int = 68;

		//Map to keep track of what keys are being pressed
		private var keyMap : Map<Int, Bool> = new Map<Int, Bool>();

		//X and Y Velocity
		var vx:Float = 0;
		var vy:Float = 0;

		var ship:Image;
		var world:World;

	public function new(rootSprite:Sprite){
		super();
		this.rootSprite = rootSprite;
		run();
	}

	public function run(){
		world = new World();
		rootSprite.addChild(world);
		var mapGenerator = new GenerateMap(world);
		
		ship = new Image(Root.assets.getTexture("ship"));
		ship.x = 100;
		ship.y = 100;
		rootSprite.addChild(ship);

		rootSprite.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		rootSprite.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		rootSprite.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

		keyMap.set(K_UP, false); 	// W (up)
		keyMap.set(K_LEFT, false); 	// A (left)
		keyMap.set(K_DOWN, false); 	// S (down)
		keyMap.set(K_RIGHT, false); // D (right)

	}

	public function onEnterFrame(event:EnterFrameEvent){

		updateVelocity();

		ship.x += vx;
		ship.y += vy;

		// if(ship.x > 400)
		// {
		// 	world.x -= vx;
		// }

	}

	public function keyDown( event:KeyboardEvent ){

		var keyCode:Int = event.keyCode;
		if(!isBound(keyCode))
			return;
			
		if(keyMap.get(keyCode))
			return;
			
		keyMap.set(keyCode, true);

	}

	public function keyUp( event:KeyboardEvent ){

		var keyCode:Int = event.keyCode;
		if(!isBound(keyCode))
			return;
			
		keyMap.set(keyCode, false);
	}

	private function isBound( keyCode:Int ) : Bool {
		return (keyCode == K_UP || keyCode == K_LEFT || keyCode == K_DOWN || keyCode == K_RIGHT);
	}

	private function updateVelocity(){
		
		if(keyMap.get( K_UP )){
			vy -= 0.2;
		}

		if(keyMap.get( K_DOWN )){
			vy += 0.2;
		}

		if(keyMap.get( K_LEFT )){
			vx -= 0.2;
		}

		if(keyMap.get( K_RIGHT )){
			vx += 0.2;
		}

		if(vx > 0) vx -= .03;
		if(vx < 0) vx += .03;
		
		if(vy > 0) vy -= .03;
		if(vy < 0) vy += .03;
		
	}

}