extends Node2D
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

var textureB:TextureButton
var cost:int
var level:int
var id:int
var floorN:int
var ownerPart:int

var floortype : Globals.FloorType

func _ready():
	pass

func relocate():
	position = Vector2(0, -70 -50 * floorN)
	
func loadbase(id:int) :
	alive = true
	active = true
	textureB = TextureButton.new()
	add_child(textureB)
	id = id
	cost = Pool.cost[id]
	textureB.texture_normal = Pool.image[id]
	textureB.ignore_texture_size = true
	textureB.stretch_mode = TextureButton.STRETCH_SCALE
	textureB.size = Vector2(100,100)
	level = Pool.level[id]
	health = Pool.health[id]
	weight = Pool.weight[id]
	floortype = Pool.floorType[id]
	pass
	
func load(id : int):
	pass
	
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
