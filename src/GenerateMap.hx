class GenerateMap{
	private var map:Array<Array<Int>>;

	public function new(){
		/*trace(" Dynamic ");
		for (x in 1...50){
			for (y in 1...40){
				trace("balls");
				map[x][y] = 0;
				trace(" Dynamic balls");
			}
		}*/
		map = [for(x in 0...50) [for (y in 0...40) 0]];
	}

	public function getMap(){
		return map;
	}
}