import starling.display.Image;

class Star extends Image{

	public function new(x:Int, y:Int){
		super(Root.assets.getTexture("starB"));
		var starArray = new Array();
		starArray[0] = "star1a";
		starArray[1] = "star2a";
		starArray[2] = "starB";

		var num:Int = Std.random(10);
		var stars:Image;
		if (num > 1)
		{
			this.texture = Root.assets.getTexture(starArray[2]);
		}else{
			this.texture = Root.assets.getTexture(starArray[num]);
		}
		this.x = x;
		this.y = y;
	}

	

}