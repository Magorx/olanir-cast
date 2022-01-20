extends Unit


class_name Creature


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func init_states():
    .init_states()

    states["idle"] = CreatureStateIdle.new(self, funcref(self, "set_state"))
    states["move"] = CreatureStateMove.new(self, funcref(self, "set_state"))

    set_state("idle")
