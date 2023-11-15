extends Node
class_name Game
var Tower = preload("res://scripts/Tower.gd")

var finished:bool = false

var tower0:Tower 
var tower1:Tower 
var towerEnemy:Tower
var playID:int#玩家ID
var seed0:int
var seed1:int
var father:NetworkMain

func turnBegin():
	tower0.turnBegin()
	tower1.turnBegin()
	
var tmpShop:int = 0 #测试用
var prior = 0
	
func allAct():
	while(true):
		tower0.paintFloor()
		tower1.paintFloor()
		if(tower0.highestActive() == null and tower1.highestActive() == null):
			break
		if(tower0.highestActive() == null):
			tower1.highestActive().act()
		elif(tower1.highestActive() == null):
			tower0.highestActive().act()
		elif(tower0.highestActive().floorN == tower1.highestActive().floorN):
			if(prior == 0):
				tower0.highestActive().act()
				prior = 1
			else:
				tower1.highestActive().act()
				prior = 0
		elif(tower0.highestActive().floorN > tower1.highestActive().floorN):
			tower0.highestActive().act()
		elif(tower0.highestActive().floorN < tower1.highestActive().floorN):
			tower1.highestActive().act()
		tower0.fallCheck()
		tower1.fallCheck()
		await get_tree().create_timer(0.1).timeout
	pass
	
var shoptscn = preload("res://tscns/Shop.tscn")
var Cameratscn = preload("res://tscns/Camera.tscn")

func enemyAct(message:Dictionary):
	if(message["op"] == "buy"):
		towerEnemy.shop.buy(message["number"], true)
	if(message["op"] == "levelup"):
		towerEnemy.shop._on_button_up_level_pressed(true)
	if(message["op"] == "refresh"):
		towerEnemy.shop._on_button_refresh_pressed(true)
	if(message["op"] == "turnend"):
		towerEnemy.shop._on_button_finish_pressed(true)
	pass

func _ready():
	tower0 = Tower.new()
	tower1 = Tower.new()
	tower0.finished = true
	tower1.finished = true
	tower0.opposite = tower1
	tower1.opposite = tower0
	var Camera = Cameratscn.instantiate()
	add_child(Camera)
	Camera.z_index = -1000
	#Camera.set_script(load("res://tscns/Camera.gd"))
	tower0.position = Vector2(300, 650)
	tower1.position = Vector2(1050, 650)
	tower0.seed = seed0
	tower1.seed = seed1
	
	tower0.shop = shoptscn.instantiate()
	tower0.shop.name = "Shop"
	tower0.shop.father = tower0
	tower0.father = self
	tower0.tower_id = 0
	add_child(tower0.shop)
	
	tower1.shop = shoptscn.instantiate()
	tower1.shop.name = "Shop"
	tower1.shop.father = tower1
	tower1.father = self
	tower1.tower_id = 1
	add_child(tower1.shop)
	
	$Minimap.father0 = tower0
	$Minimap.father1 = tower1
	
	if playID == 0:
		tower1.shop.visible = false
		towerEnemy = tower1
	else:
		tower0.shop.visible = false
		towerEnemy = tower0
	tower0.shop.position = Vector2(300, 500)
	tower1.shop.position = Vector2(300, 500)
	Camera.game.add_child(tower0)
	Camera.game.add_child(tower1)


func refreshMinimap():
	$Minimap.updateScreen()

func _process(delta):
	if finished : return
	if tower0.finished and tower1.finished :
		tower0.finished = 0
		tower1.finished = 0
		await get_tree().create_timer(2).timeout
		
		allAct()
		
		await get_tree().create_timer(0.5).timeout
		
		tower0.allUnfreeze()
		tower1.allUnfreeze()
		
		await get_tree().create_timer(0.5).timeout
		
		if tower0.winCheck() and tower1.winCheck() :
			
			get_tree().change_scene_to_file("res://tscns/Begin.tscn")
			finished = true
			return
			
		elif tower0.winCheck() :
			
			get_tree().change_scene_to_file("res://tscns/Begin.tscn")
			finished = true
			return
		elif tower1.winCheck() :
			
			get_tree().change_scene_to_file("res://tscns/Begin.tscn")
			finished = true
			return
		tower0.turnBegin()
		tower1.turnBegin()
		$Minimap.updateScreen()
	pass
	


func _on_button_pressed():
	tmpShop = tmpShop^1
	$Button/Label.text = "当前"+str(tmpShop)
	if tmpShop == 0:
		tower0.shop.visible = true
		tower1.shop.visible = false
	else:
		tower0.shop.visible = false
		tower1.shop.visible = true
			
	pass # Replace with function body.


func _on_一键多金_pressed():
	if tmpShop == 0:
		tower0.shop.gold += 10000000
	else:
		tower1.shop.gold += 10000000
	pass # Replace with function body.
