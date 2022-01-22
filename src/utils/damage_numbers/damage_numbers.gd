extends Label


class_name DamageNumber


var velocity: Vector2 = Vector2(0, -50)


func _ready():
    pass # Replace with function body.


func _process(delta):
    rect_position += velocity * delta


func setup(position, damage: Damage, expire_time=1):
    text = str(damage.value)
    
    var text_size = get_combined_minimum_size()
    rect_position = position - text_size / 2

    set_self_modulate(damage.color)


func on_expire():
    queue_free()
