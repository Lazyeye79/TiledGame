import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.core.Starling;

class World extends Sprite{
	
	public var tiles:Array<Array<Tile>>;
	private var xCoord:Float;
	private var yCoord:Float;

	var mapGenerator: GenerateMap;
	public var mapContainer:MapContainer;

	public function new(tiles:Array<Array<Tile>>){
		super();
		this.tiles = tiles;
		mapContainer = new MapContainer(tiles);
		this.addChild(mapContainer);
		this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
	}

	public function updateMap(){
		
	}

	public function onEnterFrame(event:EnterFrameEvent){
		mapContainer.updateMap(x,y);
	}
	public function setCoords(shipX:Float, shipY:Float){
		xCoord = shipX;
		yCoord = shipY;
	}
}