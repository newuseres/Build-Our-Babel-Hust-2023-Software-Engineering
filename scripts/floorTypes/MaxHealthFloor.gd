extends GunFloorBase
class_name MaxHealthFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	if(father.opposite.getFloor(floorN) == null) :
		tryAttack(father.opposite.getTop(),6,Globals.DamageType.maxhealth)
	else :
		tryAttack(father.opposite.getFloor(floorN),6,Globals.DamageType.maxhealth)
	pass
