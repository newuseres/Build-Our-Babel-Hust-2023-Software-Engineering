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
var penaltyCoefficient:float = 2#惩罚系数
var level:int = 1

var productor:int


func refresh():
	$Card0.refresh()
	$Card1.refresh()
	$Card2.refresh()
	pass

func buy(floor):
	if(gold < floor.cost) : return
	gold -= floor.cost
	var card = floor.get_parent()
	card.remove_child(floor)
	card.visible = false
	get_parent().build(floor)
	pass
#玩家的turn_begin	
func turnEnd():
	get_parent().finished = true

func turnBegin():
	gold += productor * int(Pool.poolAttr["科技等级_"+str(level)+"_矿工生产速度"])
	goldFlushCost =int(Pool.poolAttr["科技等级_"+str(level)+"_刷新金币"])
	refresh()

func _ready():
	productor = int(Pool.poolAttr["初始矿工"])
	goldFlushCost = int(Pool.poolAttr["科技等级_1_刷新金币"])
	gold = int(Pool.poolAttr["初始金币"])
	level = 1 #初始科技等级

	

func _on_button_refresh_pressed():
	if(gold < goldFlushCost) : return
	gold -= goldFlushCost
	goldFlushCost *= penaltyCoefficient
	refresh()
	pass # Replace with function body.


func _on_button_up_level_pressed():
	if(gold < int(Pool.poolAttr["科技等级_"+str(level)+"_科技升级金币"]) || level==5 ):
		return;
	gold = gold - int(Pool.poolAttr["科技等级_"+str(level)+"_科技升级金币"]) 
	level += 1
	pass # Replace with function body.


func _on_button_finish_pressed():
	turnEnd()
	pass # Replace with function body.
