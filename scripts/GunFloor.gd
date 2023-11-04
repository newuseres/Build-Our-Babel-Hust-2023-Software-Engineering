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
func act():
	active = false
	if father.opposite.floors.is_empty(): return
	var bullet:Bullet
	var main = father.get_parent()
	match attackType :
		Globals.AttackType.straight:
			bullet = Bullet.new()
			if(father.opposite.getFloor(floorN) == null) :
				father.opposite.getTop().takeDamage(attackPoint)
				add_child(bullet)
				bullet.straightfly(self.position+Vector2(0,25),self.position+Vector2(0,25)+Vector2 ( (1250 if self.father.tower_id==0 else -1250),-50*(father.opposite.getTop().floorN-floorN)) ,3000)
			#	await get_tree().create_timer(1.0).timeout
				
			else :
				father.opposite.getFloor(floorN).takeDamage(attackPoint)
				add_child(bullet)
				bullet.straightfly(self.position+Vector2(0,25),self.position+Vector2(0,25)+Vector2 ( (1250 if self.father.tower_id==0 else -1250),0) ,3000)
			#	await get_tree().create_timer(1.0).timeout
			pass
	pass
