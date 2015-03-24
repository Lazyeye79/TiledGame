import starling.display.Image;


class GenerateMap{
	public var map:Array<Array<Int>>;
	public var stars:Array<Array<Star>>;

	public function new(world:World){

		map = [for(x in 0...500) [for (y in 0...500) 0]];
		map[4][4] = 1;
		map[5][4] = 4;
		map[6][4] = 1;
		map[5][5] = 2;

		stars = [for(x in 0...500) [for (y in 0...500) new Star(0,0)]];

			
		for (x in 0...500){
			for (y in 0 ... 500){
				if (map[x][y]==0){
					stars[x][y] = new Star(x*16, y*16);
				}
				else{
					var asteroid = new Asteroid(x*16, y*16, map[x][y]);

					//Corner correction
					if(map[x+1][y] > 1)
					{
						asteroid.rotation = -1.57079633;
						asteroid.y += 16;
					}


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