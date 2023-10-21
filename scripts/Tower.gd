extends Node

var floors : Array
var shop
var opposite

func getFloor(floorN):
	if(floorN > floors.size()) : return null 
	else : return floors[floorN]
	pass

func getTop():
	return floors[-1]

func build(floor):
	floors.push_back(floor)
	add_child(floor)
	pass

func highestActive():
	for floorN in range(floors.size() - 1,-1,-1) :
		if(floors[floorN].active) :return floors[floorN]
	return null
	pass
	
func produce(produce):
	shop.productor += produce
	pass
	
func resetActive():
	for floor in floors:
		floor.set_active()
	pass
	
func fallCheck():
	var sumWeight = 0
	var sumDamage = 0
	for floorN in range(floors.size() - 1,-1,-1) :
		if sumDamage > 0 :
			floors[floorN].takeDamage(sumDamage)
		if floors[floorN]._alive == false :
			sumDamage += sumWeight
			sumWeight = 0
		else:
			sumWeight = sumWeight + floors[floorN].weight
	pass
	var pos = 0
	while (true):
		if(pos >= floors.size()) : break
		if(floors[pos]._alive == false) :
			floors.remove_at(pos)
		else : pos += 1
	pass

func turnBegin():
	resetActive()
	shop.turnBegin()
	
	pass

func winCheck():
	return floors.size() > Globals.WinFloors
	pass

func paintFloor():
	for floorN in range(0, floors.size()):
		floors[floorN].floorN = floorN
	pass

'''
## 塔
商店
层（数组）（类）
建层（牌）
返回最高可行动对象()
受到攻击（攻击力，攻击方式， 攻击方层数）
设置行动状态（）
检查下落（）
回合开始（）//矿工产生金币 打开商店
获胜判断（）
'''
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


