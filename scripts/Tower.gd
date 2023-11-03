extends Node2D
class_name Tower

var floors : Array[FloorBase]
var shop:Shop
var opposite
var finished

func getFloor(floorN):
	if(floorN >= floors.size()) : return null 
	else : return floors[floorN]
	pass

func getTop():
	if(floors.is_empty()) : return null
	else : return floors[floors.size()-1]

var rigidfloortscn = preload("res://tscns/Rigidfloor.tscn")	
func build(floor:FloorBase):
	allUnfreeze()
	floor.moreInformathionLabel.visible = false
	if floors.is_empty() : floor.z_index = 0
	else : floor.z_index = floors[-1].z_index - 1;
	floors.push_back(floor)
	floor.floorN = floors.size() - 1
	floor.position = Vector2(0,0)
	floor.father = self
	floor.textureB.size = Vector2(50,50)
	print(floor.position)
	#加入碰撞体积
	#floor.remove_child(floor.textureB)
	var rigidtmp:RigidBody2D = rigidfloortscn.instantiate()
	rigidtmp.add_child(floor)
	floor.rigid = rigidtmp
	rigidtmp.position = Vector2(0,-1500)
	add_child(rigidtmp)
	#rigidtmp.add_child(floor.textureB)
	#add_child(floor)
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
	allUnfreeze()
	var sumWeight = 0
	var sumDamage = 0
	for floorN in range(floors.size() - 1,-1,-1) :
		if sumDamage > 0 :
			if sumDamage > floors[floorN].health :
				sumDamage -= floors[floorN].health
				floors[floorN].takeDamage(floors[floorN].health)
			else:
				floors[floorN].takeDamage(sumDamage)
				sumDamage = 0
		if floors[floorN].alive == false :
			sumDamage += sumWeight
			sumWeight = 0
		else:
			sumWeight = sumWeight + floors[floorN].weight
	pass
	var pos = 0
	while (true):
		if(pos >= floors.size()) : break
		if(floors[pos].alive == false) :
			#floors[pos].remove_child(floors[pos].find_child("rigidtmp"))
			remove_child(floors[pos].rigid)
			floors.remove_at(pos)
		else : pos += 1
	pass
#玩家的turn_begin
func turnBegin():
	resetActive()
	shop.turnBegin()
	finished = false
	pass

func winCheck():
	return floors.size() > Globals.WinFloors
	pass

func paintFloor():
	for floorN in range(0, floors.size()):
		floors[floorN].floorN = floorN
	pass
	
var warmTime = 0

func allFreeze():
	for floorN in range(0, floors.size()):
		floors[floorN].rigid.freeze = true
	pass
	
func allUnfreeze():
	print("sleep")
	warmTime = 3.0
	for floorN in range(0, floors.size()):
		floors[floorN].rigid.freeze = false
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

func _process(delta):
	if(warmTime > 0) :
		warmTime -= delta
		if(warmTime <= 0) : allFreeze()


