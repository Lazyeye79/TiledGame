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

		//Gloabal x and y for the ship's position
		var gx:Float = 0;
		var gy: Float = 0;

		//Gloabal x and y for the window position
		var fx:Float = 0;
		var fy: Float = 0;

		var ship:Image;
		var world:World;
		var mapGenerator:GenerateMap;

	public function new(rootSprite:Sprite){
		super();
		this.rootSprite = rootSprite;
		run();
	}

	public function run(){

		world = new World();
		mapGenerator = new GenerateMap(world);
		
		
		
		ship = new Image(Root.assets.getTexture("ship"));
		ship.x = 120;
		ship.y = 120;

		gx = ship.x;
		gy = ship.y;



		rootSprite.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		rootSprite.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		rootSprite.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

		keyMap.set(K_UP, false); 	// W (up)
		keyMap.set(K_LEFT, false); 	// A (left)
		keyMap.set(K_DOWN, false); 	// S (down)
		keyMap.set(K_RIGHT, false); // D (right)

	}

	public function updateMap(){
		
		rootSprite.removeChild(world);
		rootSprite.addChild(world);

		while (world.numChildren > 0) {
   			world.removeChildAt(0);
		}	
		


		for (x in 0...52){
			for (y in 0 ... 42){
				world.addChild(mapGenerator.stars[(x + Math.floor((fx)/16))][(y + Math.floor((fy)/16))]);
			}
		}
	}

	public function onEnterFrame(event:EnterFrameEvent){

		updateVelocity();
		updateMap();

		ship.x += vx;
		ship.y += vy;

		gx += vx;
		gy += vy;

		rootSprite.removeChild(ship);
		rootSprite.addChild(ship);

		if(ship.x > 300)
		{
		 	world.x -= vx;
		 	ship.x -= vx;

		 	fx += vx;
		}

		if(ship.y > 300)
		{
		 	world.y -= vy;
		 	ship.y -= vy;

		 	fy += vy;
		}

		if(ship.x < 100 && gx > 100)
		{
		 	world.x -= vx;
		 	ship.x -= vx;

		 	fx += vx;
		}
		
		

		if(ship.y < 100 && gy > 100)
		{
		 	world.y -= vy;
		 	ship.y -= vy;

		 	fy += vy;
		}
		
		

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