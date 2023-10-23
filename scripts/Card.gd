extends Node2D
class_name Card

var floor : FloorBase

func click():
	print("click!")
	get_parent().buy(floor)
	floor.textureB.button_down.disconnect(click)
	remove_child(floor.moreInformathionLabel)
	pass

func refresh(level : int):
	if visible == true :
		floor.free()
	visible = true
	print(get_parent())
	
	floor = FloorSuper.load(Pool.getRand(level), get_parent().level)
	add_child(floor)
	floor.textureB.button_down.connect(click)

func _ready():
	visible = false
	refresh(1)
	
