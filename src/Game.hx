import starling.display.Sprite;
import starling.display.Image;

class Game extends Sprite{
	public var rootSprite:Sprite;
	private var map:Array<Array<Int>>;

	public function new(rootSprite:Sprite){
		super();
		this.rootSprite = rootSprite;
		run();
	}

	public function run(){
		var mapGenerator = new GenerateMap();
		map = mapGenerator.getMap();
		for (x in 0...50){
			for (y in 0 ... 40){
				if (map[x][y]==0){
					var starArray = new Array();
					starArray[0] = "star1a";
					starArray[1] = "star2a";
					starArray[2] = "starB";

					var num:Int = Std.random(10);
					var stars:Image;
					if (num > 1)
					{
						stars = new Image(Root.assets.getTexture(starArray[2]));

					}
					else stars = new Image(Root.assets.getTexture(starArray[num]));
					stars.x = 0 + x*16;
					stars.y = 0 + y*16;
					rootSprite.addChild(stars);
				}
			}
		}
		var ship = new Image(Root.assets.getTexture("ship"));
		ship.x = 100;
		ship.y = 100;
		rootSprite.addChild(ship);
	}
}