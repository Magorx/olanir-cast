class_name UnitState


var set_state # a function to be called when another state needs to be assigned


var unit


func _init(unit_, fref_set_state):
    unit = unit_
    set_state = fref_set_state


func execute(_delta):
    pass


func can_proc_input() -> bool:
    return true
    

func can_move() -> bool:
    return true


func can_cast() -> bool:
    return true
