extends Node2D

class_name Shop
'''
## 商店场景
牌(*3)
刷新（）
打开（）
升级科技（）
惩罚系数
科技等级
矿工
金币
'''

var gold:int = 999
var goldFlushCost:int = 40 #每次刷新金币消耗
var penaltyCoefficient:float = 2#刷新惩罚系数
var penaltyNowRate:float = 1#当前的购买惩罚系数
var penaltyBuy:float#购买的惩罚倍率

var level:int = 1

var productor:int
var productorLimit:int#矿工上限
var father:Tower


func refresh():
	$Card0.refresh(level)
	$Card1.refresh(level)
	$Card2.refresh(level)
	pass

func buy(floornow:FloorBase):
	if(gold < floornow.cost) : return
	gold -= floornow.cost
	penaltyNowRate = penaltyNowRate * penaltyBuy
	productorLimit += floornow.addProductorLimit
	var card = floornow.get_parent()
	card.remove_child(floornow)
	card.visible = false
	'''
	#calc twice
	if($Card0.floor!=null):
		$Card0.floor.cost = int($Card0.floor.cost*penaltyNowRate)
	if($Card1.floor!=null):
		$Card1.floor.cost = int($Card1.floor.cost*penaltyNowRate)
	if($Card2.floor!=null):
		$Card2.floor.cost = int($Card2.floor.cost*penaltyNowRate)
	'''
	father.build(floornow)
	pass
#玩家的turn_begin	

func turnEnd():
	father.finished = true
	visible =  false

func turnBegin():
	visible = true
	gold += productor * int(Pool.poolAttr["科技等级_"+str(level)+"_矿工生产速度"])
	goldFlushCost = int(Pool.poolAttr["科技等级_"+str(level)+"_刷新金币"])
	penaltyNowRate = 1
	penaltyBuy = float(Pool.poolAttr["科技等级_"+str(level)+"_购买惩罚倍率"])
	refresh()

func _ready():
	$Card0.father = self
	$Card1.father = self
	$Card2.father = self
	productor = int(Pool.poolAttr["初始矿工"])
	productorLimit = int(Pool.poolAttr["初始矿工上限"])
	goldFlushCost = int(Pool.poolAttr["科技等级_1_刷新金币"])
	gold = int(Pool.poolAttr["初始金币"])
	penaltyBuy = float(Pool.poolAttr["科技等级_1"+"_购买惩罚倍率"])
	penaltyNowRate = 1
	level = 1 #初始科技等级

	

func _on_button_refresh_pressed():
	if(gold < goldFlushCost) : return
	gold -= goldFlushCost
	goldFlushCost *= penaltyCoefficient
	refresh()
	pass # Replace with function body.


func _on_button_up_level_pressed():
	if(gold < int(Pool.poolAttr["科技等级_"+str(level)+"_科技升级金币"]) || level==6 ):
		return;
	gold = gold - int(Pool.poolAttr["科技等级_"+str(level)+"_科技升级金币"]) 
	level += 1
	penaltyBuy = float(Pool.poolAttr["科技等级_"+str(level)+"_购买惩罚倍率"])
	pass # Replace with function body.


func _on_button_finish_pressed():
	turnEnd()
	pass # Replace with function body.
