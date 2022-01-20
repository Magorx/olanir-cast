extends UnitState


class_name CreatureStateMove


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(delta):
    if unit.velocity.x < 0:
        unit.get_node("AnimatedSprite").play("move_left")
    else:
        unit.get_node("AnimatedSprite").play("move_right")

    if unit.velocity.length_squared() < GameInfo.MIN_VELOCITY_LENGTH_SQUARED:
        unit.velocity = Vector2(0, 0)
        set_state.call_func("idle")
