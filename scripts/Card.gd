extends Node2D
class_name Card

var floor : FloorBase
var father : Shop
var number : int

func click():
	print("click!")
	if father.buy(number):
		floor.textureB.button_down.disconnect(click)
		floor.moreInformation.scale = Vector2(1,1)
		floor.moreInformation.visible = false
	pass

func refresh(level : int):
	if visible == true :
		floor.free()
	visible = true
	
	floor = FloorSuper.load(Pool.getRand(level, father.father.rng), father.level)
	floor.textureB.button_down.connect(click)
	floor.position = Vector2(50,0)
	add_child(floor)
	floor.father = self;

func _ready():
	visible = false
	#refresh(1)
	
func _process(delta):
	if visible:
		floor.cost = floor.originalcost * (father.penaltyNowRate if father!=null else 1.0 )
		$costLabel.text = "价格:"+ String.num_int64(floor.cost)
		$nameLabel.text =  str(floor.myName)


func _on_button_mouse_entered():
	floor.moreInformation.scale = Vector2(1,0.75)
	floor.moreInformation.visible = true
	pass # Replace with function body.


func _on_button_mouse_exited():
	floor.moreInformation.visible = false	
	pass # Replace with function body.
