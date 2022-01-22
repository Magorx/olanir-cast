extends UnitState


class_name CreatureStateMoveRelease


var release_start_velocity: Vector2
var move_release_time: float
var timer: Timer

func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(delta):
    if unit.is_trying_to_move:
        if timer:
            timer.queue_free()
            timer = null
        set_state.call_func("move_attack")
        unit.cur_state.execute(delta)
        return
    
    if not executed:
        unit.get_node("AnimatedSprite").play("move_release")
        
        release_start_velocity = unit.velocity
        move_release_time = unit.get_node("Stats").move_release_time

        timer = Timer.new()
        timer.wait_time = move_release_time
        timer.one_shot = true
        var __ = timer.connect("timeout", self, "next_state")
        
        unit.add_sibling_node(timer)
        timer.start()
    
    .execute(delta)
    
    unit.set_velocity(lerp(Vector2(0, 0), release_start_velocity, linear_coef_formula(timer.time_left)), true)


func linear_coef_formula(t):
    var c = t / move_release_time
    return c


func can_affect_movement() -> bool:
    return false


func next_state():
    unit.velocity = Vector2(0, 0)
    set_state.call_func("idle")


func get_cast_level() -> int:
    return GameInfo.CASTING_LEVEL_MOVE
