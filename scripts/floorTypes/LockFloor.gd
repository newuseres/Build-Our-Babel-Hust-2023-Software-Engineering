extends GunFloorBase
class_name LockFloor

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	
	var aim:FloorBase
	if(father.opposite.getFloor(floorN) == null) :
		tryAttack(father.opposite.getTop(),7,Globals.DamageType.lock) 
		aim = father.opposite.getTop()
		tryAttack(father.opposite.getFloor(aim.floorN-1),7,Globals.DamageType.lock)
	else :
		tryAttack(father.opposite.getFloor(floorN),2 ) 
		aim = father.opposite.getFloor(floorN)
		tryAttack(father.opposite.getFloor(aim.floorN-1),7,Globals.DamageType.lock)
		tryAttack(father.opposite.getFloor(aim.floorN+1),7,Globals.DamageType.lock)
	pass
	
