class GenerateMap{
	private var map:Array<Array<Int>>;

	public function new(world:World){

		map = [for(x in 0...50) [for (y in 0...40) 0]];
			
		for (x in 0...50){
			for (y in 0 ... 40){
				if (map[x][y]==0){
					var stars = new Star(x*16, y*16);
					world.addChild(stars);
				}
			}
		}
	}

	public function getMap(){
		return map;
	}
}