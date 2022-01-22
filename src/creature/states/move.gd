extends UnitState


class_name CreatureStateMove


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    .execute(_delta)

    unit.get_node("AnimatedSprite").play("move")

    if unit.velocity.x < 0:
        unit.get_node("AnimatedSprite").set_flip_h(true)
    else:
        unit.get_node("AnimatedSprite").set_flip_h(false)

    if not unit.is_trying_to_move:
        set_state.call_func("move_release")


func get_cast_level() -> int:
    return GameInfo.CASTING_LEVEL_MOVE
