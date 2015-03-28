import starling.display.Sprite;
import starling.display.Image;
import starling.events.Event;
import starling.events.EnterFrameEvent;
import starling.events.KeyboardEvent;
import flash.geom.Rectangle;


class Game extends Sprite{
	public var rootSprite:Sprite;
	private var map:Array<Array<Int>>;
	private var pickupObject:Pickup;
	public var fuel:Int;
	public var fuel10:Image;
	public var fuel9:Image;
	public var fuel8:Image;
	public var fuel7:Image;
	public var fuel6:Image;
	public var fuel5:Image;
	public var fuel4:Image;
	public var fuel3:Image;
	public var fuel2:Image;
	public var fuel1:Image;
	public var fuel0:Image;

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
		var fy: Float= 0;

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
		world.x = -32;
		world.y = -32;
				
		fuel10 = new Image(Root.assets.getTexture("fuel10"));
		fuel10.x = 100;
		fuel10.y = 100;
		
		fuel9 = new Image(Root.assets.getTexture("fuel9"));
		fuel9.x = 100;
		fuel9.y = 100;

		fuel8 = new Image(Root.assets.getTexture("fuel8"));
		fuel8.x = 100;
		fuel8.y = 100;
		
		fuel7 = new Image(Root.assets.getTexture("fuel7"));
		fuel7.x = 100;
		fuel7.y = 100;

		fuel6 = new Image(Root.assets.getTexture("fuel6"));
		fuel6.x = 100;
		fuel6.y = 100;
		
		fuel5 = new Image(Root.assets.getTexture("fuel5"));
		fuel5.x = 100;
		fuel5.y = 100;

		fuel4 = new Image(Root.assets.getTexture("fuel4"));
		fuel4.x = 100;
		fuel4.y = 100;
	
		fuel3 = new Image(Root.assets.getTexture("fuel3"));
		fuel3.x = 100;
		fuel3.y = 100;

		fuel2 = new Image(Root.assets.getTexture("fuel2"));
		fuel2.x = 100;
		fuel2.y = 100;
		
		fuel1 = new Image(Root.assets.getTexture("fuel1"));
		fuel1.x = 100;
		fuel1.y = 100;
		
		fuel0 = new Image(Root.assets.getTexture("fuel0"));
		fuel0.x = 100;
		fuel0.y = 100;

		ship = new Image(Root.assets.getTexture("ship"));
		ship.x = fx + 300;
		ship.y = fy + 250;

		gx = ship.x;
		gy = ship.y;

		fuel = 1000;



		rootSprite.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		rootSprite.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		rootSprite.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

		keyMap.set(K_UP, false); 	// W (up)
		keyMap.set(K_LEFT, false); 	// A (left)
		keyMap.set(K_DOWN, false); 	// S (down)
		keyMap.set(K_RIGHT, false); // D (right)

		pickupObject = new Pickup();
		pickupObject.x = 100;
		pickupObject.y = 100;
		world.addChild(pickupObject);

	}


	public function updateMap(){


		rootSprite.removeChild(world);
		rootSprite.addChild(world);


		var numChild = world.numChildren;

		for (i in 0...numChild){
			//trace(world.getChildAt(i).height);
			if(world.getChildAt(i).height < 17 && (world.getChildAt(i).x < ship.x - 450 || world.getChildAt(i).x < ship.x + 450 || world.getChildAt(i).x < ship.y - 360 || world.getChildAt(i).x < ship.y + 360)){
				//trace(world.getChildAt(i));
				world.removeChildAt(i);
			}
			numChild = world.numChildren;
		}
		//while (world.numChildren > 0) {
   		//	world.removeChildAt(0);
		//}	
		

		for (x in 0...54){
			for (y in 0 ... 44){
				world.addChild(mapGenerator.tiles[(x + Math.floor((fx)/16))][(y + Math.floor((fy)/16))]);
			}
		}

		
	}

	public function onEnterFrame(event:EnterFrameEvent){

		updateVelocity();
		updateMap();

		if (fuel > 900 && fuel <= 1000){
			rootSprite.addChild(fuel10);
		}
		if(fuel > 800 && fuel <= 900){
			rootSprite.addChild(fuel9);
		}
		if(fuel > 700 && fuel <= 800){
			rootSprite.addChild(fuel8);
		}
		if(fuel > 600 && fuel <= 700){
			rootSprite.addChild(fuel7);
		}
		if(fuel > 500 && fuel <= 600){
			rootSprite.addChild(fuel6);
		}
		if(fuel > 400 && fuel <= 500){
			rootSprite.addChild(fuel5);
		}
		if(fuel > 300 && fuel <= 400){
			rootSprite.addChild(fuel4);
		}
		if(fuel > 200 && fuel <= 300){
			rootSprite.addChild(fuel3);
		}
		if(fuel > 100 && fuel <= 200){
			rootSprite.addChild(fuel2);
		}
		if(fuel > 0 && fuel <= 100){
			rootSprite.addChild(fuel1);
		}
		if(fuel == 0){
			rootSprite.addChild(fuel0);
		}

		ship.x += vx;
		ship.y += vy;

		gx += vx;
		gy += vy;

		rootSprite.removeChild(ship);
		rootSprite.addChild(ship);

		if(ship.x > 500)
		{
		 	world.x -= vx;
		 	ship.x -= vx;

		 	fx += vx;
		}

		if(ship.y > 400)
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
		
		if (gx < 2 || gx > (mapGenerator.map.length * 16))
		{
			ship.x -= 2;
			vx = -vx;
		}
		

		if(ship.y < 100 && gy > 100)
		{
		 	world.y -= vy;
		 	ship.y -= vy;

		 	fy += vy;
		}
		
		if (gy < 2 || gy > (mapGenerator.map.length * 16))
		{
			ship.y -= 2;
			vy = -vy;
		}

		if(pickupObject.collisionTest(ship) == true){
			trace("HIT");
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

		if(fuel != 0){
		
			if(keyMap.get( K_UP )){
				vy -= 0.3;
				fuel -= 2;
			}

			if(keyMap.get( K_DOWN )){
				vy += 0.3;
				fuel -= 2;
			}

			if(keyMap.get( K_LEFT )){
				vx -= 0.3;
				fuel -= 2;
			}

			if(keyMap.get( K_RIGHT )){
				vx += 0.3;
				fuel -= 2;
			}

			if(vx > 0) vx -= .03;
			if(vx < 0) vx += .03;
			
			if(vy > 0) vy -= .03;
			if(vy < 0) vy += .03;

			if (vx > 8) vx = 8;
			if (vx < -8) vx = -8;
			
			if (vy > 8) vy = 8;
			if (vy < -8) vy = -8;
		}
	}

}