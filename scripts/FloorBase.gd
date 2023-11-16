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
var buffList:Dictionary

var floortype : String

var father
var MoreInformation = preload("res://tscns/MoreInformation.tscn")

var moreInformation

var rigid:Rigid

var Bullet = preload("res://scripts/Bullet.gd")

func makeBulletFly(dest:FloorBase, BulletType:int = 1):
	var bullet:Bullet = Bullet.new()
	add_child(bullet)
	bullet.straightfly(self.position+Vector2(0,25),
	self.position+Vector2(0,25)+Vector2 ( (750 if self.father.tower_id==0 else -750),-50*(dest.floorN-floorN)) 
	,2000
	,BulletType)

func _ready():
	pass

func relocate():
	return Vector2(0, -70 - floorN * 50)

func floor_mouse_entered():
	moreInformation.visible = true
func floor_mouse_exited():
	moreInformation.visible = false
	
	
func loadbase(id:int,level:int) :
	alive = true
	active = true
	textureB = TextureButton.new()
	moreInformation = MoreInformation.instantiate()
	z_index = 0
	moreInformation.z_index = 1

	add_child(textureB)
	add_child(moreInformation)
	#读取shop等级
	originalcost = Pool.floor_attr[id].cost
	cost = originalcost
	textureB.texture_normal = Pool.floor_attr[id].image
	textureB.ignore_texture_size = true
	textureB.stretch_mode = TextureButton.STRETCH_SCALE
	textureB.size = Vector2(100,100)
	moreInformation.visible = false
	textureB.mouse_entered.connect(floor_mouse_entered)
	textureB.mouse_exited.connect(floor_mouse_exited)
	floorlevel = Pool.floor_attr[id].floorGrade
	health = Pool.floor_attr[id].health
	maxHealth = health
	weight = Pool.floor_attr[id].weight
	floortype = Pool.floor_attr[id].type
	myName = str(Pool.floor_attr[id].name)
	addProductorLimit = Pool.floor_attr[id].addProductorLimit
	moreInformation.position = Vector2(0, -50)
	floorid = id
	pass

func load(id : int,level:int):
	loadbase(id, level)
	pass

func takeDamageBase(damage : int,resource :FloorBase,damageType) -> bool:
	health -= damage
	if(damageType == Globals.DamageType.lock) :
		buffList[Globals.BuffType.lock] = buffList.get(Globals.BuffType.lock,0 )
	if(health <= 0):
		alive = false
		return false
	else: return true
	
func takeDamage(damage : int,resource :FloorBase,damageType = Globals.DamageType.normal) -> bool:
	return takeDamageBase(damage,resource ,damageType)
	
func checkBuff():
	pass

func takeHeal(heal : int):
	if(buffList.get(Globals.BuffType.lock,0 ) > 0 ):
		buffList[Globals.BuffType.lock] -= 1
		return
	health = max(health + heal, maxHealth)

func dealthVoice():
	pass
	
func act():
	active = false
	pass

func set_active(flag : bool = true):
	active = true
