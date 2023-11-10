extends FloorBase
class_name MineFloor
#重力反伤
var produce : int
	
func load(id : int,level:int):
	loadbase(id,level)
	produce = Pool.floor_attr[id].produce
	pass

func takeDamage(damage : int,resource :FloorBase,damageType = Globals.DamageType.normal):
	if takeDamage(damage,resource,damageType) :
		if(resource != null) : resource.takeDamage(weight, null, Globals.DamageType.gravity)
		return true
	else : return false

func act():
	active = false
	father.produce(produce)
	pass
