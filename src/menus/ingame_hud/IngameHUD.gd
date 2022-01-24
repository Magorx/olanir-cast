extends TemplateMenu


func _ready():
    visible = false


func _unhandled_key_input(event):
    if event.pressed:
        if event.physical_scancode == KEY_ESCAPE:
            visible = not visible
            if visible:
                hud_on()
            else:
                hud_off()

func _on_BackButton_pressed():
    pass


func hud_on():
    Game.get_current_controller().deactivate()


func hud_off():
    Game.get_current_controller().activate()


func _on_ExitButton_pressed():
    Game.unload_current_level()
    Interface.switch_to("main_menu")
