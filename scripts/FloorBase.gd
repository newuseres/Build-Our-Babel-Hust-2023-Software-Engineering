extends Node
class_name  FloorBase
'''
## 层（基类）
存活状态
行动状态
耐久
重量
贴图（RectTexture）
位置修改
基础价格
受到攻击（攻击力）
'''


var alive:bool
var active:bool
var health:int
var weight:int

var textureRect:TextureRect
var cost:int
var level:int
var id:int
var floorN:int
var ownerPart:int

var floortype : Globals.FloorType

func _ready():
	pass

	
func loadbase(id:int) :
	alive = true
	active = true
	textureRect = TextureRect.new()
	textureRect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
	textureRect.size = Vector2(200,100)	
	add_child(textureRect)
	id = id
	cost = Pool.cost[id]
	textureRect.texture = Pool.image[id]
	level = Pool.level[id]
	health = Pool.health[id]
	weight = Pool.weight[id]
	floortype = Pool.floorType[id]
	pass
	
func load(id : int):
	pass

func set_position(position:Vector2):
	textureRect.set_position(position)
	
func takeDamage(damage : int) -> bool:
	health -= damage
	if(health <= 0):
		alive = false
		return false
	else: return true
	
func act():
	active = false
	pass

func set_active(flag : bool = true):
	active = true
