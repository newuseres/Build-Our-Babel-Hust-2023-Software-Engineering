extends Node2D


# Called when the node enters the scene tree for the first time.
var father:FloorBase

func _ready():
	father = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$health.value = (100.0 * father.health/father.maxHealth)
	#if($health.value>50):$health.tint_progress = Color.DARK_GREEN
	#elif($health.value>20.0&&$health.value<=50): $health.tint_progress = Color.CORAL
	#else:$health.tint_progress = Color.DARK_RED
	$health.tint_progress = Color(0.8 - 0.8 * father.health / father.maxHealth,0.8 * father.health / father.maxHealth ,0)
	$costLabel.text = "购买花费:" + String.num_int64(self.father.cost)
	$healthLabel.text = "当前血量:"+str(father.health)+"/"+str(father.maxHealth)
	if(father.floortype == "MineFloor"):
		$atkLabel.text = "回合生产矿工:"+str(father.produce)
	elif father.floortype == "HeavyGunFloor" or father.floortype == "GunFloor" :
		$atkLabel.text = "回合攻击力:"+str(father.attackPoint)
	$weightLabel.text = "重量:"+str(father.weight)
	$nameLabel.text = str(father.myName)
	
	#$Name.text = "Health:" + String.num_int64(self.father.health)
	#text = text+"\n" + "Cost:" + String.num_int64(self.father.cost)
	if visible:
		position = father.to_local(get_viewport().get_mouse_position() )
	pass
