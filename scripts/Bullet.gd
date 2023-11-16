extends Sprite2D
class_name Bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.
var velocity:float
#直线从一个地方飞向另一个地方
var from:Vector2
var to:Vector2
var time_all:float
var time_now:float
func straightfly(ffrom:Vector2,tto:Vector2,vv:float,textureType:int = 1):
	texture = load("res://image/bullet/"+String.num_int64(textureType)+".png")
	scale = Vector2(0.5,0.5)
	from = ffrom
	to = tto
	velocity = vv
	if(velocity!=0):
		time_all = (from.distance_to(to))/velocity
	else: time_all = 9999999
	rotate((tto-ffrom).angle())
	time_now = 0;
	self.position = from
	visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if visible == true:
		time_now += delta
		self.position += (delta/time_all) * (to-from)
		if time_now >= time_all:
			self.visible = false

