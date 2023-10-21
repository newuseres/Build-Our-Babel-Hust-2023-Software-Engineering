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

var level:int

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
	
func turnEnd():
	get_parent().finished = true

func turnBegin():
	gold += productor
	refresh()

