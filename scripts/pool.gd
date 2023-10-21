extends Node

var cost : Dictionary
var level : Dictionary
var health : Dictionary
var weight : Dictionary
var attackPoint : Dictionary
var produce : Dictionary
var image : Dictionary
var attackType : Dictionary
var floorType : Dictionary

func loadone():
	cost[0]=1
	level[0]=2
	health[0]=3
	weight[0]=4
	attackPoint[0]=5
	produce[0]=6
	image[0]=(preload("res://image/1.jpg"))
	attackType[0]=1
	floorType[0]=1
	pass

func _ready():
	loadone()
	pass
