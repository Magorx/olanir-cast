extends Node


var controlled: Unit


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

 
func _physics_process(_delta):
    if (controlled):
        controlled.process_input()


func set_controlled(unit: Unit):
    controlled = unit
