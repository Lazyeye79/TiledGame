import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.core.Starling;

class MapContainer extends Sprite{
	public var tiles:Array<Array<Tile>>;

	var mapGenerator: GenerateMap;

	public function new(tiles:Array<Array<Tile>>){
		super();
		this.tiles = tiles;
		this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		for (x in 0...100){
			for (y in 0 ... 100){
				this.addChild(tiles[x][y]);
			}
		}
	}

	public function updateMap(){
		
	}

	public function onEnterFrame(event:EnterFrameEvent){
		
	}
}