extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var fatherSize = self.get_parent().size;
	self.position = Vector2(fatherSize.x * 0.6, fatherSize.y * 0.45)
	self.size = Vector2(fatherSize.x * 0.08, fatherSize.y * 0.05)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "sum:" + String.num_int64(self.get_parent().sum) 
	pass
