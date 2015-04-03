import starling.text.TextField;

class Counter extends TextField{
	private var counter:Int = 0;

	public function new(){
		super(500, 50, "","font",40);
		this.x = 200;
		this.y = 15;
		this.text = "0/7";
		this.color = 0xFFFFFF;
	}
	public function updateText(){
		counter += 1;
		this.text = counter + "/7";
	}
}