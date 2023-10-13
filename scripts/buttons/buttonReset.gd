extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = "reset"
	var fatherSize = self.get_parent().size;
	self.position = Vector2(fatherSize.x * 0.4, fatherSize.y * 0.45)
	self.size = Vector2(fatherSize.x * 0.08, fatherSize.y * 0.05)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	self.get_parent().reset()
	pass
