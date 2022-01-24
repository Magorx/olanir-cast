extends Node2D


class_name Controller


var controlled: Unit

var active: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _process(delta):
    if not active:
        return

    $Camera2D.magnitize_camera(controlled, delta)

 
func _physics_process(_delta):
    if not active:
        return

    if (controlled):
        controlled.process_input()


func set_controlled(unit: Unit):
    controlled = unit


func activate():
    active = true


func deactivate():
    active = false
