extends Node

var defaultFloor = preload("res://scripts/FloorBase.gd")

func load(id : int,level:int)->FloorBase:
	#print("id:",id)
	var ret:FloorBase
	print(id)
	print(Pool.floor_attr[id].type)
	print(Pool.FloorType.get(Pool.floor_attr[id].type, "unknown"))
	ret = Pool.FloorType.get(Pool.floor_attr[id].type, defaultFloor).new()
	ret.load(id,level)
	return ret
		
	
