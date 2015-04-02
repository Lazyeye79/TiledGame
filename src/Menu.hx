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
		addChild(MM);
		MM.x = 0;
		MM.y = 0;
		switch(state)
		{
			case Menu:
				title = new MenuText(350,100,"Space Cruise");
				title.fontSize = 45;
				title.y = 300;
				addChild(title);

				var play = new MenuButton("Play");
				play.y = title.y + title.height + 50;
				play.x = (Starling.current.stage.stageWidth - play.width * 3)/2;
				play.fontSize = 20;
				play.addEventListener(Event.TRIGGERED,
				function() {
					start();
				});
				addChild(play);

				var instr = new MenuButton("Instructions");
				instr.y = play.y;
				//instr.x = play.x + play.width;
				instr.fontSize = 20;
				instr.addEventListener(Event.TRIGGERED,
				function(){	setStage(Instructions);});
				addChild(instr);

				var cred = new MenuButton("Credits");
				cred.y = play.y;
				cred.x = cred.x + cred.width;
				cred.fontSize = 20;
				cred.addEventListener(Event.TRIGGERED,
				function(){	setStage(Credits);});
				addChild(cred);

			case Instructions:
				title = new MenuText(300,75,"How To Play");
				title.fontSize = 45;
				title.y = 300;
				addChild(title);

				var instr = new MenuText(350, 200, "Move the 'Ship' with WASD or Arrow Keys. Collect the missing space passengers while avoiding the asteroids scattered about. But don't forget to watch your fuel.");
				instr.fontSize = 18;
				instr.x = Starling.current.stage.stageWidth/2 - instr.width/2;
				instr.y = title.y + title.height/2;
				addChild(instr);

				var back = new MenuButton("Back");
				back.fontSize = 30;
				back.y = instr.y + instr.height;
				back.addEventListener(Event.TRIGGERED,
				function(){ setStage(Menu);});
				addChild(back);

			case Credits:
				title = new MenuText(350,75,"We Made This");
				title.fontSize = 45;
				title.y = 300;
				addChild(title);

				var cred = new MenuText(300,200,"Credits\n--------"+
				"\nJordan Harris\tCherie Parsons\nErin Bailey\tTeam Member\nTeam Member\tTeam Member");
				cred.fontSize = 20;
				cred.y = title.y + title.height/2;
				cred.x = Starling.current.stage.stageWidth/2 - cred.width/2;
				addChild(cred);
				
				var back = new MenuButton("Back");
				back.fontSize = 30;
				back.y = cred.y + cred.height;
				back.addEventListener(Event.TRIGGERED,
				function(){ setStage(Menu);});
				addChild(back);
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
			x += 700;
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