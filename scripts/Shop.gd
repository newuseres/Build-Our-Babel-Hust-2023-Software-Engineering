extends Node

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

var gold:int 

var level:int

var productor:int

func refresh():
	
	pass

func buy(floor):
	if(gold < floor.cost) : return
	gold -= floor.cost
	get_parent().build(floor)
	pass

func newTurn():
	gold += productor
	refresh()

