extends TemplateMenu


func _ready():
    pass


func _on_ExitButton_pressed():
    get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
