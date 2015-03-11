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
					starArray[2] = "star3a";
					starArray[3] = "starB";
					var stars = new Image(Root.assets.getTexture(starArray[Std.random(4)]));
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