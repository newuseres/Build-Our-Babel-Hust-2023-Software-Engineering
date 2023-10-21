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
var floorlevel:int = 1
var floorid:int
var floorN:int
var ownerPart:int
var myName:String

var floortype : Globals.FloorType

func _ready():
	pass

func relocate():
	position = Vector2(0, -70 -50 * floorN)
	
func loadbase(id:int,level:int) :
	alive = true
	active = true
	textureB = TextureButton.new()
	add_child(textureB)
	#读取shop等级
	cost = int(Pool.poolAttr["科技等级_"+str(level)+"_建筑等级"+str(Pool.floor_attr[id].floorGrade)+"所需金币"])
	textureB.texture_normal = Pool.floor_attr[id].image
	textureB.ignore_texture_size = true
	textureB.stretch_mode = TextureButton.STRETCH_SCALE
	textureB.size = Vector2(100,100)
	floorlevel = Pool.floor_attr[id].floorGrade
	health = Pool.floor_attr[id].health
	weight = Pool.floor_attr[id].weight
	floortype = Pool.floor_attr[id].type
	myName = str(Pool.floor_attr[id].name)
	floorid = id
	pass

func load(id : int,level:int):
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
