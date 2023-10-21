extends "res://scripts/FloorBase.gd"
class_name GunFloor

var attackPoint : int

var attackType : Globals.AttackType
	
func load(id : int,level:int):
	loadbase(id,level)
	print("id",id,level)
	attackPoint = Pool.floor_attr[id].attackPoint
	attackType = Pool.floor_attr[id].attackType
	
	pass

func act():
	active = false
	if get_parent().opposite.floors.is_empty(): return
	match attackType :
		Globals.AttackType.straight:
			if(get_parent().opposite.getFloor(floorN) == null) :
				get_parent().opposite.getTop().takeDamage(attackPoint)
			else :
				get_parent().opposite.getFloor(floorN).takeDamage(attackPoint)
			pass
	pass
