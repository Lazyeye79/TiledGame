import starling.display.Sprite;
import starling.display.Image;
import starling.events.Event;
import starling.events.EnterFrameEvent;
import starling.events.KeyboardEvent;
import flash.geom.Rectangle;
import starling.text.TextField;


class Game extends Sprite{
	public var rootSprite:Sprite;
	private var map:Array<Array<Int>>;
	private var pickupObject:Pickup;
	public var fuel:Float;
	public var fuel10:Image;
	public var wrench1:Image;
	public var wrench2:Image;
	public var wrench3:Image;

	public var collected:Int;
	
	private var asteroid:Array<Asteroid>;
	private var fuelcan:Array<FuelCan>;
	private var characters:Array<Character>;
	private var numOfCharacters:Int = 7;
	private var numOfAsteroids = 25;
	private var numOfFuel = 5;
	private var mapSize = 1300;
	private var health = 3;

	// Numerical key codes for WASD
	public var K_UP : Int	 = 87;
	public var K_LEFT : Int	 = 65;
	public var K_DOWN : Int	 = 83;
	public var K_RIGHT : Int = 68;

	public var D_UP : Int = 38;
	public var D_DOWN : Int = 40;
	public var D_LEFT : Int = 37;
	public var D_RIGHT : Int = 39;
	
	private var flag = true;



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
		var menu = new Menu(Menu, rootSprite);
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

		fuelcan = new Array<FuelCan>();

		characters = new Array<Character>();

		mapGenerator = new GenerateMap();
		world = new World(mapGenerator.getMap());
		world.x = 0;
		world.y = 0;
		rootSprite.addChild(world);
		
		wrench1 = new Image(Root.assets.getTexture("wrench"));
		wrench1.x = 520;
		wrench1.y = 20;
		rootSprite.addChild(wrench1);

		wrench2 = new Image(Root.assets.getTexture("wrench"));
		wrench2.x = 552;
		wrench2.y = 20;
		rootSprite.addChild(wrench2);

		wrench3 = new Image(Root.assets.getTexture("wrench"));
		wrench3.x = 584;
		wrench3.y = 20;
		rootSprite.addChild(wrench3);

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

		fuel = 500;


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

		generateFuel();

