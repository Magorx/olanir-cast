extends UnitState


class_name CreatureStateMoveAttack


var attack_start_velocity: Vector2
var max_velocity: Vector2
var cur_target_velocity: Vector2
var move_attack_time: float
var timer: Timer

func _init(unit_, fref_set_state).(unit_, fref_set_state):
    pass


func execute(delta):
    if not unit.is_trying_to_move:
        if timer:
            timer.queue_free()
            timer = null
        set_state.call_func("move_release")
        unit.cur_state.execute(delta)
        return
    
    if not executed:
        unit.get_node("AnimatedSprite").play("move_attack")
        
        attack_start_velocity = unit.velocity
        move_attack_time = unit.get_node("Stats").move_attack_time
        max_velocity = Vector2(unit.max_velocity, unit.max_velocity)

        timer = Timer.new()
        timer.wait_time = move_attack_time
        timer.one_shot = true
        var __ = timer.connect("timeout", self, "next_state")
        
        unit.add_sibling_node(timer)
        timer.start()
    
    .execute(delta)
    
    cur_target_velocity = max_velocity * unit.input_velocity
    unit.set_velocity(lerp(cur_target_velocity, attack_start_velocity, linear_coef_formula(timer.time_left)), true)


func linear_coef_formula(t):
    var c = t / move_attack_time
    return c * c


func next_state():
    cur_target_velocity = max_velocity * unit.input_velocity
    unit.velocity = cur_target_velocity
    set_state.call_func("move")


func get_cast_level() -> int:
    return GameInfo.CASTING_LEVEL_MOVE
