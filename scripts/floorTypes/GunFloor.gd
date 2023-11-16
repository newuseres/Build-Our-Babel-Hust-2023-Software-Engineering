extends GunFloorBase
class_name GunFloor

func actLikeGunFloor(bulletType : int):
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	if(father.opposite.getFloor(floorN) == null) :
		tryAttack(father.opposite.getTop(), bulletType)
	else :
		tryAttack(father.opposite.getFloor(floorN), bulletType)	

func act():
	actLikeGunFloor(8)
	pass

