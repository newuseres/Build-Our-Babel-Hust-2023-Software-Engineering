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
	tempAttackPoint = attackPoint * (2.0 -1.0 * health / maxHealth)
	moreInformationStr = "攻击力" + str(tempAttackPoint)
