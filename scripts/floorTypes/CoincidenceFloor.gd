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
	if(father.rng.randi_range(1,100) < coincidence):
		tempAttackPoint = attackPoint*3
	else:
		tempAttackPoint = attackPoint
	moreInformationStr = "攻击力" + str(tempAttackPoint) + "暴击率" +str(coincidence) + "%" 
