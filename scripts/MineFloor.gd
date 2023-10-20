extends "res://scripts/FloorBase.gd"
class_name MineFloor

var produce : int
	
func load(id : int):
	loadbase(id)
	produce = Pool.produce[id]
	pass

func act():
	get_parent().produce(produce)
	pass
