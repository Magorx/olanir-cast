extends Creature


const energy_bolt = preload("res://projectile/collection/EnergyBalt.tscn")

var spell: Spell
var direction: Vector2
var cast_radius = 32

# Called when the node enters the scene tree for the first time.
func _ready():
    spell = Spell.new()
    spell.add_rune(RuneCastNext.new())
    spell.add_rune(RuneSpawnTriggerProjectile.new().set_projectile_type(energy_bolt))
    spell.add_rune(RuneSpawnProjectile.new().set_projectile_type(energy_bolt))
    pass # Replace with function body.


func _process(_delta):
    direction = (get_global_mouse_position() - position).normalized()


func process_input():
    .process_input()
    
    if Input.is_action_pressed("primary_cast"):
        if $ReloadTimer.is_stopped():
            var __ = spell.cast(self, position, direction)
            $ReloadTimer.start()
