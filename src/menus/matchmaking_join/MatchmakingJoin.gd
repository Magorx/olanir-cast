extends TemplateMenu


func _ready():
    var __ = get_tree().connect("connected_to_server", self, "_connected_to_server")


func _on_ConnectButton_pressed():
    var ip = $IpLineEdit.text
    var port = $PortLineEdit.text

    if not ip or not port:
        print("no ip or port entered")
        return

    if port.is_valid_integer():
        port = int(port)
    else:
        port = null

    Network.join_server(ip, port)

    Interface.switch_to("ingame_hud")


func _connected_to_server():
    print("Connected!")
