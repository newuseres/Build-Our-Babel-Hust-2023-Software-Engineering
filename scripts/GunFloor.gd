extends "res://scripts/FloorBase.gd"
class_name GunFloor

var attackPoint : int

var attackType : Globals.AttackType
	
func load(id : int):
	loadbase(id)
	attackPoint = Pool.attackPoint[id]
	attackType = Pool.attackType[id]
	
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
