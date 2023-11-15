extends Node2D

class_name Rigid

var floor:FloorBase

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var speed : float = 3200
func _process(delta):
	var dist:Vector2 = (floor.relocate() - position)
	if(dist.length() < speed * delta) : 
		position = floor.relocate()
		speed = 800
	else: position += dist.normalized() * speed * delta
	pass