		generateCharacters();

	}

	public function onEnterFrame(event:EnterFrameEvent) {
		


		updateVelocity();
		world.setCoords(ship.x, ship.y);
		//updateMap();
 		
 		//computes the fuel bar
 		if(fuel >= 0){
			fuel10.scaleX = fuel/500;
		}
		


		ship.x += vx;
		ship.y += vy;

		gx += vx;
		gy += vy;


		if(ship.x > 500 && gx < (mapGenerator.map.length * 16) - 356 ){

		 	world.x -= vx;
		 	//ship.x -= vx;

		 	fx += vx;
		}

		if(ship.y > 400 && gy < (mapGenerator.map.length * 16) - 296 )
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
		
		if (gx < 32 || gx > (mapGenerator.map.length * 16) - 72)
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
		
		if (gy < 32 || gy > (mapGenerator.map.length * 16) - 108)
		{
			//ship.y -= 2;
			vy = -vy;
		}

		var num;
		for (num in 0...numOfAsteroids) {
			if (asteroid[num].collisionTest(ship) == true) {
				Root.assets.playSound("bash");
				if(health == 3){
					rootSprite.removeChild(wrench1);
				}
				if(health == 2){
					rootSprite.removeChild(wrench2);
				}
				if(health == 1){
					rootSprite.removeChild(wrench3);
				}
				world.removeChild(asteroid[num]);
				asteroid[num].x = -30;
				asteroid[num].y = -30;
				health -= 1;
			}
		}

		var num;
		for (num in 0...numOfFuel) {
			if (fuelcan[num].collisionTest(ship) == true) {
				Root.assets.playSound("ding");
				if (fuel <= 400){
					fuel = fuel + 100;
				}
				else {
					fuel = 500;
				}
				world.removeChild(fuelcan[num]);
				fuelcan[num].x = -30;
				fuelcan[num].y = -30;
				//trace("You collect fuel", num);
			}
		}
		var num;
		for (num in 0...numOfCharacters) {
			if (characters[num].collisionTest(ship) == true) {
				world.removeChild(characters[num]);
				characters[num].x = -30;
				characters[num].y = -30;
				collected += 1;
				trace("Collected " + collected + "characters");
			}
		}
		
		if (health <= 0)
			gameOver();
		if (fuel <= 0)
			gameOverOoF();
		if (collected == 7)
			gameWin();

	}

	public function keyDown( event:KeyboardEvent ) {

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
		
		if(fuel > 0){
		
			if(keyMap.get( K_UP )){
				vy -= 0.3;
				fuel -= .5;
			}

			if(keyMap.get( K_DOWN )){
				vy += 0.3;
				fuel -= .5;
			}

			if(keyMap.get( K_LEFT )){
				vx -= 0.3;
				fuel -= .5;
			}

			if(keyMap.get( K_RIGHT )){
				vx += 0.3;
				fuel -= .5;
			}
			if(keyMap.get( D_UP)){
				vy -= 0.3;
				fuel -= .5;
			}

			if(keyMap.get( D_DOWN)){
				vy += 0.3;
				fuel -= .5;
			}

			if(keyMap.get( D_LEFT)){
				vx -= 0.3;
				fuel -= .5;
			}

			if(keyMap.get( D_RIGHT)){
				vx += 0.3;
				fuel -= .5;
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
		//numOfAsteroids = 100;
		var num;
		for (num in 0...numOfAsteroids) {
			asteroid[num] = new Asteroid("meteor" + (Std.random(3) + 1));
			asteroid[num].x = Std.random(mapSize);
			asteroid[num].y = Std.random(mapSize);
			var check;
			for (check in 0...num - 1) {
				while (Math.sqrt((asteroid[num].x - asteroid[check].x) * (asteroid[num].x - asteroid[check].x) + (asteroid[num].y - asteroid[check].y) * (asteroid[num].y - asteroid[check].y)) < 117) {
					asteroid[num].x = Std.random(mapSize);
					asteroid[num].y = Std.random(mapSize);
				}
			}
			world.addChild(asteroid[num]);
		}
		for (meteor in asteroid) {
			if (Math.abs(meteor.x - ship.x) < 50) {
				meteor.x = meteor.x + 50;
			}
			if (Math.abs(meteor.y - ship.y) < 110) {
				meteor.y = meteor.y + 110;
			}
		}
	}

	public function generateFuel() {
		var num;
		for (num in 0...numOfFuel) {
			fuelcan[num] = new FuelCan("fuelcan");
			fuelcan[num].x = Std.random(mapSize);
			fuelcan[num].y = Std.random(mapSize);
			for (Asteroid in asteroid) {
				while (Math.abs(Asteroid.x - fuelcan[num].x) < 30) {
					fuelcan[num].x = Std.random(mapSize);
				}
				while (Math.abs(Asteroid.y - fuelcan[num].y) < 30) {
					fuelcan[num].y = Std.random(mapSize);
				}
			}
			world.addChild(fuelcan[num]);
		}
	}

	public function generateCharacters() {
		var num;
		for (num in 0...numOfCharacters) {
			characters[num] = new Character("character"+(num+1));
			characters[num].x = Std.random(mapSize);
			characters[num].y = Std.random(mapSize);
			for (Asteroid in asteroid) {
			 	while (Math.abs(Asteroid.x - characters[num].x) < 30) {
			 		characters[num].x = Std.random(mapSize);
			 	}
			 	while (Math.abs(Asteroid.y - characters[num].y) < 30) {
			 		characters[num].y = Std.random(mapSize);
			 	}
			 }
			world.addChild(characters[num]);
		}
	}
	
	
	
	private function gameOverOoF() {
		if (flag) {
			flag = false;
			rootSprite.dispose();
			rootSprite.removeChildren();
			var menu = new Menu(OutOfFuel, rootSprite);
			rootSprite.addChild(menu);
		}
	}
	
	private function gameOver() {
		if (flag) {
			flag = false;
			rootSprite.dispose();
			rootSprite.removeChildren();
			var menu = new Menu(GameOver, rootSprite);
			rootSprite.addChild(menu);
		}
	}

	private function gameWin() {
		if (flag) {
			flag = false;
			rootSprite.dispose();
			rootSprite.removeChildren();
			var menu = new Menu(GameWin, rootSprite);
			rootSprite.addChild(menu);
		}
	}
}