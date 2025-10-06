extends GunFloorBase
class_name WeakFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	
	var aim:FloorBase
	if(father.opposite.getFloor(floorN) == null) :
		tryAttack(father.opposite.getTop(),11,Globals.DamageType.weak)
		aim = father.opposite.getTop()
		tryAttack(father.opposite.getFloor(aim.floorN-1),11,Globals.DamageType.weak)
	else :
		tryAttack(father.opposite.getFloor(floorN),11,Globals.DamageType.weak)
		aim = father.opposite.getFloor(floorN)
		tryAttack(father.opposite.getFloor(aim.floorN-1),11,Globals.DamageType.weak)
		tryAttack(father.opposite.getFloor(aim.floorN+1),11,Globals.DamageType.weak)
	pass
