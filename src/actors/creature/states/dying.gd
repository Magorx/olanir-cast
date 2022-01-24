extends UnitState


class_name CreatureStateDying


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    unit.velocity = lerp(unit.velocity, Vector2(0, 0), 0.2)
    
    if not executed:
        unit.get_node("AnimatedSprite").play("dying")
        
        unit.is_alive = false
        
        unit.emit_signal("death")
        
        print((unit.get_node("AnimatedSprite") as AnimatedSprite).emit_signal("animation_finished"))
        unit.get_node("AnimatedSprite").connect("animation_finished", self, "next_state")
    
    .execute(_delta)
    


func next_state():
    unit.get_node("AnimatedSprite").disconnect("animation_finished", self, "next_state")
    
    if not same_state_active():
        return

    set_state.call_func("dead")


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
