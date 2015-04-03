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
		for (x in 0...52){
			for (y in 0 ... 42){
				this.addChild(tiles[x][y]);
			}
		}
		this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
	}

	public function updateMap(shipX:Float, shipY:Float){
		var size = this.numChildren;
		
		// for(i in 0...size){
		// 	if(this.getChildAt(i).height == 16){
		// 		if(this.getChildAt(i))
		// 	}
		// }
	}

	public function onEnterFrame(event:EnterFrameEvent){
	}


}