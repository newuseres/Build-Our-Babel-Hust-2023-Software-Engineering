extends GunFloorBase
class_name GunFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	if(father.opposite.getFloor(floorN) == null) :
		tryAttack(father.opposite.getTop(),)
	else :
		tryAttack(father.opposite.getFloor(floorN))
	pass

