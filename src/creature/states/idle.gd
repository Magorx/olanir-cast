extends UnitState


class_name CreatureStateIdle


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    .execute(_delta)

    unit.get_node("AnimatedSprite").play("idle")

    if unit.is_trying_to_move:
        set_state.call_func("move_attack")
    else:
        unit.velocity = Vector2(0, 0)
