extends GunFloorBase
class_name HeavyGunFloor

	
func load(id : int,level:int):
	print("load HeavyGunFloor")
	loadbase(id,level)
#	print("id",id,level)
	attackPoint = Pool.floor_attr[id].attackPoint
	
	pass

func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
#	var main = father.get_parent()

	var aim:FloorBase
	if(father.opposite.getFloor(floorN) == null) :
		tryAttack(father.opposite.getTop(),2 ) 
		aim = father.opposite.getTop()
		tryAttack(father.opposite.getFloor(aim.floorN-1),2 )
	else :
		tryAttack(father.opposite.getFloor(floorN),2 ) 
		aim = father.opposite.getFloor(floorN)
		tryAttack(father.opposite.getFloor(aim.floorN-1),2 ) 
		tryAttack(father.opposite.getFloor(aim.floorN+1),2 ) 



