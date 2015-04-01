import flash.system.ImageDecodingPolicy;
import starling.display.*;
import starling.core.*;
import starling.textures.Texture;
import starling.events.*;
import starling.text.TextField;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.display.Image;

enum GameState
{
	Menu;
	Instructions;
	Credits;
}


class Menu extends Sprite{

	private var playing:Bool = false;
	public var rootSprite : Sprite;
	public var MM : Image = new Image(Root.assets.getTexture("mainM"));


	public function new()
	{
		super();
		//this.rootSprite = rootSprite;
		
		setStage(Menu);
	}
	
	
	private var title : MenuText;
	
	private function setStage(state : GameState)
	{
		removeChildren(0);
		removeChildren(1);
		addChild(MM);
		//MM.x = Starling.current.stage.stageWidth;
		//MM.y = Starling.current.stage.stageHeight;
		MM.x = 0;
		MM.y = 0;
		switch(state)
		{
			case Menu:
				title = new MenuText(350,100,"Space Cruise");
				title.fontSize = 50;
				title.y = 50;
				addChild(title);

				var play = new MenuButton("Play");
				play.y = title.y + 100;
				play.fontSize = 20;
				play.addEventListener(Event.TRIGGERED,
				function() {
					start();
				});
				addChild(play);

				var instr = new MenuButton("Instructions");
				instr.y = play.y + 100;
				instr.fontSize = 20;
				instr.addEventListener(Event.TRIGGERED,
				function(){	setStage(Instructions);});
				addChild(instr);

				var cred = new MenuButton("Credits");
				cred.y = instr.y + 100;
				cred.fontSize = 20;
				cred.addEventListener(Event.TRIGGERED,
				function(){	setStage(Credits);});
				addChild(cred);

			case Instructions:
				title = new MenuText(200,200,"How To Play");
				title.fontSize = 50;
				title.y = 0;
				addChild(title);

				var back = new MenuButton("Back");
				back.y = title.y + 200;
				back.fontSize = 30;
				back.addEventListener(Event.TRIGGERED,
				function(){ setStage(Menu);});
				addChild(back);

				var instr = new MenuText(400, 400, "Add instructions here");
				instr.fontSize = 18;
				instr.x = Starling.current.stage.stageWidth/2 - instr.width/2;
				instr.y = back.y + 75;
				addChild(instr);

			case Credits:
				var back = new MenuButton("Back");
				back.fontSize = 20; back.y = 50;
				back.addEventListener(Event.TRIGGERED,
				function(){ setStage(Menu);});
				addChild(back);

				var cred = new MenuText(300,300,"Credits\n--------"+
				"\nJordan Harris\nCherie Parsons\nAdd rest of the team member names");
				cred.fontSize = 20;
				cred.y = back.y + 200;
				cred.x = Starling.current.stage.stageWidth/2 - cred.width/2;
				addChild(cred);
		}
	}

	public function start(){
		//var game = new Game(rootSprite);
		//rootSprite.addChild(game);
		playing = true;

	}

	public function getStart():Bool{
		return playing;
	}
}

class MenuText extends TextField
{
	public function new(w:Int,h:Int,s:String)
	{
		super(w,h,s,"Arial",12,0xA00000);
		x = Starling.current.stage.stageWidth/2 - w/2;
		y = Starling.current.stage.stageHeight/2 - h/2;

		addEventListener(Event.ADDED_TO_STAGE, function()
		{
			var tweenx = x;
			x -= 700;
			Starling.juggler.tween(this, 0.25,
			{
				transition: Transitions.LINEAR,
				x : tweenx
			});
		});
	}
}

class MenuButton extends Button
{
	public function new(s:String)
	{
		super(Root.assets.getTexture("Button"));

		x = Starling.current.stage.stageWidth/2 - width/2;
		y = Starling.current.stage.stageHeight/2 - height/2;
		text = s;
		color = 0;
		fontColor = 0xA00000;

		addEventListener(Event.ADDED_TO_STAGE, function()
		{
			var tweenx = x;
			x -= 700;
			Starling.juggler.tween(this, 0.25,
			{
				transition: Transitions.LINEAR,
				x : tweenx
			});
		});
	}
}