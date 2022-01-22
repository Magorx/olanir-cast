extends Unit


class_name Creature


var DamageNumbersPacked = preload("res://utils/damage_numbers/damage_numbers.tscn")


func _ready():
    pass # Replace with function body.


func init_states():
    .init_states()

    states["idle"] = CreatureStateIdle.new(self, funcref(self, "set_state"))
    states["move"] = CreatureStateMove.new(self, funcref(self, "set_state"))
    states["move_release"] = CreatureStateMoveRelease.new(self, funcref(self, "set_state"))
    states["move_attack"] = CreatureStateMoveAttack.new(self, funcref(self, "set_state"))

    set_state("idle")


func deal_damage(damage: Damage):
    var resist = $Stats.resists.get(damage.type)
    var coef = 1 - resist / 100.0
    
    var final_damage = int(damage.value * coef)
    
    $Stats.hp -= final_damage
    
    var damage_number: DamageNumber = DamageNumbersPacked.instance()
    damage_number.setup(position, damage.damage_overriden(final_damage))
    
    add_sibling_node(damage_number)
