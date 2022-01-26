extends Creature


const energy_bolt = "res://magic/spell_form/projectile/collection/EnergyBalt.tscn"
const circle_area = preload("res://magic/spell_form/area_effect/collection/AreaEffectCircle.tscn")


var spell: Spell
var direction: Vector2


func _ready():
    spell = Spell.new()
    spell.add_rune(RuneCastNext.new())
    spell.add_rune(RuneSpawnTriggerProjectile.new().set_projectile_type(energy_bolt))
    spell.add_rune(RuneSpawnAreaEffect.new().set_area_type(circle_area))


func _process(_delta):
    direction = (get_global_mouse_position() - position).normalized()


func process_input():
    .process_input()
    
    if Input.is_action_pressed("primary_cast"):
        if $ReloadTimer.is_stopped() and cur_state.can_cast():
            var __ = spell.cast(self, position, direction)
            $ReloadTimer.start()
