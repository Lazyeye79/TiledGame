import flash.geom.Rectangle;
import starling.display.Image;

class Pickup extends Image{
	private var isVisible:Bool = false;
	private var boundingBox:Rectangle;
	private var player:Image;
	private var playerBounds:Rectangle;
	public var nameClass:String = "Pickup";

	public function new(){
		super(Root.assets.getTexture("ship"));
		isVisible = true;
	}

	public function pickupObject(){
		isVisible = false;
	}

	public function collisionTest(player:Image):Bool{
		this.player = player;
		boundingBox = this.bounds;
		playerBounds = player.bounds;
		//trace(player);
		//trace(boundingBox);
		if (playerBounds.intersects(boundingBox)){
			return true;
		}
		return false;
	}
}