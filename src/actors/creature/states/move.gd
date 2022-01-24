extends UnitState


class_name CreatureStateMove


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    if not unit.is_trying_to_move:
        set_state.call_func("move_release")
        unit.cur_state.execute(_delta)
        return
    
    if not executed:
        unit.get_node("AnimatedSprite").play("move")
    
    .execute(_delta)
    
    unit.velocity = unit.input_velocity * unit.get_node("Stats").move_speed

    unit.face_towards_velocity()


func get_cast_level() -> int:
    return GameInfo.CASTING_LEVEL_MOVE
