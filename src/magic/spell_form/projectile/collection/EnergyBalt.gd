extends Projectile


func _ready():
    pass


func on_hit(collision):
    .on_hit(collision)

#    if is_network_master():
    on_expire()


func on_expire():
    .on_expire()

    stop()
    $AnimatedSprite.play("boom")
    yield($AnimatedSprite, "animation_finished")
    
#    if is_network_master():
#        rpc("destroy")
    destroy()
