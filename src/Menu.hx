import starling.display.*;


class Menu extends Sprite{
	public var rootSprite : Sprite;

	public function new(rootSprite:Sprite)
	{
		super();
		this.rootSprite = rootSprite;
		start();

	}

	public function start(){
		var game = new Game(rootSprite);
		rootSprite.addChild(game);
	}
}