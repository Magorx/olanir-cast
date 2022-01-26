extends KinematicBody2D

class_name Unit


var active = true


export var max_velocity: float = 10


var velocity: Vector2 = Vector2(0, 0)
var input_velocity: Vector2 = Vector2(0, 0)

var last_tick_position: Vector2 = Vector2(0, 0)
var actual_velocity: Vector2 = Vector2(0, 0)

var is_trying_to_move: bool = false

var team: int = 0

var states
var cur_state: UnitState
var cur_state_name: String


var shared: bool = false


# Network =

remote var puppet_position = Vector2(0, 0) setget puppet_position_set
remote var puppet_velocity = Vector2(0, 0)
remote var puppet_rotation = 0
remote var puppet_mouse_position = Vector2(0, 0)

onready var pos_tween = $PuppetPositionTween

# =========

func puppet_position_set(val):
    puppet_position = val
    
#    position = puppet_position
    
    pos_tween.interpolate_property(self, "position", position, puppet_position, 0.1)
    pos_tween.start()


func network_tick_update():
    if is_network_master():
        rset("puppet_position", position)
        rset("puppet_velocity", actual_velocity)
        rset("puppet_rotation", rotation_degrees)
        rset("puppet_mouse_position", get_global_mouse_position())


func _init():
    init_states()


func _ready():
    max_velocity *= GameInfo.TILE_SIZE
    $ColorModulator.setup(self)
    
    var __ = null
    __ = Network.tickrate_timer.connect("timeout", self, "network_tick_update")


func setup(args: Dictionary):
    position = args["position"]
    velocity = args["velocity"]
    rotation_degrees = args["rotation_degrees"]
    
    set_state(args["state_name"])


func get_setup_args() -> Dictionary:
    var args = {}

    args["position"] = position
    args["velocity"] = velocity
    args["rotation_degrees"] = rotation_degrees
    args["state_name"] = cur_state_name
    
    return args


func _process(delta):
    cur_state.execute(delta)


func _physics_process(delta):
    actual_velocity = (position - last_tick_position) / delta
    last_tick_position = position
    
    if actual_velocity.length() < GameInfo.MIN_VELOCITY:
        actual_velocity = Vector2(0, 0)
    
#    rotation_degrees = lerp_angle(rotation_degrees, puppet_rotation, delta * 8)
#
#    if not pos_tween.is_active():
#        var __ = move_and_slide(puppet_velocity)

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
    var to_mouse = Vector2(1, 0)
    if is_network_master():
        to_mouse = get_global_mouse_position() - position
    else:
        to_mouse = puppet_mouse_position - position
    
    face_towards(to_mouse)


func face_towards_velocity():
    face_towards(velocity)


# States

remote func set_state(name):
    var state = get_state(name)
    if not state:
        return

    if cur_state:
        cur_state.deactivate()
    
    cur_state = state
    cur_state_name = name
    cur_state.activate()

    if shared and is_network_master():
        rpc("set_state", name)
    
#    print("new active state is [", name, "]")


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
    if another is int:
        return another and team == another
    
    if not another is get_script():
        return false

    return team and (team == another.team)
