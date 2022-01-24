extends TemplateMenu


func _ready():
    pass


func _on_MatchmakingButton_pressed():
    Interface.descend_to("matchmaking")
