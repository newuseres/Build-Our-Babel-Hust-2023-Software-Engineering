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
	
func checkBuffBase():
	tempAttackPoint = attackPoint
	if(buffList.get(Globals.BuffType.weak, 0) > 0 ): 
		buffList[Globals.BuffType.weak] = buffList.get(Globals.BuffType.weak, 0) - 1
		tempAttackPoint = int (tempAttackPoint * 0.6)
	

func checkBuff():
	checkBuffBase()
	moreInformationStr = "攻击力" + str(tempAttackPoint)
	
func tryAttack(floor : FloorBase, bulletType = 1, damageType = Globals.DamageType.normal):
	if(floor != null):
		floor.takeDamage(tempAttackPoint,self,damageType)
		makeBulletFly(floor, bulletType) 
