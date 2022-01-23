extends KinematicBody2D

class_name Unit

export var max_velocity: float = 10


var velocity: Vector2 = Vector2(0, 0)
var input_velocity: Vector2 = Vector2(0, 0)

var last_tick_position: Vector2 = Vector2(0, 0)
var actual_velocity: Vector2 = Vector2(0, 0)

var is_trying_to_move: bool = false

var team: int = 0

var states
var cur_state: UnitState

func _init():
    init_states()


# Called when the node enters the scene tree for the first time.
func _ready():
    max_velocity *= GameInfo.TILE_SIZE
    $ColorModulator.setup(self)


func _process(delta):
    cur_state.execute(delta)


func _physics_process(_delta):
    actual_velocity = (position - last_tick_position) / _delta
    last_tick_position = position
    
    if actual_velocity.length() < GameInfo.MIN_VELOCITY:
        actual_velocity = Vector2(0, 0)


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
    
    vel = vel * max_velocity
    
    if vel.length() < GameInfo.MIN_VELOCITY:
        vel = Vector2(0, 0)


func face_towards(vector):
    if vector.x < 0:
        $AnimatedSprite.set_flip_h(true)
    else:
        $AnimatedSprite.set_flip_h(false)


func face_towards_mouse():
    var to_mouse = get_global_mouse_position() - position
    face_towards(to_mouse)


func face_towards_velocity():
    face_towards(velocity)


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
    if not another is get_script():
        return false

    return team and (team == another.team)
