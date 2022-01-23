extends Node2D


var controlled: Unit

# Called when the node enters the scene tree for the first time.
func _ready():
    print("ready, ", $Camera2D)
    pass # Replace with function body.


func _process(delta):
    $Camera2D.magnitize_camera(controlled, delta)

 
func _physics_process(_delta):
    if (controlled):
        controlled.process_input()


func set_controlled(unit: Unit):
    controlled = unit
