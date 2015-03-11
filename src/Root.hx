import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.core.Starling;
import starling.animation.Transitions;

class Root extends Sprite {

	public static var assets: AssetManager;
	public var rootSprite:Sprite;

	public function new() {
		rootSprite = this;
		super();
	}

	public function start(startup:Startup) {
		assets = new AssetManager();
		assets.enqueue("assets/ship.png");
		assets.enqueue("assets/star1a.png");
		assets.enqueue("assets/star2a.png");
		assets.enqueue("assets/star3a.png");
		assets.enqueue("assets/starB.png");
		
		assets.loadQueue(function onProgress(ratio:Float) {
			if (ratio == 1) {
				// fade the loading screen, start game
				Starling.juggler.tween(startup.loadingBitmap, 1.0, {
					transition:Transitions.EASE_OUT, delay:0.5, alpha: 0, onComplete: function() {
						startup.removeChild(startup.loadingBitmap);
					}
				});
				
				addChild(new Menu(rootSprite));
			}
		});
	}
}