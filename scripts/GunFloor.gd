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
	if father.opposite.floors.is_empty(): return
	match attackType :
		Globals.AttackType.straight:
			if(father.opposite.getFloor(floorN) == null) :
				father.opposite.getTop().takeDamage(attackPoint)
			else :
				father.opposite.getFloor(floorN).takeDamage(attackPoint)
			pass
	pass
