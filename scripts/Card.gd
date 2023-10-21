extends Node2D
class_name Card

var floor : FloorBase

func click():
	print("click!")
	get_parent().buy(floor)
	pass

func refresh():
	if visible == true :
		floor.free()
	visible = true
	print(get_parent())
	floor = FloorSuper.load(2,get_parent().level)
	add_child(floor)
	floor.textureB.button_down.connect(click)

func _ready():
	visible = false
	refresh()
	
