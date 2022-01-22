extends KinematicBody2D

class_name Unit

export var max_velocity: float = 10


var velocity: Vector2 = Vector2(0, 0)
var input_velocity: Vector2 = Vector2(0, 0)
var is_trying_to_move: bool = false

var team: int = 0

var states
var cur_state: UnitState

func _init():
    init_states()


# Called when the node enters the scene tree for the first time.
func _ready():
    max_velocity *= GameInfo.TILE_SIZE


func _process(delta):
    cur_state.execute(delta)


func _physics_process(_delta):
    var _collision = move_and_slide(velocity)


func alter_velocity_to(new_velocity):
    set_velocity(lerp(velocity, new_velocity, GameInfo.SPEED_LERP_COEF))


func set_velocity(velocity_, force = false):
    if cur_state.can_affect_movement() or force:
        velocity = velocity_


func process_input():
    var vel := Vector2(0, 0)
    vel.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
    vel.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
    vel = vel.normalized()
    
    is_trying_to_move = vel.length_squared() != 0
    input_velocity = vel

    alter_velocity_to(vel * max_velocity)


# States

func set_state(name):
    var state = get_state(name)
    if not state:
        return

    if cur_state:
        cur_state.deactivate()
    
    cur_state = state
    cur_state.activate()
    
    print("new active state is [", name, "]")


func init_states():
    states = {}
    cur_state = UnitState.new(self, funcref(self, "set_state"))
        

func get_state(state_name):
    if states.has(state_name):
        return states.get(state_name)
    else:
        printerr("No state [", state_name, "] in state factory!")
        return 0


func add_sibling_node(node):
    get_parent().add_child(node)


func same_team(another) -> bool:
    return team and (team == another.team)
