extends GunFloorBase
class_name AimWeakFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	tryAttack(father.opposite.getWeak())
	pass

