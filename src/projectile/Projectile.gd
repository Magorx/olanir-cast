extends Unit


class_name Projectile


export var live_time: float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
    print("hi", self.position)

    $ExpireTimer.set_wait_time(live_time)
    $ExpireTimer.start()

    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    var collision = move_and_collide(velocity * delta)
    if collision:
        if collision is Unit:
            on_hit_unit(collision.get_collider() as Unit)
        
        on_hit(collision)


func on_fire(position_ : Vector2, velocity_ : Vector2):
    position = position_
    velocity = velocity_.normalized() * max_velocity
    look_at(position + velocity)


func on_hit_unit(unit: Unit):
    velocity = Vector2(0, 0)
    on_expire()


func on_hit(collision):
    velocity = Vector2(0, 0)
    on_expire()
    

func on_lifetime_expire():
    on_expire()


func on_expire():
    queue_free()
