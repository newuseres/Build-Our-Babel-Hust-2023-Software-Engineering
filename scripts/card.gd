extends TextureRect
class_name Card

var cardType : int

var val : int

var dest:Vector2

var t = 0.2

var speed = 0.0	
	
func setVectors(size : Vector2, res : Vector2, dest : Vector2):
	self.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
	self.size = size
	self.position = res
	self.dest = dest
	self.speed = (dest - res).length() / t

func setAttr(name : String, resource : String, val : int, cardType : int):
	self.name = name
	self.texture = load(resource)
	self.val = val
	self.cardType = cardType
	

func _ready():
	
	pass



func _process(delta):
	var dist = self.dest - self.position
	if(delta * speed < dist.length()) :
		self.position += delta * speed * dist.normalized()
	else :
		self.position = self.dest
	pass
