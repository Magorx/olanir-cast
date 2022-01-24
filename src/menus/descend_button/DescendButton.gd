extends Button


export var menu_name: String


func _on_DescendButton_pressed():
    if not menu_name:
        print("lol")
        return
    
    Interface.descend_to(menu_name)
