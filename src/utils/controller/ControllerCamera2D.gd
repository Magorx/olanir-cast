extends Camera2D


export var zoom_step: float = 0.035


export var max_dist_lag: int = 50
export var min_dist_lag: int = 10

export var max_velocity: int = max_dist_lag * 10
export var min_velocity: int = min_dist_lag * 30


var velocity: Vector2 = Vector2(0, 0)


func _ready():
    make_current()


func _process(_delta):
    pass


func magnitize_camera(unit, delta):
    var mouse_pos = get_global_mouse_position()
    var unit_pos = unit.position
    
    var target_pos = calculate_target_pos(mouse_pos, unit_pos)
    
    calculate_velocity(target_pos)
    position += velocity
    
    if (position - target_pos).length() < min_dist_lag:
        position = target_pos


func calculate_target_pos(mouse_pos, unit_pos):
    return (mouse_pos + unit_pos) / 2


func calculate_velocity(target):
    var dir = target - position
    var dist = dir.length()
    dir = dir.normalized()

    velocity = dir * dist


func _input(event: InputEvent):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_WHEEL_DOWN:
            zoom += Vector2(zoom_step, zoom_step)
        if event.button_index == BUTTON_WHEEL_UP:
            zoom -= Vector2(zoom_step, zoom_step)
