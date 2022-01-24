extends Node


var target: Node
var default_modulation: Color = Color(1, 1, 1, 1)
var current_modualtion: Color

var modulating: bool = false


func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if not modulating:
        return
    
    var coef = $Timer.time_left / $Timer.wait_time
    var modulation = lerp(default_modulation, current_modualtion, coef)
    target.set_modulate(modulation)


func setup(target_: Node2D):
    target = target_
    default_modulation = target.modulate


func moduate(color, time):
    current_modualtion = color
    $Timer.wait_time = time
    $Timer.start()
    
    modulating = true


func _on_Timer_timeout():
    modulating = false
