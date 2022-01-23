extends UnitState


class_name CreatureStateSpawning


func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(_delta):
    if not executed:
        unit.get_node("AnimatedSprite").play("spawning")
        
        unit.is_alive = true
        unit.visible = true
        unit.get_node("CollisionShape2D").set_deferred("disabled", false)
        
        unit.emit_signal("spawn")
        
        unit.get_node("AnimatedSprite").connect("animation_finished", self, "next_state")
        
    .execute(_delta)


func next_state():
    unit.get_node("AnimatedSprite").disconnect("animation_finished", self, "next_state")

    set_state.call_func("idle")


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
