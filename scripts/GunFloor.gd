extends "res://scripts/FloorBase.gd"
class_name GunFloor

var attackPoint : int

var attackType : Globals.AttackType
	
func load(id : int,level:int):
	loadbase(id,level)
#	print("id",id,level)
	attackPoint = Pool.floor_attr[id].attackPoint
	attackType = Pool.floor_attr[id].attackType
	
	pass

var Bullet = preload("res://scripts/Bullet.gd")

func makeBulletFly(dest:FloorBase, BulletType:int = 1):
	var bullet:Bullet = Bullet.new()
	add_child(bullet)
	bullet.straightfly(self.position+Vector2(0,25),
	self.position+Vector2(0,25)+Vector2 ( (1250 if self.father.tower_id==0 else -1250),-50*(dest.floorN-floorN)) 
	,3000
	,BulletType)
	pass

func act():
	active = false
	if father.opposite.floors.is_empty(): return
	var main = father.get_parent()
	match attackType :
		Globals.AttackType.straight:
			if(father.opposite.getFloor(floorN) == null) :
				father.opposite.getTop().takeDamage(attackPoint)
				makeBulletFly(father.opposite.getTop())
			else :
				father.opposite.getFloor(floorN).takeDamage(attackPoint)
				makeBulletFly(father.opposite.getFloor(floorN))
			
			pass
		Globals.AttackType.blow:
			var aim:FloorBase
			if(father.opposite.getFloor(floorN) == null) :
				father.opposite.getTop().takeDamage(attackPoint)
				makeBulletFly(father.opposite.getTop())
				aim = father.opposite.getTop()
				if aim.floorN > 0:
					father.opposite.getFloor(aim.floorN-1).takeDamage(attackPoint)
					makeBulletFly(father.opposite.getFloor(aim.floorN-1))
			else :
				father.opposite.getFloor(floorN).takeDamage(attackPoint)
				makeBulletFly(father.opposite.getFloor(floorN))
				aim = father.opposite.getTop()
				if father.opposite.getFloor(aim.floorN-1) != null:
					father.opposite.getFloor(aim.floorN-1).takeDamage(attackPoint)
					makeBulletFly(father.opposite.getFloor(aim.floorN-1))
				if father.opposite.getFloor(aim.floorN+1) != null:
					father.opposite.getFloor(aim.floorN+1).takeDamage(attackPoint)
					makeBulletFly(father.opposite.getFloor(aim.floorN+1))
			pass
	pass
