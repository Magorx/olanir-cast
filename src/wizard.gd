extends Creature


const energy_bolt_path = preload("res://projectile/collection/EnergyBalt.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func process_input():
    .process_input()
    
    if Input.is_action_pressed("primary_cast"):
        if $ReloadTimer.is_stopped():
            var bolt = energy_bolt_path.instance()
            var dir = (get_global_mouse_position() - position).normalized()
            var pos = position + dir * (($CollisionShape2D.shape as CircleShape2D).radius + (bolt.get_node("CollisionShape2D").shape as CircleShape2D).radius + 5)
            
            if (get_global_mouse_position() - position).dot(velocity) > 0:
                pos += velocity.normalized() * max_velocity * 0.05
            
            get_parent().add_child(bolt)
            
            bolt.on_fire(pos, dir)
            
            $ReloadTimer.start()
