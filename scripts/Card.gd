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
	floor = FloorSuper.load(0)
	add_child(floor)	
	floor.textureB.button_down.connect(click)

func _ready():
	visible = false
	refresh()
	
