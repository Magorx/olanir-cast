extends Creature


const energy_bolt = "res://magic/spell_form/projectile/collection/EnergyBalt.tscn"
const circle_area = preload("res://magic/spell_form/area_effect/collection/AreaEffectCircle.tscn")


var spell: Spell


func _ready():
    spell = Spell.new()
    spell.add_rune(RuneCastNext.new())
    spell.add_rune(RuneSpawnTriggerProjectile.new().set_projectile_type(energy_bolt))
    spell.add_rune(RuneSpawnAreaEffect.new().set_area_type(circle_area))


func process_input():
    .process_input()
    
    if Input.is_action_pressed("primary_cast"):
        if $ReloadTimer.is_stopped() and cur_state.can_cast():
            rpc("sync_force")
            rpc("cast_spell", position, direction)
            $ReloadTimer.start()


remotesync func cast_spell(position_, direction_):
#    var caster = get_tree().root.get_node(caster_path)
    var __ = spell.cast(self, position_, direction_)
