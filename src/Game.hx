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
		var world = new World();
		rootSprite.addChild(world);
		var mapGenerator = new GenerateMap(world);
		
		var ship = new Image(Root.assets.getTexture("ship"));
		ship.x = 100;
		ship.y = 100;
		rootSprite.addChild(ship);
	}
}