extends Node2D


# Called when the node enters the scene tree for the first time.
var game : Node2D
func _ready():
	game = $Game
	pass # Replace with function body.


var speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed *= 0.05 ** delta
	
	if(Input.is_action_pressed("keyup")):
		speed += 1000 * delta
	if(Input.is_action_pressed("keydown")):
		speed -= 1000 * delta
	if(Input.is_action_just_pressed("scrollup")):
		speed += 16000 * delta
	if(Input.is_action_just_pressed("scrolldown")):
		speed -= 16000 * delta	
	position += delta * speed * Vector2(0,1)	
		
