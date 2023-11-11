extends Node2D


# Called when the node enters the scene tree for the first time.
var father
func _ready():
	$Label.father = get_parent()
	father = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$healthbar.value = (100.0 * father.health/father.maxHealth)
	pass
