import flash.geom.Rectangle;
import starling.display.Image;

class FuelCan extends Image{
	private var isVisible:Bool = false;
	private var boundingBox:Rectangle;
	private var player:Image;
	private var playerBounds:Rectangle;
	public var nameClass:String = "FuelCan";

	public function new(fuelcan:String){
		super(Root.assets.getTexture(fuelcan));
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