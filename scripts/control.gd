extends Control

var card = preload("res://scripts/card.gd")

var hand = Array()
var sum:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var t=card.new()
	t.setAttr("deck","res://image/null.jpg" , 0 , 0)
	t.setVectors(Vector2(self.size.x * 0.1 ,self.size.y * 0.20), 
	Vector2(self.size.x * (0.02) ,self.size.y * 0.75), 
	Vector2(self.size.x * (0.02) ,self.size.y * 0.75) )
	add_child(t)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	for child in hand:
		remove_child(child)
	hand.clear()
	sum=0
	
func draw():
	if(sum > 21): return
	var type=randi_range(1,13)
	var file_str = "res://image/"+String.num_int64(type)+".jpg"
	var t=card.new()
	sum = sum + type
	t.setAttr("hand"+String.num(len(hand)), file_str, type, type)
	t.setVectors(Vector2(self.size.x * 0.1 ,self.size.y * 0.20), 
	Vector2(self.size.x * (0.02) ,self.size.y * 0.75), 
	Vector2(self.size.x * (0.12 * len(hand) + 0.2),self.size.y * 0.8) )
	#t.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
	#t.name = "hand"+String.num(len(hand))
	#t.position = Vector2(self.size.x * (0.12 * len(hand) + 0.2),self.size.y * 0.8)
	#t.size = Vector2(self.size.x * 0.1 ,self.size.y * 0.20)
	t.texture = load(file_str)
	hand.push_back(t)
	add_child(t)
