# this is just an example of what area could be
extends AreaEffect

const energy_bolt = preload("res://projectile/collection/EnergyBalt.tscn")


export var radius: float = 5
export var color: Color = Color(255, 255, 255, 255 / 2)


var spell: Spell


func _ready():
    scale.x = 2 * radius / $AnimatedSprite.frames.get_frame("default", 0).get_size().x
    scale.y = scale.x
    
    spell = Spell.new()
    spell.add_rune(RuneSpawnProjectile.new().set_projectile_type(energy_bolt))


func on_appear(caster, pos, dir):
    $AnimatedSprite.play("boom")
    .on_appear(caster, pos, dir)


func on_effect_tick():
    var bodies = get_overlapping_bodies()
    for body in bodies:
        if body is Unit:
            var unit: Unit = body as Unit
            var dir = unit.position - position
            dir = dir.normalized()

            body.velocity += dir * 64 * 50
    .on_effect_tick()


func on_expire():
    yield($AnimatedSprite, "animation_finished")
    .on_expire()


#func on_unit_enter(unit: Unit):
#    if unit is Projectile:
#        var norm = (unit.position - position).normalized()
#        unit.velocity -= 2 * unit.velocity.dot(norm) * norm

