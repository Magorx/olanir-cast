extends TemplateMenu


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_JoinButton_pressed():
    Interface.descend_to("matchmaking_join")


func _on_HostButton_pressed():
    Interface.descend_to("matchmaking_host")
