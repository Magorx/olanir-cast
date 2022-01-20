extends KinematicBody2D

class_name Unit

export var max_velocity: float = 10


var velocity: Vector2 = Vector2(0, 0)

var team: int = 0

func _init():
    init_states()


# Called when the node enters the scene tree for the first time.
func _ready():
    max_velocity *= GameInfo.TILE_SIZE
    pass # Replace with function body.


func _process(delta):
    if (cur_state):
        cur_state.execute(delta)


func _physics_process(_delta):
    var _collision = move_and_slide(velocity)


func alter_velocity_to(new_velocity):
    velocity = lerp(velocity, new_velocity, GameInfo.SPEED_LERP_COEF)


func process_input():
    var vel := Vector2(0, 0)
    vel.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
    vel.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
    vel = vel.normalized()

    alter_velocity_to(vel * max_velocity)


# States

var states
var cur_state: UnitState

func set_state(name):
    var state = get_state(name)
    if not state:
        return

    cur_state = state
    
    print("new active state is [", name, "]")


func init_states():
    states = {}
        

func get_state(state_name):
    if states.has(state_name):
        return states.get(state_name)
    else:
        printerr("No state [", state_name, "] in state factory!")
        return 0

