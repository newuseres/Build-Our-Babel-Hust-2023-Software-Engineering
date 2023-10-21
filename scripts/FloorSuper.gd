extends Node

var GunFloor = preload("res://scripts/GunFloor.gd")
var MineFloor = preload("res://scripts/MineFloor.gd")

func load(id : int):
	var ret
	match Pool.floorType[id]:
		Globals.FloorType.gun:
			ret = GunFloor.new()
		Globals.FloorType.mine:
			ret = MineFloor.new()
	ret.load(id)
	print(1)
	return ret
		
	
