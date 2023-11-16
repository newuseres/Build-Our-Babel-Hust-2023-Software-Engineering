extends GunFloorBase

class_name AttakAboveFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	var tmpFloor = floorN + 1
	while (father.opposite.getFloor(tmpFloor) != null) :
		tryAttack(father.opposite.getTop(),4)
		tmpFloor += 1
	pass
