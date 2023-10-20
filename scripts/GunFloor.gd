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
	get_parent().attack(attackType, attackPoint)
	
	pass
