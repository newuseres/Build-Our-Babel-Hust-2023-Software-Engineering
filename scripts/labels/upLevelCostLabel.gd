extends Label

class_name upLevelCostLabel

# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "科技升级消耗:" +	Pool.poolAttr["科技等级_"+str(String.num_int64(self.get_parent().get_parent().level))+ "_科技升级金币"]
