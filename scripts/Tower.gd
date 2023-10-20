extends Node

var floors : Array

func build(floor):
	
	pass

func highestActive():
	pass
	
func attack(attackType, attackPoint):
	pass
	
func produce(produce):
	pass
	
func takeAttack(attackType, attackPoint, attackFloor):
	pass
	
func resetActive():
	pass
	
func fallCheck():
	var sumWeight = 0
	var sumDamage = 0
	for floor in range(floors.size() - 1,-1,-1) :
		if sumDamage > 0 :
			floors[floor].takeDamage(sumDamage)
		if floors[floor]._alive == false :
			sumDamage += sumWeight
			sumWeight = 0
		else:
			sumWeight = sumWeight + floors[floor].weight
	pass
	var pos = 0
	while (true):
		if(pos >= floors.size()) : break
		if(floors[pos]._alive == false) :
			floors.remove_at(pos)
		else : pos += 1
	pass

func turnBegin():
	pass

func winCheck():
	pass



'''
## 塔
商店
层（数组）（类）
建层（牌）
返回最高可行动对象()
受到攻击（攻击力，攻击方式， 攻击方层数）
设置行动状态（）
检查下落（）
回合开始（）//矿工产生金币 打开商店
获胜判断（）
'''
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


