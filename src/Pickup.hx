import flash.geom.Rectangle;
import starling.display.Image;

class Pickup extends Image{
	private var isVisible:Bool = false;
	private var boundingBox:Rectangle;
	private var player:Rectangle;
	public var nameClass:String = "Pickup";

	public function new(player:Rectangle){
		super(Root.assets.getTexture("ship"));
		this.player = player;
		boundingBox = this.bounds;
		isVisible = true;
		this.x = 500;
		this.y = 500;
	}

	public function pickupObject(){
		isVisible = false;
	}

	public function collisionTest():Bool{
		if (player.intersects(boundingBox)){
			return true;
		}
		return false;
	}
}