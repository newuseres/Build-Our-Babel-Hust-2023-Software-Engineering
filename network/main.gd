extends Control
class_name NetworkMain

@onready var _client: WebSocketClient = $WebSocketClient
var ID = null
var game:Game
var gameTscn = preload("res://tscns/NewMain.tscn")

# 更换大厅场景
func to_menu ():
	$Menu/RoomTip.hide()
	$Menu/TextEdit.clear()
	$Menu.visible = true
	
# 更换房间场景
func to_room (room_id):
	$WaitingRoom/WaitingPlayer.clear()
	$WaitingRoom/Ready.text = "准备"
	$WaitingRoom/Ready.set_pressed_no_signal(false)
	$WaitingRoom/Number.text = "房间号：" + room_id
	$WaitingRoom.visible = true

func to_game (playid,seed0,seed1):
	
	game = gameTscn.instantiate()
	game.father = self
	game.playID = playid	
	game.seed0 = seed0
	game.seed1 = seed1
	add_child(game)

	
	
# 更新房间人员列表
func update_waiting_list (data):
	$WaitingRoom/WaitingPlayer.clear()
	for i in range(2):
		if (data["players"][i] == null):
			continue
		var playerLabel = data["players"][i]
		if (data["ready"][i] == true):
			playerLabel += "（准备）"
		$WaitingRoom/WaitingPlayer.add_item(playerLabel)

# 客户端离线
func _on_web_socket_client_connection_closed():
	var ws = _client.get_socket()

# 客户端连接
func _on_web_socket_client_connected_to_server():
	$ServerErrorLabel.hide()
	$IDUI.visible = true

# 客户端接收数据
func _on_web_socket_client_message_received(_message):
	var message:Dictionary = JSON.parse_string(_message)
	print(ID,"\n",message)
	# 接收连接数据
	if (message["type"] == "connect"):
		if (message["data"] == "OK"):
			ID = message["ID"]
			$Menu/IDLabel.text = ID
			$Menu.visible = true
			$IDUI.hide()
		else:
			$IDUI/IDTipLabel.visible = true
	
	# 接收创建房间数据
	if (message["type"] == "createroom"):
		$Menu.hide()
		to_room(message["data"])
		pass
	
	# 接收房间详细信息
	if (message["type"] == "roomdetail"):
		update_waiting_list(message["data"])
	
	# 接收加入房间数据
	if (message["type"] == "joinroom"):
		if (message["data"] == "NOTFIND"):
			$Menu/RoomTip.text = "该房间不存在"
			$Menu/RoomTip.visible = true
		elif (message["data"] == "FULL"):
			$Menu/RoomTip.text = "该房间人数已满"
			$Menu/RoomTip.visible = true
		else:
			$Menu.hide()
			to_room(message["data"])
	
	# 接收开始游戏信息
	if (message["type"] == "startgame"):
		$WaitingRoom.hide()
		to_game(message.get("playid",1),message.get("seed0",0),message.get("seed1",0))
		
	# 接收游戏聊天信息
	#if (message["type"] == "chat"):
	#	$Client/RichTextLabel.add_text(message["ID"] + ": " + message["data"] + "\n")
		
	# 接收结束游戏信息
	if (message["type"] == "endgame"):
		game.queue_free()
		to_room(message["roomnum"])
		if (message["reason"] == "quit"):
			$Info/Label.text = "对手退出了游戏"
			$Info.visible = true
	
	if (message["type"] == "gameoperation"):
		game.enemyAct(message)  
		pass


func _ready():
	#to be coding
	var err = _client.connect_to_url("ws://175.178.69.150:8000/")
	# var err = _client.connect_to_url("ws://localhost:8000/")
	if err != OK:
		_client.close()
		return

# 大厅 - 加入房间
func _on_join_pressed():
	_client.send(JSON.stringify({"type": "joinroom", "ID": ID, "roomnum": $Menu/TextEdit.text}))

# 大厅 - 随机加入
func _on_rand_join_pressed():
	_client.send(JSON.stringify({"type": "randjoin", "ID": ID}))

# 大厅 - 创建房间
func _on_create_pressed():
	_client.send(JSON.stringify({"type": "createroom", "ID": ID}))

# ID 界面 - 确定
func _on_id_button_pressed():
	var preID = $IDUI/IDEdit.text
	if (preID != ""):
		_client.send(JSON.stringify({"type": "connect", "ID": preID}))

# 准备房间 - 准备
func _on_ready_toggled (button_pressed):
	if button_pressed:
		$WaitingRoom/Ready.text = "取消准备"
		_client.send(JSON.stringify({"type": "ready", "ID": ID}))
	else:
		$WaitingRoom/Ready.text = "准备"
		_client.send(JSON.stringify({"type": "ready", "ID": ID}))

# 准备房间 - 退出
func _on_quit_pressed():
	$WaitingRoom.hide()
	to_menu()
	_client.send(JSON.stringify({"type": "quitroom", "ID": ID}))

# 游戏中发送信息
func _on_client_send_data(data:Dictionary):
	data["ID"] = ID
	_client.send(JSON.stringify(data))
	
