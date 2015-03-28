import flash.geom.Rectangle;
import starling.display.Image;

class Asteroid extends Image{
	private var isVisible:Bool = false;
	private var boundingBox:Rectangle;
	private var player:Image;
	private var playerBounds:Rectangle;
	public var nameClass:String = "Asteroid";
	public var asteroidImage:Image;

	public function new(meteor:String){
		super(Root.assets.getTexture(meteor));
		isVisible = true;
	}

	public function collisionTest(player:Image):Bool{
		this.player = player;
		boundingBox = this.bounds;
		playerBounds = player.bounds;
//		trace(player);
//		trace(boundingBox);
		if (playerBounds.intersects(boundingBox)){
			return true;
		}
		return false;
	}
	
}