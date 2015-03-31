import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.core.Starling;

class World extends Sprite{
	
	public var tiles:Array<Array<Tile>>;
	var mapGenerator: GenerateMap;
	public var mapContainer:MapContainer;

	public function new(tiles:Array<Array<Tile>>){
		super();
		this.tiles = tiles;
		mapContainer = new MapContainer(tiles);
		this.addChild(mapContainer);
	}

	public function updateMap(){
		
	}

	public function onEnterFrame(event:EnterFrameEvent){
		
	}
}