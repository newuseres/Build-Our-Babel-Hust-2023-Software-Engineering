extends "res://scripts/FloorBase.gd"
class_name MineFloor

var produce : int
	
func load(id : int,level:int):
	loadbase(id,level)
	produce = Pool.floor_attr[id].produce
	pass

func act():
	active = false
	get_parent().produce(produce)
	pass
