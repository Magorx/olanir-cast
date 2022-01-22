extends Unit


class_name Creature


export var cast_radius: int = 32


var DamageNumbersPacked = preload("res://utils/damage_numbers/damage_numbers.tscn")


func _ready():
    pass # Replace with function body.


func _physics_process(_delta):
#    print("creat ", self, " ", position, " vel ", velocity)
    var __ = move_and_slide(velocity)


func init_states():
    .init_states()

    states["idle"]          = CreatureStateIdle         .new(self, funcref(self, "set_state"))
    states["move"]          = CreatureStateMove         .new(self, funcref(self, "set_state"))
    states["move_release"]  = CreatureStateMoveRelease  .new(self, funcref(self, "set_state"))
    states["move_attack"]   = CreatureStateMoveAttack   .new(self, funcref(self, "set_state"))

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


#func 
