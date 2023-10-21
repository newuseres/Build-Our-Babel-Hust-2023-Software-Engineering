extends Node
var Tower = preload("res://scripts/Tower.gd")

var tower0
var tower1

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
	

func _ready():
	tower0 = Tower.new()
	tower1 = Tower.new()
	tower0.opposite = tower1
	tower1.opposite = tower0
	
