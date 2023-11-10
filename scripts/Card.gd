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
	floor.cost = floor.originalcost * (father.penaltyNowRate if father!=null else 1.0 )
	floor.textureB.button_down.connect(click)
	$Label.text = "COST:"+ String.num_int64(floor.cost)

func _ready():
	visible = false
	refresh(1)
	
