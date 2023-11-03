extends Node2D
class_name Card

var floor : FloorBase
var father : Shop

func click():
	print("click!")
	father.buy(floor)
	floor.textureB.button_down.disconnect(click)
	remove_child(floor.moreInformathionLabel)
	pass

func refresh(level : int):
	if visible == true :
		floor.free()
	visible = true
	
	floor = FloorSuper.load(Pool.getRand(level), get_parent().level)
	add_child(floor)
	floor.father = self;
	floor.textureB.button_down.connect(click)

func _ready():
	visible = false
	refresh(1)
	
