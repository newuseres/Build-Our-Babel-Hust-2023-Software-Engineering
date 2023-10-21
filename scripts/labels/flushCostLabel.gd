extends Label

class_name flushCostLabel

# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "flushCost:" + String.num_int64(self.get_parent().goldFlushCost)
	pass
