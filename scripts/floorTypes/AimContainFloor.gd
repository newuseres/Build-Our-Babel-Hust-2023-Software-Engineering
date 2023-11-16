extends GunFloorBase
class_name AimContainFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	tryAttack(father.opposite.getContain(),12)
	pass

