extends AreaEffect


export var color: Color = Color(255, 255, 255, 255 / 2)


func _ready():
    $AnimatedSprite.modulate = color


func on_unit_enter(unit: Unit):
    if unit is Projectile:
        var norm = (unit.position - position).normalized()
        unit.velocity -= 2 * unit.velocity.dot(norm) * norm
        
