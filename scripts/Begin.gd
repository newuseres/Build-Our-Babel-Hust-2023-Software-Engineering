extends Node2D


# Called when the node enters the scene tree for the first time.
var x:int = 1
var bgText:Array[String] = ["",
"曾经有一个与世隔绝的王国",
"王国中传说天空上有无尽的财宝",
"于是国王决定建立一座通天高塔",
"热爱恶作剧的妖精决定阻止人类",
"然后人们看到远处的迷雾中升起一座座高塔"]
func _ready():
	$Sprite2D.texture = load( "res://image/bg"+String.num_int64(x)+".png")
	$Label.text = bgText[x]
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
var sleepT = 0.0
var NewMainTscn = preload("res://tscns/NewMain.tscn")
func _process(delta):
	if sleepT > 0 :
		sleepT -= delta
		return
	if Input.is_anything_pressed() :
		sleepT = 1
		x += 1
		
		if x == 6 :
			#get_tree().change_scene_to_file("res://tscns/NewMain.tscn")
			var newMainTscn = (NewMainTscn.instantiate())
			newMainTscn.playID = 1
			get_tree().root.add_child(newMainTscn)
			get_tree().root.remove_child(self)
			return
		if x < 6 :
			$Sprite2D.texture = load( "res://image/bg"+String.num_int64(x)+".png")
			$Label.text = bgText[x]
	pass
