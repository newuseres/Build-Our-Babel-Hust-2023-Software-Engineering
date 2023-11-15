extends Control

signal sendData(data)

func _on_send_pressed():
	emit_signal("sendData", $Text.text)
	$Text.clear()
