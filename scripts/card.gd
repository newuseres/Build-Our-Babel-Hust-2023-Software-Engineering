extends Node2D

class_name Card

var floor : FloorBase

func click():
	get_parent().buy(floor)
	pass

func _ready():
	floor = FloorSuper.load(0)
	add_child(floor)
