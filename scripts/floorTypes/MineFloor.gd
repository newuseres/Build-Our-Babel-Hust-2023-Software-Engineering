extends FloorBase
class_name ResistFloor

var produce : int
	
func load(id : int,level:int):
	loadbase(id,level)
	produce = Pool.floor_attr[id].produce
	pass

func act():
	active = false
	father.produce(produce)
	pass
