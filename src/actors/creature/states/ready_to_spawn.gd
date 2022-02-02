extends UnitState


class_name CreatureStateReadyToSpawn


var timer


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    var spawn_area = Game.get_current_level().get_random_spawn_area(unit.team)
    if not spawn_area:
#        unit.queue_free()
        return

    spawn_area.spawn_creature(unit)
    
    set_state.call_func("spawning")

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
