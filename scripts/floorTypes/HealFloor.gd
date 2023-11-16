extends GunFloorBase
class_name HealFloor

func act():
	active = false
	checkBuff()
	if(father.getFloor(floorN - 1) != null) :
		father.getFloor(floorN - 1).takeHeal(tempAttackPoint)
	if(father.getFloor(floorN + 1) != null) :
		father.getFloor(floorN + 1).takeHeal(tempAttackPoint)
	pass
