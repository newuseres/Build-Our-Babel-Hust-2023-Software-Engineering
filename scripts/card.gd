extends Node

class_name Card

var floor

func click():
	get_parent().buy(floor)
	pass
