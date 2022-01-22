extends Unit


class_name Creature


export var max_hp: int = 100
export var max_mp: int = 10


var hp = max_hp
var mp = max_mp



func _ready():
    pass # Replace with function body.


func init_states():
    .init_states()

    states["idle"] = CreatureStateIdle.new(self, funcref(self, "set_state"))
    states["move"] = CreatureStateMove.new(self, funcref(self, "set_state"))
    states["move_release"] = CreatureStateMoveRelease.new(self, funcref(self, "set_state"))
    states["move_attack"] = CreatureStateMoveAttack.new(self, funcref(self, "set_state"))

    set_state("idle")
