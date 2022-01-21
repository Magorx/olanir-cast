extends Unit


class_name Projectile


signal fired
signal hit
signal hit_unit
signal lifetime_expired
signal expired

export var live_time: float = 1
export var safecast_shift: float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
    $ExpireTimer.set_wait_time(live_time)
    $ExpireTimer.start()

    pass # Replace with function body.


func _process(delta):
    look_at(position + velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    var collision = move_and_collide(velocity * delta)
    if collision:
        if collision is Unit:
            on_hit_unit(collision.get_collider() as Unit)
        
        on_hit(collision)


func on_fire(position_ : Vector2, direction : Vector2):
    emit_signal("fired")

    position = position_
    velocity = direction.normalized() * max_velocity
    look_at(position + velocity)


func on_hit(collision: KinematicCollision2D):
    emit_signal("hit", collision)
    
#    print("hit: ", (position - collision.collider.position).length())
#    print("me: ", ($CollisionShape2D.shape as CircleShape2D).radius)
#    print("him: ", (collision.collider.get_node("CollisionShape2D").shape as CircleShape2D).radius)
#    print("---- ", (position - collision.position).length())
#    print("vel ", velocity)

    velocity = Vector2(0, 0)
    on_expire()
    

func on_hit_unit(unit: Unit):
    emit_signal("hit_unit", unit)

    velocity = Vector2(0, 0)
    on_expire()
    

func on_lifetime_expire():
    emit_signal("lifetime_expired")

    velocity = Vector2(0, 0)
    on_expire()


func on_expire():
    emit_signal("expired")

    queue_free()
