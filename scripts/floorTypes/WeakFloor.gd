extends GunFloorBase
class_name WeakFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	if(father.opposite.getFloor(floorN) == null) :
		tryAttack(father.opposite.getTop(),11,Globals.DamageType.weak)
	else :
		tryAttack(father.opposite.getFloor(floorN),11,Globals.DamageType.weak)
	pass
