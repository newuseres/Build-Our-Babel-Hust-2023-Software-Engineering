extends Node2D
class_name Tower

var floors : Array[FloorBase]
var shop:Shop
var opposite
var finished:bool
var tower_id:int
var father : Game
var seed:int
var rng:RandomNumberGenerator

func turnEnd():
	finished = true
	pass

func getFloor(floorN) -> FloorBase:
	if(floorN >= floors.size()) : return null 
	else : return floors[floorN]
	pass

func getTop() -> FloorBase:
	if(floors.is_empty()) : return null
	else : return floors[floors.size()-1]
	
func getWeak() -> FloorBase:
	if(floors.is_empty()) : return null
	var ret:FloorBase = floors[0]
	for floor in floors:
		if(floor.health < ret.health) : ret = floor
	return ret
	
func getContain() -> FloorBase:
	if(floors.is_empty()) : return null
	var ret:FloorBase = floors[0]
	for floor in floors:
		if(floor.addProductorLimit < ret.addProductorLimit) : ret = floor
	return ret
	
func getProduce() -> FloorBase:
	if(floors.is_empty()) : return null
	var ret:FloorBase = floors[0]
	for floor in floors:
		if(floor.productor if floor.floortype == Globals.FloorType.mine else 0 < 
		ret.productor if ret.floortype == Globals.FloorType.mine else 0) : ret = floor
	return ret

var rigidfloortscn = preload("res://tscns/Rigidfloor.tscn")

func build(floor:FloorBase):
	floor.moreInformation.visible = false
	if floors.is_empty() : floor.z_index = 0
	else : floor.z_index = floors[-1].z_index - 1;
	floors.push_back(floor)
	floor.floorN = floors.size() - 1
	floor.position = Vector2(0,0)
	floor.father = self
	if tower_id == 1:
		floor.textureB.flip_h = true
		
	floor.textureS.scale = Vector2(0.1,0.1)
	floor.textureS.position = Vector2(20,25)
	
	floor.textureB.size = Vector2(200,Globals.FLOOR_HEIGHT)
	print(floor.position)
	#加入碰撞体积
	#floor.remove_child(floor.textureB)
	var rigidtmp = rigidfloortscn.instantiate()
	rigidtmp.add_child(floor)
	floor.rigid = rigidtmp
	rigidtmp.position = Vector2(0,-2000 - floors.size() * Globals.FLOOR_HEIGHT)
	rigidtmp.floor = floor
	add_child(rigidtmp)
	father.refreshMinimap()
	father.semaphs[0].post()
	#rigidtmp.add_child(floor.textureB)
	#add_child(floor)
	pass

func highestActive():
	for floorN in range(floors.size() - 1,-1,-1) :
		if(floors[floorN].active and floors[floorN].alive) :return floors[floorN]
	return null
	pass
	
func produce(produce):
	shop.productor += produce
	shop.productor = min(shop.productor,shop.productorLimit)
	pass
	
func resetActive():
	for floor in floors:
		floor.set_active()
	pass
	
func fallCheck():
	#now unfreeze after wait
	var sumWeight = 0
	var sumDamage = 0
	for floorN in range(floors.size() - 1,-1,-1) :
		if sumDamage > 0 :
			if sumDamage > floors[floorN].health :
				sumDamage -= floors[floorN].health
				floors[floorN].takeDamage(floors[floorN].health, null, Globals.DamageType.gravity)
			else:
				floors[floorN].takeDamage(sumDamage,null , Globals.DamageType.gravity)
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
			shop.productorLimit -= floors[pos].addProductorLimit
			shop.productor = min(shop.productor,shop.productorLimit)
			remove_child(floors[pos].rigid)
			floors[pos].rigid.queue_free() #避免内存泄露,暂时不加入避免bug
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
	rng = RandomNumberGenerator.new()
	rng.seed = seed
	pass # Replace with function body.

func _process(delta):
	pass


