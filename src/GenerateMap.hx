import starling.display.Image;

class GenerateMap{
	private var map:Array<Array<Int>>;

	public function new(world:World){

		map = [for(x in 0...50) [for (y in 0...40) 0]];
		map[4][4] = 1;
		map[5][4] = 4;
		map[6][4] = 1;
		map[5][5] = 2;

			
		for (x in 0...50){
			for (y in 0 ... 40){
				if (map[x][y]==0){
					var stars = new Star(x*16, y*16);
					world.addChild(stars);
				}else if (map[x][y] == 1){
					var asteroid = new Image(Root.assets.getTexture("meteorCorner"));
					asteroid.x = x*16;
					asteroid.y = y*16;
					world.addChild(asteroid);
				}else if (map[x][y] == 2){
					var asteroid = new Image(Root.assets.getTexture("meteorFull"));
					asteroid.x = x*16;
					asteroid.y = y*16;
					world.addChild(asteroid);
				}else if (map[x][y] == 3){
					var asteroid = new Image(Root.assets.getTexture("meteorGold"));
					world.addChild(asteroid);
					asteroid.x = x*16;
					asteroid.y = y*16;
				}else if (map[x][y] == 4){
					var asteroid = new Image(Root.assets.getTexture("meteorSide"));
					asteroid.x = x*16;
					asteroid.y = y*16;
					world.addChild(asteroid);
				}
			}
		}
	}

	public function getMap(){
		return map;
	}

	public function createAsteroid(){

	}
}