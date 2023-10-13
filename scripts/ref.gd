extends Control

# Called when the node enters the scene tree for the first time.
var textbox : TextEdit;
var button;
func _ready():
	button = Button.new()
	button.text = "Click me"
	button.pressed.connect(self._button_pressed)
	button.set_anchor(SIDE_TOP,0.4)
	button.set_anchor(SIDE_LEFT,0.4)
	button.set_anchor(SIDE_RIGHT,0.6)
	button.set_anchor(SIDE_BOTTOM,0.6)
	add_child(button)
	#textbox = TextEdit.new();
	#textbox.placeholder_text="123";
	#add_child(textbox);
var tt=0.0

var hand = Array()
	
func _button_pressed():
	button.text = "Don't click me!"
	tt=1.0

	const handnum:int = 5
	for child in hand :
		remove_child(child)
	for i in range(handnum):
		var type=randi_range(1,13)
		var file_str = "res://image/"+String.num_int64(type)+".jpg"
		var t=TextureRect.new()
		t.name = "hand"+String.num(i)
		t.set_anchor(SIDE_TOP,0)
		t.set_anchor(SIDE_LEFT,0)
		t.position = Vector2(0 + 120 * i,0)
		t.size=Vector2(100,150)
		t.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		t.texture = load(file_str)
		hand.push_back(t)
		add_child(t)
	pass

	

	
func _process(delta):
	tt-=delta
	if(tt<0):
		button.text = "Click me"
