extends GunFloor
class_name CoincidenceFloor

var coincidence : int

func load(id : int,level:int):
	print("load Gunfloor")
	loadbase(id,level)
#	print("id",id,level)
	attackPoint = Pool.floor_attr[id].attackPoint
	coincidence = Pool.floor_attr[id].coincidence
	tempAttackPoint = attackPoint
	moreInformationStr = "攻击力" + str(tempAttackPoint) + "暴击率" +str(coincidence) + "%" 
	pass

func checkBuff():
	checkBuffBase()
	if(father.rng.randi_range(1,100) < coincidence):
		tempAttackPoint += attackPoint * 1
	moreInformationStr = "攻击力" + str(tempAttackPoint) + "暴击率" +str(coincidence) + "%" 
	
func act():
	active = false
	checkBuff()
	if father.opposite.floors.is_empty(): return
	if tempAttackPoint > attackPoint :
		if(father.opposite.getFloor(floorN) == null) :
			tryAttack(father.opposite.getTop(), 1)
		else :
			tryAttack(father.opposite.getFloor(floorN), 1)
	else:
		if(father.opposite.getFloor(floorN) == null) :
			tryAttack(father.opposite.getTop(), 10)
		else :
			tryAttack(father.opposite.getFloor(floorN), 10)
