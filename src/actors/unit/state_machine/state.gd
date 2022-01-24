class_name UnitState


var set_state # a function to be called when another state needs to be assigned


var unit
var executed: bool = false


func _init(unit_, fref_set_state):
    unit = unit_
    set_state = fref_set_state


func execute(_delta):
    executed = true


func same_state_active():
    return unit.cur_state == self


func activate():
    executed = false


func deactivate():
    executed = false


func can_proc_input() -> bool:
    return true


func can_affect_movement() -> bool:
    return true
    

func can_move() -> bool:
    return true


func can_cast() -> bool:
    return true


func get_cast_level() -> int:
    return GameInfo.CASTING_LEVEL_DEFAULT

