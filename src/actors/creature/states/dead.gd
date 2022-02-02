extends UnitState


class_name CreatureStateDead


var timer


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    if not executed:
        unit.velocity = Vector2(0, 0)
        unit.visible = false
        unit.get_node("CollisionShape2D").set_deferred("disabled", true)
        
        if not unit.respawnable:
            unit.queue_free()
        else:
            timer = Timer.new()
            timer.wait_time = unit.get_node("Stats").respawn_time
            timer.one_shot = true
            var __ = timer.connect("timeout", self, "next_state")
            
            unit.add_sibling_node(timer)
            timer.start()

    .execute(_delta)


func next_state():
    if timer:
        timer.queue_free()
        timer = null
    
    set_state.call_func("ready_to_spawn")


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
