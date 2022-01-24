extends TemplateMenu


func _ready():
    pass


func _on_CreateServerButton_pressed():
    load_level($LevelNameLineEdit.text)


func load_level(name):
    var pk_level = load("res://collection/levels/" + name)

    Game.load_level(pk_level)
    Game.add_local_player()

