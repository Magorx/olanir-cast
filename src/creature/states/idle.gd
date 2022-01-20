extends UnitState


class_name CreatureStateIdle


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    unit.get_node("AnimatedSprite").play("idle")

    if unit.velocity.length_squared() > GameInfo.MIN_VELOCITY_LENGTH_SQUARED:
        set_state.call_func("move")
    else:
        unit.velocity = Vector2(0, 0)
