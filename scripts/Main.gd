extends Node
var Tower = preload("res://scripts/Tower.gd")

var tower0:Tower
var tower1:Tower
var finished:bool = false

func turnBegin():
	tower0.turnBegin()
	tower1.turnBegin()
	
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
	pass
	
var shoptscn = preload("res://tscns/Shop.tscn")
var Cameratscn = preload("res://tscns/Camera.tscn")
func _ready():
	tower0 = Tower.new()
	tower1 = Tower.new()
	tower0.opposite = tower1
	tower1.opposite = tower0
	var Camera = Cameratscn.instantiate()
	add_child(Camera)
	Camera.z_index = -1000
	#Camera.set_script(load("res://tscns/Camera.gd"))
	Camera.game.add_child(tower0)
	Camera.game.add_child(tower1)
	tower0.position = Vector2(100, 650)
	tower1.position = Vector2(1350, 650)
	tower0.shop = shoptscn.instantiate()
	tower0.shop.name = "Shop"
	tower0.shop.father = tower0
	add_child(tower0.shop)
	tower1.shop = shoptscn.instantiate()
	tower1.shop.name = "Shop"
	tower1.shop.father = tower1
	tower0.tower_id = 0
	tower1.tower_id = 1
	add_child(tower1.shop)
	tower0.shop.position = Vector2(100, 600)
	tower1.shop.position = Vector2(100, 750)
	
func _process(delta):
	if finished : return
	if tower0.finished and tower1.finished :
		tower0.finished = 0
		tower1.finished = 0
		allAct()
		await get_tree().create_timer(0.4).timeout
		tower0.allUnfreeze()
		tower1.allUnfreeze()
		var tmpLabel:Label = Label.new()
		
		if tower0.winCheck() and tower1.winCheck() :
			tmpLabel.text = "TIE"
			add_child(tmpLabel)
			finished = true
			return
			
		elif tower0.winCheck() :
			tmpLabel.text = "P0 WIN!"
			add_child(tmpLabel)
			finished = true
			return
		elif tower1.winCheck() :
			tmpLabel.text = "P1 WIN!"
			add_child(tmpLabel)
			finished = true
			return
		tower0.turnBegin()
		tower1.turnBegin()
	pass
	
