extends FloorBase

class_name GunFloorBase

var attackPoint : int
var tempAttackPoint : int

func checkBuff():
	tempAttackPoint = attackPoint
	
func tryAttack(floor : FloorBase, bulletType = 1, damageType = Globals.DamageType.normal):
	if(floor != null):
		floor.takeDamage(attackPoint,self,damageType)
		makeBulletFly(floor, bulletType) 
