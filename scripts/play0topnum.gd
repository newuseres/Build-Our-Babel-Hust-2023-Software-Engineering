extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().playID == 0:
		text = "玩家0(你)\n高度："+str(get_parent().tower0.floors.size())
	else :
		text = "玩家0(敌人)\n高度："+str(get_parent().tower0.floors.size())
	pass
