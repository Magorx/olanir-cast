extends TemplateMenu


func _ready():
	pass


func _on_CreateServerButton_pressed():
	var port = $PortLineEdit.text
	if port.is_valid_integer():
		port = int(port)
	else:
		port = null

	Game.load_level($LevelNameLineEdit.text)
	
	Network.create_server(port)
	
	Game.set_local_player(Network.instance_player(get_tree().get_network_unique_id()))
	
	Interface.switch_to("ingame_hud")
