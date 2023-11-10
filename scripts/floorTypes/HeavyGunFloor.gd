extends "res://scripts/FloorBase.gd"
class_name HeavyGunFloor

var attackPoint : int
	
func load(id : int,level:int):
	print("load HeavyGunFloor")
	loadbase(id,level)
#	print("id",id,level)
	attackPoint = Pool.floor_attr[id].attackPoint
	
	pass

func act():
	active = false
	if father.opposite.floors.is_empty(): return
#	var main = father.get_parent()


	var aim:FloorBase
	if(father.opposite.getFloor(floorN) == null) :
		father.opposite.getTop().takeDamage(attackPoint,self)
		makeBulletFly(father.opposite.getTop())
		aim = father.opposite.getTop()
		if aim.floorN > 0:
			father.opposite.getFloor(aim.floorN-1).takeDamage(attackPoint,self)
			makeBulletFly(father.opposite.getFloor(aim.floorN-1),2)
	else :
		father.opposite.getFloor(floorN).takeDamage(attackPoint,self)
		makeBulletFly(father.opposite.getFloor(floorN),2)
		aim = father.opposite.getTop()
		if father.opposite.getFloor(aim.floorN-1) != null:
			father.opposite.getFloor(aim.floorN-1).takeDamage(attackPoint,self)
			makeBulletFly(father.opposite.getFloor(aim.floorN-1),2)
		if father.opposite.getFloor(aim.floorN+1) != null:
			father.opposite.getFloor(aim.floorN+1).takeDamage(attackPoint,self)
			makeBulletFly(father.opposite.getFloor(aim.floorN+1),2)


