extends UnitState


class_name ProjectileStateIdle


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    if not executed:
        unit.get_node("AnimatedSprite").play("idle")
    
    .execute(_delta)
