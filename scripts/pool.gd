extends Node

var cost : Array
var level : Array
var health : Array
var weight : Array
var attackPoint : Array
var produce : Array
var image : Array
var attackType : Array
var floorType : Array

func loadone():
	cost.push_back(1)
	level.push_back(2)
	health.push_back(3)
	weight.push_back(4)
	attackPoint.push_back(5)
	produce.push_back(6)
	image.push_back(preload("res://image/1.jpg"))
	attackType.push_back(1)
	floorType.push_back(1)
	pass

func _ready():
	loadone()
	pass
