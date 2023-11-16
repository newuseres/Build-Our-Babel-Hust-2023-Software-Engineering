extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().playID == 0:
		text = (get_parent().father.ID if get_parent().father != null else "a" )+"(你)\n高度："+str(get_parent().tower0.floors.size())
	else :
		text = (get_parent().father.enemyID if get_parent().father != null else "b")+"(对手)\n高度："+str(get_parent().tower0.floors.size())
	pass
