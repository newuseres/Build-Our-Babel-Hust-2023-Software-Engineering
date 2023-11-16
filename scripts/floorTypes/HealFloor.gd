extends GunFloorBase
class_name LockFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	if(father.opposite.getFloor(floorN) == null) :
		tryAttack(father.opposite.getTop(),Globals.DamageType.lock)
	else :
		tryAttack(father.opposite.getFloor(floorN),Globals.DamageType.lock)
	pass

