extends FloorBase

class_name GunFloorBase

var attackPoint : int
var tempAttackPoint : int

func load(id : int,level:int):
	print("load Gunfloor")
	loadbase(id,level)
#	print("id",id,level)
	attackPoint = Pool.floor_attr[id].attackPoint
	tempAttackPoint = attackPoint
	moreInformationStr = "攻击力" + str(tempAttackPoint)
	pass
	
func checkBuff():
	tempAttackPoint = attackPoint
	moreInformationStr = "攻击力" + str(tempAttackPoint)
	
func tryAttack(floor : FloorBase, bulletType = 1, damageType = Globals.DamageType.normal):
	if(floor != null):
		floor.takeDamage(attackPoint,self,damageType)
		makeBulletFly(floor, bulletType) 
