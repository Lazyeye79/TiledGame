import starling.display.Image;

class Tile extends Image{

	public function new(x:Int, y:Int, t:Int = 0){
		super(Root.assets.getTexture("starB"));
		var starArray = new Array();
		starArray[0] = "star1a";
		starArray[1] = "star2a";
		starArray[2] = "starB";

		var asteroidArray = new Array();
		asteroidArray[1] = "meteorCorner";
		asteroidArray[2] = "meteorFull";
		asteroidArray[3] = "meteorSide";
		asteroidArray[4] = "meteorGold";



		if(t > 0) this.texture = Root.assets.getTexture(asteroidArray[t]);

		else{
			
			var num:Int = Std.random(10);
			var stars:Image;
			if (num > 1)
			{
				this.texture = Root.assets.getTexture(starArray[2]);
			}else{
				this.texture = Root.assets.getTexture(starArray[num]);
			}
		}
		
		this.x = x;
		this.y = y;
	}

	

}