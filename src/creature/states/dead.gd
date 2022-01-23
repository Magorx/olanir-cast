extends UnitState


class_name CreatureStateDead


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    if not executed:
        unit.visible = false
        unit.get_node("CollisionShape2D").set_deferred("disabled", true)
        

    .execute(_delta)


func can_proc_input() -> bool:
    return false


func can_affect_movement() -> bool:
    return false
    

func can_move() -> bool:
    return false


func can_cast() -> bool:
    return false


func get_cast_level() -> int:
    return GameInfo.CASTING_LEVEL_DEAD
