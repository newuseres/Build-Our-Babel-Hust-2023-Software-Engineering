extends FloorBase
class_name DieFloor

	
func load(id : int,level:int):
	loadbase(id,level)
	moreInformationStr = "恢复量" + str(int(maxHealth * 0.5))
	pass
	

func dieVoice():
	if(father.getFloor(floorN - 1) != null) :
		father.getFloor(floorN - 1).takeHeal(int(maxHealth * 0.5))
	if(father.getFloor(floorN + 1) != null) :
		father.getFloor(floorN + 1).takeHeal(int(maxHealth * 0.5))
