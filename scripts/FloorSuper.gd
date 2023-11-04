extends Node

var GunFloor = preload("res://scripts/GunFloor.gd")
var MineFloor = preload("res://scripts/MineFloor.gd")

func load(id : int,level:int)->FloorBase:
	#print("id:",id)
	var ret:FloorBase
	match Pool.floor_attr[id].type:
		Globals.FloorType.gun:
			ret = GunFloor.new()
		Globals.FloorType.mine:
			ret = MineFloor.new()
	ret.load(id,level)
	return ret
		
	
