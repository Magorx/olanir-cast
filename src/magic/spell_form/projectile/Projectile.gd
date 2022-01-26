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
    deactivate()

    $ExpireTimer.set_wait_time(live_time)
    $ExpireTimer.start()


func init_states():
    .init_states()
    
    states["idle"] = ProjectileStateIdle.new(self, funcref(self, "set_state"))
    set_state("idle")


func _process(_delta):
    if is_network_master():
        look_at(position + velocity)
    else:
        look_at(puppet_position + puppet_velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    var collision = move_and_collide(velocity * delta)
    
    if not is_network_master():
        return

    if collision:
        if collision is Unit:
            on_hit_unit(collision.get_collider() as Unit)
        
        on_hit(collision)


func activate():
    active = true
    $CollisionShape2D.set_deferred("disabled", false)


func deactivate():
    velocity = Vector2(0, 0)
    active = false
    $CollisionShape2D.set_deferred("disabled", true)


func on_fire(caster_, position_ : Vector2, direction : Vector2):
    caster = caster_

    position = position_
    velocity = direction.normalized() * max_velocity
    actual_velocity = velocity
    look_at(position + velocity)
    
    activate()
    
    set_state("idle")
    
    emit_signal("fired")


func stop():
    velocity = Vector2(0, 0)
    deactivate()


remote func on_hit(collision: KinematicCollision2D):
    if is_network_master():
        rpc("on_hit", collision)
    else:
        position = puppet_position

    emit_signal("hit", collision)
    on_expire()


remote func on_hit_unit(unit: Unit):
    if is_network_master():
        rpc("on_hit_unit")
    else:
        position = puppet_position

    emit_signal("hit_unit", unit)


remote func on_lifetime_expire():
    if is_network_master():
        rpc("on_lifetime_expire")

    emit_signal("lifetime_expired")
    on_expire()


remote func on_expire():
#    if is_network_master():
#        rpc("on_expire")

    emit_signal("expired")    
    if is_network_master():
        rpc("destroy")

remotesync func destroy():
    queue_free()
