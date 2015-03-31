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
	public var fuel:Float;
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
	
	private var asteroid:Array<Asteroid>;
	private var numOfAsteroids = 100;

	// Numerical key codes for WASD
	public var K_UP : Int	 = 87;
	public var K_LEFT : Int	 = 65;
	public var K_DOWN : Int	 = 83;
	public var K_RIGHT : Int = 68;

	public var D_UP : Int = 38;
	public var D_DOWN : Int = 40;
	public var D_LEFT : Int = 37;
	public var D_RIGHT : Int = 39;



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
		var menu = new Menu();
		rootSprite.addChild(menu);
		menu.addEventListener(EnterFrameEvent.ENTER_FRAME, 
			function(){
				if (menu.getStart() == true){
					rootSprite.removeChild(menu);
					run();
				}
			});	
	}

	public function run() {
		
		asteroid = new Array<Asteroid>();

		
		mapGenerator = new GenerateMap();
		world = new World(mapGenerator.getMap());
		world.x = -32;
		world.y = -32;
		rootSprite.addChild(world);
		
		
		
		ship = new Image(Root.assets.getTexture("ship"));
		ship.x = fx + 300;
		ship.y = fy + 250;

		gx = ship.x;
		gy = ship.y;

		fuel10 = new Image(Root.assets.getTexture("fuel10"));
		fuel10.x = 20;
		fuel10.y = 20;
		rootSprite.addChild(fuel10);


		ship = new Image(Root.assets.getTexture("ship"));
		ship.x = fx + 300;
		ship.y = fy + 250;
		world.addChild(ship);

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

		keyMap.set(D_UP, false); 	// arrow (up)
		keyMap.set(D_LEFT, false); 	// arrow (left)
		keyMap.set(D_DOWN, false); 	// arrow (down)
		keyMap.set(D_RIGHT, false); // arrow (right)
		
		generateAsteroids();

	}

	public function onEnterFrame(event:EnterFrameEvent){

		updateVelocity();
		//updateMap();
 		
 		//computes the fuel bar
 		if(fuel >= 0){
			fuel10.scaleX = fuel/1000;
		}
		


		ship.x += vx;
		ship.y += vy;

		gx += vx;
		gy += vy;


		if(ship.x > 500)
		{
		 	world.x -= vx;
		 	//ship.x -= vx;

		 	fx += vx;
		}

		if(ship.y > 400)
		{
		 	world.y -= vy;
		 	//ship.y -= vy;

		 	fy += vy;
		}

		if(ship.x < 100 && gx > 100)
		{
		 	world.x -= vx;
		 	//ship.x -= vx;

		 	fx += vx;
		}
		
		if (gx < 2 || gx > (mapGenerator.map.length * 16))
		{
			//ship.x -= 2;
			vx = -vx;
		}
		

		if(ship.y < 100 && gy > 100)
		{
		 	world.y -= vy;
		 	//ship.y -= vy;

		 	fy += vy;
		}
		
		if (gy < 2 || gy > (mapGenerator.map.length * 16))
		{
			//ship.y -= 2;
			vy = -vy;
		}

		var num;
		for (num in 0...numOfAsteroids) {
			if (asteroid[num].collisionTest(ship) == true) {
				//trace("You're hitting an asteroid!", num);
			}
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
		return (keyCode == K_UP || keyCode == K_LEFT || keyCode == K_DOWN || keyCode == K_RIGHT || keyCode == D_UP || keyCode == D_LEFT || keyCode == D_DOWN || keyCode == D_RIGHT);
	}

	private function updateVelocity(){
		
		if(fuel != 0){
		
			if(keyMap.get( K_UP )){
				vy -= 0.3;
				fuel -= .2;
			}

			if(keyMap.get( K_DOWN )){
				vy += 0.3;
				fuel -= .2;
			}

			if(keyMap.get( K_LEFT )){
				vx -= 0.3;
				fuel -= .2;
			}

			if(keyMap.get( K_RIGHT )){
				vx += 0.3;
				fuel -= .2;
			}
			if(keyMap.get( D_UP)){
				vy -= 0.3;
				fuel -= .2;
			}

			if(keyMap.get( D_DOWN)){
				vy += 0.3;
				fuel -= .2;
			}

			if(keyMap.get( D_LEFT)){
				vx -= 0.3;
				fuel -= .2;
			}

			if(keyMap.get( D_RIGHT)){
				vx += 0.3;
				fuel -= .2;
			}
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
	
	
	public function generateAsteroids() {
		var num;
		for (num in 0...numOfAsteroids) {
			asteroid[num] = new Asteroid("meteor1");
			asteroid[num].x = Std.random(1600);
			asteroid[num].y = Std.random(1600);

			world.mapContainer.addChild(asteroid[num]);
		}
		world.mapContainer.flatten();
	}
}