extends Unit


class_name Creature


signal death
signal spawn


export var cast_radius: int = 32

var is_alive: bool = true
export var respawnable: bool = false

var DamageNumbersPacked = preload("res://utils/damage_numbers/damage_numbers.tscn")


func _ready():
    pass # Replace with function body.


func _physics_process(_delta):
    var __ = move_and_slide(velocity)


func init_states():
    .init_states()

    states["idle"]           = CreatureStateIdle         .new(self, funcref(self, "set_state"))
    states["move"]           = CreatureStateMove         .new(self, funcref(self, "set_state"))
    states["move_release"]   = CreatureStateMoveRelease  .new(self, funcref(self, "set_state"))
    states["move_attack"]    = CreatureStateMoveAttack   .new(self, funcref(self, "set_state"))
    states["dying"]          = CreatureStateDying        .new(self, funcref(self, "set_state"))
    states["dead"]           = CreatureStateDead         .new(self, funcref(self, "set_state"))
    states["spawning"]       = CreatureStateSpawning     .new(self, funcref(self, "set_state"))
    states["ready_to_spawn"] = CreatureStateReadyToSpawn .new(self, funcref(self, "set_state"))

    set_state("idle")


func deal_damage(damage: Damage):
    var resist = $Stats.resists.get(damage.type)
    var coef = 1 - resist / 100.0
    
    var final_damage = int(damage.value * coef)
    
    $Stats.hp -= final_damage
    
    var damage_number: DamageNumber = DamageNumbersPacked.instance()
    damage_number.setup(position, damage.damage_overriden(final_damage))
    
    add_sibling_node(damage_number)
    
    $ColorModulator.moduate(damage.color, GameInfo.HIT_HIGHLIGHT_TIME)
    
    if $Stats.hp <= 0:
        set_state("dying")
