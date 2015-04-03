import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.core.Starling;
import starling.animation.Transitions;

import flash.media.SoundChannel;
import flash.media.SoundTransform;

class Root extends Sprite {

	public static var assets: AssetManager;
	public var rootSprite:Sprite;

	// Sound variables
	var musicChannel:SoundChannel;	
	var transform:SoundTransform;

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
		assets.enqueue("assets/meteorCorner.png");
		assets.enqueue("assets/meteorFull.png");
		assets.enqueue("assets/meteorSide.png");
		assets.enqueue("assets/meteorGold.png");
		assets.enqueue("assets/fuel10.png");
		assets.enqueue("assets/wrench.png");
		assets.enqueue("assets/lose1.png");
		assets.enqueue("assets/lose2.png");
		assets.enqueue("assets/win1.png");

		assets.enqueue("assets/character1.png");
		assets.enqueue("assets/character2.png");
		assets.enqueue("assets/character3.png");
		assets.enqueue("assets/character4.png");
		assets.enqueue("assets/character5.png");
		assets.enqueue("assets/character6.png");
		assets.enqueue("assets/character7.png");
		
		assets.enqueue("assets/Button.png");
		assets.enqueue("assets/meteor1.png");
		assets.enqueue("assets/meteor2.png");
		assets.enqueue("assets/meteor3.png");
		assets.enqueue("assets/fuelcan.png");
		assets.enqueue("assets/mainM.png");

		assets.enqueue("assets/music.mp3");

		
		assets.loadQueue(function onProgress(ratio:Float) {
			if (ratio == 1) {

				//Start the game music
				//musicChannel = 
				assets.playSound("music" ,0, 10000);
				// musicChannel.addEventListener(flash.events.Event.SOUND_COMPLETE, soundComplete);
				// transform = new SoundTransform(0.3, 0);
				// musicChannel.soundTransform = transform;

				// fade the loading screen, start game
				Starling.juggler.tween(startup.loadingBitmap, 1.0, {
					transition:Transitions.EASE_OUT, delay:0.5, alpha: 0, onComplete: function() {
						startup.removeChild(startup.loadingBitmap);
					}
				});
				
				addChild(new Game(rootSprite));
			}
		});
	}

	/** Start the music after it's finished playing */
	// function soundComplete(e:flash.events.Event)
	// {
	// 	musicChannel = assets.playSound("game_music", 0, 0);
	// 	musicChannel.addEventListener(flash.events.Event.SOUND_COMPLETE, soundComplete);
	// 	musicChannel.soundTransform = transform;
	// }

}