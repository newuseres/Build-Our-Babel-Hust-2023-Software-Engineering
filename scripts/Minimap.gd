extends Sprite2D
class_name Minimap

var tempLayer : Node2D
var father0 : Tower
var father1 : Tower
# Called when the node enters the scene tree for the first time.
func updateScreen():
	print("updateScreen")
	remove_child(tempLayer)
	tempLayer.queue_free()
	tempLayer = Node2D.new()
	add_child(tempLayer)
	for floor in father0.floors:
		var block:Sprite2D = Sprite2D.new()
		block.texture = load("res://image/block.png")
		block.scale = Vector2(0.04,0.04)
		block.self_modulate = Color(1.0 - 1.0 * floor.health / floor.maxHealth,1.0 * floor.health / floor.maxHealth ,0)
		block.position = Vector2(-30, 45 - floor.floorN * 4)
		tempLayer.add_child(block)
	for floor in father1.floors:
		var block:Sprite2D = Sprite2D.new()
		block.texture = load("res://image/block.png")
		block.scale = Vector2(0.04,0.04)
		block.self_modulate = Color(1.0 - 1.0 * floor.health / floor.maxHealth,1.0 * floor.health / floor.maxHealth ,0)
		block.position = Vector2(30, 45 - floor.floorN * 4)
		tempLayer.add_child(block)
	print_tree_pretty()

func _ready():
	tempLayer = Node2D.new()
	add_child(tempLayer)	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	pass
