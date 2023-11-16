extends Sprite2D


# Called when the node enters the scene tree for the first time.
var waitTime : float = -1 

signal timeout

func timeReset():
	waitTime = 90
	
func shutdown():
	waitTime = -1

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(waitTime > 0):
		waitTime -= delta
		if(waitTime <= 0):
			emit_signal("timeout")
			waitTime = -1
		pass
	if(waitTime > 0) :
		self_modulate = Color(1,1,1)
		$Label.text = "回合倒计时:" + str(int(waitTime)) 
		
	else : 
		self_modulate = Color(1,0,0)
		$Label.text = "时间到"
		
	pass
