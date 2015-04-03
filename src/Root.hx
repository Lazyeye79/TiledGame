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
		//spritesheet load
		assets.enqueue("assets/spritesheet.png");
		assets.enqueue("assets/spritesheet.xml");

		//load key images
		assets.enqueue("assets/star1a.png");
		assets.enqueue("assets/star2a.png");
		assets.enqueue("assets/star3a.png");
		assets.enqueue("assets/starB.png");
		assets.enqueue("assets/Button.png");

		//load sounds
		assets.enqueue("assets/music.mp3");
		assets.enqueue("assets/bash.mp3");
		assets.enqueue("assets/ding.mp3");

		//load font xml
		assets.enqueue("assets/font.fnt");

		
		assets.loadQueue(function onProgress(ratio:Float) {
			if (ratio == 1) {

				//Start the game music
				musicChannel = assets.playSound("music",0,100);
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
	function soundComplete(e:flash.events.Event)
	{
		musicChannel = assets.playSound("game_music");
		musicChannel.addEventListener(flash.events.Event.SOUND_COMPLETE, soundComplete);
		musicChannel.soundTransform = transform;
	}

}