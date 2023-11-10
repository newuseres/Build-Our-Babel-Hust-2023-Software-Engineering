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
var maxHealth:int
var weight:int

var textureB:TextureButton
var cost:int
var originalcost:int#初始cost值
var floorlevel:int = 1
var floorid:int
var floorN:int
var ownerPart:int
var myName:String
var addProductorLimit:int #增加矿工上限

var floortype : Globals.FloorType

var father

var moreInformathionLabel : MoreInformationLabel

var rigid:RigidBody2D

func _ready():
	pass

func relocate():
	position = Vector2(0, -70 - 1500)

func floor_mouse_entered():
	moreInformathionLabel.visible = true
func floor_mouse_exited():
	moreInformathionLabel.visible = false
	
	
func loadbase(id:int,level:int) :
	alive = true
	active = true
	textureB = TextureButton.new()
	moreInformathionLabel = MoreInformationLabel.new()
	z_index = 0
	moreInformathionLabel.z_index = 100000
	add_child(textureB)
	add_child(moreInformathionLabel)
	#读取shop等级
	originalcost = int(Pool.poolAttr["科技等级_"+str(level)+"_建筑等级"+str(Pool.floor_attr[id].floorGrade)+"所需金币"])
	cost = originalcost
	textureB.texture_normal = Pool.floor_attr[id].image
	textureB.ignore_texture_size = true
	textureB.stretch_mode = TextureButton.STRETCH_SCALE
	textureB.size = Vector2(100,100)
	moreInformathionLabel.visible = false
	textureB.mouse_entered.connect(floor_mouse_entered)
	textureB.mouse_exited.connect(floor_mouse_exited)
	floorlevel = Pool.floor_attr[id].floorGrade
	health = Pool.floor_attr[id].health
	maxHealth = health
	weight = Pool.floor_attr[id].weight
	floortype = Pool.floor_attr[id].type
	myName = str(Pool.floor_attr[id].name)
	addProductorLimit = Pool.floor_attr[id].addProductorLimit
	moreInformathionLabel.position = Vector2(0, -50)
	floorid = id
	pass

func load(id : int,level:int):
	pass
	
func takeDamage(damage : int, damageType = Globals.DamageType.normal) -> bool:
	health -= damage
	if(health <= 0):
		alive = false
		return false
	else: return true

func takeHeal(heal : int):
	health = max(health + heal, maxHealth)

func dealthVoice():
	pass
	
func act():
	active = false
	pass

func set_active(flag : bool = true):
	active = true
