extends GunFloor
class_name RageFloor

func load(id : int,level:int):
	print("load Gunfloor")
	loadbase(id,level)
#	print("id",id,level)
	attackPoint = Pool.floor_attr[id].attackPoint
	tempAttackPoint = attackPoint
	moreInformationStr = "攻击力" + str(tempAttackPoint) 
	pass

func checkBuff():
	checkBuffBase()
	var perc:float
	perc = 1.0 * health / maxHealth
	if(perc < 0.1):
		tempAttackPoint += attackPoint
	else :
		if(perc < 0.95):
			tempAttackPoint += attackPoint * (1.0 - perc)
	moreInformationStr = "攻击力" + str(tempAttackPoint)

func act():
	actLikeGunFloor(5)
