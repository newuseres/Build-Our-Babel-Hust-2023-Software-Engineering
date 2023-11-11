extends Label

class_name MoreInformationLabel

# Called when the node enters the scene tree for the first time.
var father

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	add_theme_color_override("font_color", Color.RED)
	text = "Health:" + String.num_int64(self.father.health)
	text = text+"\n" + "Cost:" + String.num_int64(self.father.cost)
	pass
