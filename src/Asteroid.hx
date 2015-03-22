import starling.display.Image;

class Asteroid extends Image{

	public function new(x:Int, y:Int, t:Int){
		super(Root.assets.getTexture("starB"));
		var asteroidArray = new Array();
		asteroidArray[1] = "meteorCorner";
		asteroidArray[2] = "meteorFull";
		asteroidArray[3] = "meteorSide";
		asteroidArray[4] = "meteorGold";

		this.texture = Root.assets.getTexture(asteroidArray[t]);
		
		this.x = x;
		this.y = y;
	}

	

}