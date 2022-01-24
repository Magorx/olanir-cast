extends UnitState


class_name CreatureStateIdle


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    if not executed:
        unit.get_node("AnimatedSprite").play("idle")
    
    .execute(_delta)

    if unit.is_trying_to_move:
        set_state.call_func("move_attack")
        unit.cur_state.execute(_delta)
        return
    
    unit.velocity = Vector2(0, 0)
    unit.face_towards_mouse()
