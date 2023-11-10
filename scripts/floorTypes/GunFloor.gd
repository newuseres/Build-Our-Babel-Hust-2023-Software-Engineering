extends FloorBase
class_name GunFloor

var attackPoint : int
	
func load(id : int,level:int):
	print("load Gunfloor")
	loadbase(id,level)
#	print("id",id,level)
	attackPoint = Pool.floor_attr[id].attackPoint
	
	pass

func act():
	active = false
	if father.opposite.floors.is_empty(): return
	if(father.opposite.getFloor(floorN) == null) :
		father.opposite.getTop().takeDamage(attackPoint,self)
		makeBulletFly(father.opposite.getTop())
	else :
		father.opposite.getFloor(floorN).takeDamage(attackPoint,self)
		makeBulletFly(father.opposite.getFloor(floorN))
	pass

