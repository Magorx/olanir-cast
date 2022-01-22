extends Unit


class_name Projectile


signal fired
signal hit
signal hit_unit
signal lifetime_expired
signal expired

export var live_time: float = 1
export var safecast_shift: float = 0


var caster


# Called when the node enters the scene tree for the first time.
func _ready():
    $ExpireTimer.set_wait_time(live_time)
    $ExpireTimer.start()

    pass # Replace with function body.


func _process(_delta):
    look_at(position + velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    var collision = move_and_collide(velocity * delta)
    if collision:
        if collision is Unit:
            on_hit_unit(collision.get_collider() as Unit)
        
        on_hit(collision)


func on_fire(caster_, position_ : Vector2, direction : Vector2):
    caster = caster_

    position = position_
    velocity = direction.normalized() * max_velocity
    look_at(position + velocity)
    
    emit_signal("fired")


func stop():
    velocity = Vector2(0, 0)
    set_deferred("disabled", true)


func on_hit(collision: KinematicCollision2D):
    emit_signal("hit", collision)

    stop()
    on_expire()


func on_hit_unit(unit: Unit):
    emit_signal("hit_unit", unit)

    stop()
    on_expire()


func on_lifetime_expire():
    emit_signal("lifetime_expired")

    stop()
    on_expire()


func on_expire():
    emit_signal("expired")

    queue_free()
