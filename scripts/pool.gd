extends Node
#类型	攻击力	生产力	耐久度	重量	攻击方式	等级	贴图名称
class for_floor_attr extends Object: 
	var name:String
	var type:String
	var description:String
	var attackPoint:int
	var produce:int
	var health:int
	var weight:int
	var floorGrade:int
	var image
	var addProductorLimit:int
	var cost:int
	var coincidence:int #突发事件概率

var floor_attr:Dictionary
var poolAttr:Dictionary
var refreshRate:Array[Array]
var levelfloor:Array[Array]
var FloorType:Dictionary


func load_floor(pos:String):
	var file = FileAccess.open(pos,FileAccess.READ)
	var temp = file.get_csv_line(",")
	var keys = []
	for i in temp:
		keys.push_back(i)
	temp = file.get_csv_line(",")
	var now_id = 0
	while temp.size()>1:
		now_id += 1
		floor_attr[now_id] = for_floor_attr.new()
		for idx in range(temp.size()):
			if keys[idx] == "名称":
				floor_attr[now_id].name = str(temp[idx])
			elif keys[idx] == "类型":
				floor_attr[now_id].type = str(temp[idx])
			elif keys[idx] == "攻击力":
				floor_attr[now_id].attackPoint = int(temp[idx])
			elif keys[idx] == "生产力":
				floor_attr[now_id].produce=int(temp[idx])
			elif keys[idx] == "耐久度":
				floor_attr[now_id].health = int(temp[idx])
			elif keys[idx] == "重量":
				floor_attr[now_id].weight = int(temp[idx])
			elif keys[idx] == "等级":
				floor_attr[now_id].floorGrade =int(temp[idx])
				levelfloor[int(temp[idx])].push_back(now_id)
			elif keys[idx] == "贴图名称":
				floor_attr[now_id].image = load("res://image/floor/"+"炮台-"+str(temp[idx])+".png")
			elif keys[idx] == "增加矿工上限":
				floor_attr[now_id].addProductorLimit = int(temp[idx])
			elif keys[idx] == "价格":
				floor_attr[now_id].cost = int(temp[idx])
			elif keys[idx] == "描述":
				floor_attr[now_id].description = str(temp[idx])
			elif keys[idx] == "概率":
				floor_attr[now_id].coincidence = int(temp[idx])
				
		temp = file.get_csv_line(",")
	file.close()

func load_relation_database(pos:String):
	var file = FileAccess.open(pos,FileAccess.READ)
	var temp = file.get_csv_line(",")
	var keys = []
	#第一行的key
	for i in temp:
		keys.push_back(i)
	temp = file.get_csv_line(",")
	var nowlevel:int = 0
	while temp.size() > 1:
		nowlevel+=1
		for idx in range(temp.size()):
			if idx == 0: 
				continue
			poolAttr["科技等级_"+str(nowlevel)+"_"+keys[idx]] = temp[idx]
			print("科技等级_"+str(nowlevel)+"_"+keys[idx])
		temp = file.get_csv_line(",")
	file.close()

func load_kv_database(pos:String):
	var file = FileAccess.open(pos,FileAccess.READ)
	var temp = file.get_csv_line(",")
	while temp.size() > 1:
		poolAttr[temp[0]] = temp[1]
		temp = file.get_csv_line(",")
	file.close()
	
func load_refresh_rates(pos:String):
	var file = FileAccess.open(pos,FileAccess.READ)
	var temp = file.get_csv_line(",")
	var keys = []
	#第一行的key
	for i in temp:
		keys.push_back(i)
	temp = file.get_csv_line(",")
	var nowlevel:int = 0
	while temp.size() > 1:
		for idx in range(temp.size()):
			refreshRate[int(temp[0])].push_back( float(temp[idx]) )
		temp = file.get_csv_line(",")
	file.close()

func load_floor_type(pos:String):
	var file = FileAccess.open(pos,FileAccess.READ)
	var temp = file.get_csv_line(",")
	while temp.size() > 1:
		print(temp[0], "res://scripts/floorTypes/"+temp[0]+".gd")
		FloorType[temp[0]] = load("res://scripts/floorTypes/"+temp[0]+".gd")
		temp = file.get_csv_line(",")
	file.close()	
	pass

func loadall():
	floor_attr = {}
	poolAttr = {}
	refreshRate = [[],[],[],[],[],[],[]]
	levelfloor = [[],[],[],[],[],[],[]]
	load_relation_database("res://database/经济.csv")
	load_kv_database("res://database/初始设置.csv")
	load_floor("res://database/建筑数值（随机从80%~120%波动鼓励刷新）.csv")
	load_refresh_rates("res://database/商店刷新概率.csv")
	load_floor_type("res://database/类型名称.csv")
	pass
	
func getRand(level : int, rng : RandomNumberGenerator) -> int:
	var seed : float = rng.randf()
	for objLevel in range(1, 7) :
		if seed < refreshRate[level][objLevel]:
			return levelfloor[objLevel][rng.randi_range(0, levelfloor[objLevel].size() - 1)]
		else : seed -= refreshRate[level][objLevel]
	return 0
func _ready():
	loadall()
	pass
