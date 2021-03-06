import starling.display.Image;


class GenerateMap{
	public var map:Array<Array<Int>>;
	public var tiles:Array<Array<Tile>>;

	public function new(){

		map = [for(x in 0...100) [for (y in 0...100) 0]];
		
		tiles = [for(x in 0...100) [for (y in 0...100) new Tile(0,0)]];

			
		for (x in 0...100){
			for (y in 0 ... 100){
				if (map[x][y]==0){
					tiles[x][y] = new Tile(x*16, y*16);
				}
				else{
					var asteroid = new Tile(x*16, y*16, map[x][y]);

					//Corner correction
					if(map[x+1][y] > 1)
					{
						asteroid.rotation = -1.57079633;
						asteroid.y += 16;
					}

					tiles[x][y] = asteroid;


				}
			}
		}
	}

	public function getMap(){
		return tiles;
	}

	public function createAsteroid(){

	}
}